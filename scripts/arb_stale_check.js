// Keeps translated ARB files in sync with edits to the English template.
//
// arb_translate only fills in keys that are *missing* from a locale, so
// rewording an existing English string would otherwise leave every
// translation silently carrying the old meaning. This script records a hash
// of each English value after a successful translation run, and on the next
// run deletes any key whose English value has since changed from all
// locales so arb_translate translates it again.
//
// Usage:
//   node scripts/arb_stale_check.js invalidate   # before arb_translate
//   node scripts/arb_stale_check.js record       # after a successful run
//
// `invalidate` also prunes keys that no longer exist in the template.

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const arbDir = path.join(__dirname, '../lib/l10n');
const templateFile = path.join(arbDir, 'app_en.arb');
const hashFile = path.join(__dirname, 'arb_source_hashes.json');

const readJson = (file) => JSON.parse(fs.readFileSync(file, 'utf8'));
const writeJson = (file, data) =>
  fs.writeFileSync(file, JSON.stringify(data, null, 2) + '\n');
const hash = (value) => crypto.createHash('md5').update(value).digest('hex');
const messageKeys = (arb) => Object.keys(arb).filter((k) => !k.startsWith('@'));

function templateHashes() {
  const template = readJson(templateFile);
  return Object.fromEntries(
    messageKeys(template).map((key) => [key, hash(template[key])]),
  );
}

function localeFiles() {
  return fs
    .readdirSync(arbDir)
    .filter((f) => f.endsWith('.arb') && f !== path.basename(templateFile))
    .map((f) => path.join(arbDir, f));
}

function invalidate() {
  const current = templateHashes();

  if (!fs.existsSync(hashFile)) {
    console.log(
      'No recorded English hashes yet — treating current translations as up to date.',
    );
    return;
  }

  const recorded = readJson(hashFile);
  const stale = Object.keys(current).filter(
    (key) => recorded[key] !== undefined && recorded[key] !== current[key],
  );
  if (stale.length) {
    console.log(`English changed for ${stale.length} key(s): ${stale.join(', ')}`);
  }

  for (const file of localeFiles()) {
    const arb = readJson(file);
    const removed = messageKeys(arb).filter(
      (key) => stale.includes(key) || current[key] === undefined,
    );
    if (!removed.length) continue;

    for (const key of removed) {
      delete arb[key];
      delete arb[`@${key}`];
    }
    writeJson(file, arb);
    console.log(`${path.basename(file)}: cleared ${removed.join(', ')}`);
  }
}

function record() {
  writeJson(hashFile, templateHashes());
  console.log(`Recorded English hashes to ${path.relative(process.cwd(), hashFile)}`);
}

const mode = process.argv[2];
if (mode === 'invalidate') {
  invalidate();
} else if (mode === 'record') {
  record();
} else {
  console.error('Usage: node scripts/arb_stale_check.js <invalidate|record>');
  process.exit(1);
}
