import struct
import hashlib
import os
import sys
import argparse
import gzip
import json
from datetime import datetime

# ExpressLRS Ground Truth Auditor
# 
# Role: Independent "Ground Truth" Verification (Community/External)
# Purpose: Standalone audit without needing a Dart environment.
# 
# Architectural Requirements:
# 1. Zero-Dependency (struct, hashlib, os, sys, argparse, gzip only)
# 2. Integrity Workflow (SHA-256 first, exit if match)
# 3. Configurable Option Parser (Offset mapping)
# 4. Binary Unpacking (struct.unpack with explicit formats)

# ExpressLRS EspUnified Block Offsets (Relative to EOF - 2704)
CONFIG_BLOCK_SIZE = 2704
OFFSETS = {
    "Product Name": (0, 128, "128s"),
    "Lua Name": (128, 16, "16s"),
    "Options JSON": (144, 512, "512s"),
    "Hardware JSON": (656, 2048, "2048s"),
}

# Resolve project root based on script location
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.abspath(os.path.join(SCRIPT_DIR, "../../.."))

def get_firmware_data(path):
    """Loads firmware data, transparently decompressing if it is a .gz file."""
    if path.endswith(".gz"):
        with gzip.open(path, "rb") as f:
            return f.read()
    else:
        with open(path, "rb") as f:
            return f.read()

def get_data_hash(data):
    """Generates SHA-256 hash of byte data."""
    return hashlib.sha256(data).hexdigest()

def extract_config_from_data(data):
    """Extracts ELRS configuration from the end of the byte data."""
    if len(data) < CONFIG_BLOCK_SIZE:
        return None
    
    # Slice the last 2704 bytes
    block = data[-CONFIG_BLOCK_SIZE:]
    
    results = {}
    for name, (offset, size, fmt) in OFFSETS.items():
        raw_val = struct.unpack_from(fmt, block, offset)[0]
        if isinstance(raw_val, bytes):
            results[name] = raw_val.split(b'\x00')[0].decode('utf-8', errors='ignore')
        else:
            results[name] = raw_val
    return results

def find_binaries():
    binaries_dir = os.path.join(PROJECT_ROOT, "firmware_testing", "binaries")
    
    search_dirs = [os.getcwd(), binaries_dir]
    found_files = []
    
    extensions = (".bin", ".gz")
    for d in search_dirs:
        if os.path.exists(d):
            for f in os.listdir(d):
                if f.lower().endswith(extensions):
                    full_path = os.path.join(d, f)
                    if os.path.isfile(full_path):
                        try:
                            rel = os.path.relpath(full_path)
                            found_files.append(rel)
                        except ValueError:
                            found_files.append(full_path)
    
    return sorted(list(set(found_files)))

def interactive_select(files):
    if not files:
        print("\nERROR: No .bin or .gz files found.")
        sys.exit(1)

    print("\nAvailable Firmware Binaries:")
    for i, f in enumerate(files):
        print(f"[{i}] {f}")
    print("[q] Quit")

    try:
        idx1 = input("\nSelect first file index: ")
        if idx1.lower() == 'q': sys.exit(0)
        idx2 = input("Select second file index: ")
        if idx2.lower() == 'q': sys.exit(0)

        return files[int(idx1)], files[int(idx2)]
    except (ValueError, IndexError):
        print("Invalid selection.")
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description="ELRS Ground Truth Auditor")
    parser.add_argument("file1", nargs='?', help="First binary for comparison")
    parser.add_argument("file2", nargs='?', help="Second binary for comparison")
    args = parser.parse_args()

    f1_path, f2_path = args.file1, args.file2

    if not f1_path or not f2_path:
        binaries = find_binaries()
        f1_path, f2_path = interactive_select(binaries)

    print(f"\nLoading {f1_path}...")
    data1 = get_firmware_data(f1_path)
    print(f"Loading {f2_path}...")
    data2 = get_firmware_data(f2_path)

    # Integrity Workflow
    hash1 = get_data_hash(data1)
    hash2 = get_data_hash(data2)

    if hash1 == hash2:
        print(f"SUCCESS: Binaries are identical (SHA-256: {hash1})")
        sys.exit(0)

    print("\nBinaries differ. Performing deep inspection...")

    config1 = extract_config_from_data(data1)
    config2 = extract_config_from_data(data2)

    if config1 is None or config2 is None:
        print("ERROR: One or both files are too small to contain ELRS config blocks.")
        sys.exit(1)

    log_dir = os.path.join(PROJECT_ROOT, "firmware_testing", "logs")
    log_path = os.path.join(log_dir, f"audit_{int(datetime.now().timestamp())}.log")
    os.makedirs(log_dir, exist_ok=True)

    with open(log_path, "w") as log:
        log.write(f"Ground Truth Audit Report - {datetime.now()}\n")
        log.write(f"File 1: {f1_path} ({hash1})\n")
        log.write(f"File 2: {f2_path} ({hash2})\n\n")

        diverged = False
        for field in OFFSETS.keys():
            val1 = config1.get(field)
            val2 = config2.get(field)

            if field == "Options JSON":
                try:
                    dict1 = json.loads(val1)
                    dict2 = json.loads(val2)
                    dict1.pop('flash-discriminator', None)
                    dict2.pop('flash-discriminator', None)
                    
                    if dict1 == dict2:
                        log.write("MATCH: Options JSON (ignoring randomized discriminator)\n")
                        continue
                except json.JSONDecodeError:
                    pass # Fallback to standard string comparison if not valid JSON

            if val1 != val2:
                diverged = True
                msg = f"DIVERGENCE in {field}:\n  File 1: {val1}\n  File 2: {val2}\n"
                print(msg)
                log.write(msg)
            else:
                log.write(f"MATCH: {field}\n")

    if not diverged:
        print("Config blocks match perfectly, differences are in firmware segments.")
    else:
        print(f"\nAudit complete. Details written to {log_path}")

if __name__ == "__main__":
    main()
