"""Check machine translations for mechanical damage.

Fails (exit 1) on problems a model or the translation scripts can introduce:
  - U+FFFD replacement characters (mangled UTF-8)
  - `{placeholder}` sets that differ from English in ui.json
  - HTML tags inside ui.json strings
  - link targets in translated docs that differ from the English source
  - MDX docs missing the component import or tag
  - Starlight aside (:::note etc.) sequences that differ from English

Warns (exit 0) on missing or out-of-date translations, which are expected
between adding English text and the next manual translation run.

Usage: python3 website/scripts/check_translations.py
"""

import hashlib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WEBSITE = ROOT / "website"
DOCS = WEBSITE / "src/content/docs"
UI = WEBSITE / "src/i18n/ui.json"
FAQ = ROOT / "assets/docs"

PLACEHOLDER = re.compile(r"\{\w+\}")
LINK = re.compile(r"\]\(([^)\s]+)\)")
ASIDE = re.compile(r"^:::(\w+)", re.M)
STAMP = re.compile(r"source_hash: ([0-9a-f]{32})")

errors, warnings = [], []


def check_ui():
    ui = json.loads(UI.read_text())
    en = ui["en"]
    for lang, strings in ui.items():
        if lang in ("en", "_hashes"):
            continue
        missing = [k for k in en if k not in strings]
        if missing:
            warnings.append(f"ui.json [{lang}]: {len(missing)} untranslated strings (English fallback)")
        for key, text in strings.items():
            where = f"ui.json [{lang}] {key}"
            if "�" in text:
                errors.append(f"{where}: replacement character (corrupted UTF-8)")
            if key in en and sorted(PLACEHOLDER.findall(text)) != sorted(PLACEHOLDER.findall(en[key])):
                errors.append(f"{where}: placeholders differ from English")
            if re.search(r"<[a-zA-Z]", text):
                errors.append(f"{where}: contains HTML")


def translated_slugs():
    groups = json.loads((WEBSITE / "src/config/docs.json").read_text())["groups"]
    return {slug for g in groups if g["translate"] for slug in g["slugs"]}


def check_docs():
    slugs = translated_slugs()
    for source in sorted((DOCS / "guides").iterdir()):
        text = source.read_text()
        slug = re.search(r"^slug:\s*(.+)$", text, re.M)
        if not slug or slug.group(1).strip() not in slugs:
            continue
        source_hash = hashlib.md5(source.read_bytes()).hexdigest()
        links, asides = sorted(set(LINK.findall(text))), ASIDE.findall(text)
        for copy in sorted(DOCS.glob(f"*/guides/{source.name}")):
            where = copy.relative_to(ROOT)
            body = copy.read_text()
            if "�" in body:
                errors.append(f"{where}: replacement character (corrupted UTF-8)")
            if sorted(set(LINK.findall(body))) != links:
                diff = set(LINK.findall(body)) ^ set(links)
                errors.append(f"{where}: link targets differ from English: {sorted(diff)}")
            if ASIDE.findall(body) != asides:
                errors.append(f"{where}: callouts differ from English")
            if source.suffix == ".mdx":
                for needle in re.findall(r"^import .+$", text, re.M) + re.findall(r"<[A-Z]\w+ />", text):
                    if needle not in body:
                        errors.append(f"{where}: missing `{needle}`")
            stamp = STAMP.search(body)
            if not stamp:
                warnings.append(f"{where}: no translation stamp (will be retranslated)")
            elif stamp.group(1) != source_hash:
                warnings.append(f"{where}: English source changed since translation")


def check_faq():
    for faq in sorted(FAQ.glob("app_faq_*.md")):
        if "�" in faq.read_text():
            errors.append(f"{faq.relative_to(ROOT)}: replacement character (corrupted UTF-8)")


check_ui()
check_docs()
check_faq()
for w in warnings:
    print(f"warning: {w}")
for e in errors:
    print(f"error: {e}")
print(f"{len(errors)} errors, {len(warnings)} warnings")
sys.exit(1 if errors else 0)
