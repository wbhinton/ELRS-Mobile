---
title: Firmware Validation Tools
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

ELRS Mobile builds firmware on the phone instead of using the official build tools, so its output must match theirs. This guide covers the tools in `firmware_testing/` that check ELRS Mobile's binaries against official "golden" binaries.

:::note[Web Flasher vs. Configurator binaries]
Binaries built by ELRS Mobile match the official **ExpressLRS Web Flasher** byte for byte, but differ slightly from those built by the **ExpressLRS Configurator**. The difference is JSON whitespace: the Configurator writes the options block with spaces after colons (`{"uid": [1,2,3]}`), while ELRS Mobile and the Web Flasher write it without (`{"uid":[1,2,3]}`). The device's JSON parser ignores whitespace, so both run identically on hardware, but a strict SHA-256 comparison fails. Compare the decoded configuration instead, as the Ground Truth Auditor does.
:::

---

## 1. Logic Validator (Dart)

**Location:** `firmware_testing/scripts/dart/logic_validator.dart`

Compares two binaries bit by bit and pinpoints the exact bit offset of each difference. It uses the same `package:binary` types as the app, so its analysis matches the app's own assembly logic.

- Lists every `.bin` and `.gz` file in its folder and in `firmware_testing/binaries/` for you to choose from.
- Writes detailed discrepancy logs to `firmware_testing/logs/`.

```bash
cd firmware_testing/scripts/dart/
dart pub get
dart run logic_validator.dart
```

---

## 2. Ground Truth Auditor (Python)

**Location:** `firmware_testing/scripts/python/audit_tool.py`

A dependency-free script that decodes the 2,704-byte configuration block appended to every unified ExpressLRS firmware image: product name (128 bytes), Lua name (16 bytes), options JSON (512 bytes) and hardware layout (2,048 bytes). It verifies that what would be flashed to the device is correct, independent of layout differences in the base firmware code. It reads `.bin` and gzipped `.gz` files.

```bash
python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
```

---

## 3. Cross-validation workflow

Periodically check ELRS Mobile's output against a binary built on a PC:

1. **Export from ELRS Mobile.** Turn on **Expert Mode** in Settings, configure the target, version and options on the flashing screen, and tap **Download Binary**.
2. **Build the ground truth.** Build the exact same target and version with identical options using the ExpressLRS Web Flasher or Configurator.
3. **Audit.** Put both files in `firmware_testing/binaries/` and run `audit_tool.py` on them to confirm the hardware layout and options match. Use the Logic Validator to locate any byte-level differences.

Golden binaries used in past audits are kept in `firmware_testing/binaries/`. The [Supported Hardware](/supported_hardware) page lists the targets verified this way under **Tested Binaries**.
