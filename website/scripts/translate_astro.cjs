const fs = require('fs');
const path = require('path');
const https = require('https');
const crypto = require('crypto');

const apiKey = process.env.ARB_TRANSLATE_API_KEY || process.env.GEMINI_API_KEY;

if (!apiKey) {
  console.log("No API key found for Astro translation. Skipping.");
  process.exit(0);
}

const targetLocales = ['de', 'es', 'fr', 'ja', 'uk', 'pt', 'it', 'pl', 'ko', 'ru', 'nl', 'cs', 'th', 'sv', 'id', 'zh', 'nb'];

// Paths
const docsDir = path.join(__dirname, '../src/content/docs/guides');
const uiFile = path.join(__dirname, '../src/i18n/ui.json');

// Helper to make API calls to Gemini
function translateText(text, targetLang, context = '') {
  return new Promise((resolve, reject) => {
    const postData = JSON.stringify({
      contents: [{
        parts: [{
          text: `Translate the following ${context} into language code '${targetLang}'. Retain all formatting, links, and code blocks exactly. Do not translate technical terms like ExpressLRS, mDNS, WiFi SSID, UART, Baud, STM32, ESP32, ESP8285, FCC, LBT, or brand names:\n\n${text}`
        }]
      }]
    });

    const options = {
      hostname: 'generativelanguage.googleapis.com',
      path: `/v1beta/models/gemini-2.5-flash:generateContent?key=${apiKey}`,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(postData)
      }
    };

    const req = https.request(options, (res) => {
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => {
        try {
          const json = JSON.parse(data);
          if (json.candidates && json.candidates[0].content && json.candidates[0].content.parts[0].text) {
            resolve(json.candidates[0].content.parts[0].text.trim());
          } else {
            reject(new Error(`Invalid response: ${data}`));
          }
        } catch (e) {
          reject(e);
        }
      });
    });

    req.on('error', (e) => reject(e));
    req.write(postData);
    req.end();
  });
}

// 1. Translate UI Dictionary JSON
async function translateUi() {
  console.log("Starting UI translation...");
  if (!fs.existsSync(uiFile)) {
    console.error(`UI file not found: ${uiFile}`);
    return;
  }

  const uiData = JSON.parse(fs.readFileSync(uiFile, 'utf8'));
  const englishKeys = uiData.en;

  if (!uiData._hashes) {
    uiData._hashes = {};
  }

  for (const locale of targetLocales) {
    if (!uiData[locale]) {
      uiData[locale] = {};
    }
    if (!uiData._hashes[locale]) {
      uiData._hashes[locale] = {};
    }

    const missingKeys = {};
    for (const key of Object.keys(englishKeys)) {
      const sourceVal = englishKeys[key];
      const sourceHash = crypto.createHash('md5').update(sourceVal).digest('hex');
      
      const existingTranslation = uiData[locale][key];
      const existingHash = uiData._hashes[locale][key];
      
      if (!existingTranslation || existingHash !== sourceHash) {
        missingKeys[key] = sourceVal;
      }
    }

    const missingKeyCount = Object.keys(missingKeys).length;
    if (missingKeyCount === 0) {
      console.log(`UI translations for ${locale} are up to date.`);
      continue;
    }

    console.log(`Translating ${missingKeyCount} UI keys for ${locale}...`);
    try {
      const prompt = `JSON values (keys must match exactly, translate only values):\n${JSON.stringify(missingKeys, null, 2)}`;
      const responseText = await translateText(prompt, locale, 'JSON object');
      
      // Robust JSON extraction: find first '{' and last '}'
      let cleanJson = responseText;
      const startIdx = responseText.indexOf('{');
      const endIdx = responseText.lastIndexOf('}');
      if (startIdx !== -1 && endIdx !== -1) {
        cleanJson = responseText.substring(startIdx, endIdx + 1);
      }
      cleanJson = cleanJson.trim();

      const translatedKeys = JSON.parse(cleanJson);
      for (const key of Object.keys(missingKeys)) {
        if (translatedKeys[key]) {
          uiData[locale][key] = translatedKeys[key];
          
          const sourceHash = crypto.createHash('md5').update(englishKeys[key]).digest('hex');
          uiData._hashes[locale][key] = sourceHash;
        } else {
          // Fallback
          uiData[locale][key] = missingKeys[key];
        }
      }
      
      fs.writeFileSync(uiFile, JSON.stringify(uiData, null, 2) + '\n', 'utf8');
      console.log(`Saved UI translations for ${locale}.`);
    } catch (e) {
      console.error(`Failed to translate UI for ${locale}:`, e);
    }
  }
}

// 2. Translate Markdown Documentation (Starlight Guides)
async function translateDocs() {
  console.log("Starting Documentation translation...");
  if (!fs.existsSync(docsDir)) {
    console.error(`Docs directory not found: ${docsDir}`);
    return;
  }

  const files = fs.readdirSync(docsDir).filter(file => file.endsWith('.md') || file.endsWith('.mdx'));

  for (const file of files) {
    const filePath = path.join(docsDir, file);
    const content = fs.readFileSync(filePath, 'utf8');

    // Parse frontmatter
    const match = content.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n([\s\S]*)$/);
    if (!match) {
      console.log(`Skipping file without valid frontmatter: ${file}`);
      continue;
    }

    const rawYaml = match[1];
    const mdBody = match[2];

    const titleMatch = rawYaml.match(/^title:\s*(.+)$/m);
    if (!titleMatch) {
      console.log(`Skipping file without title in frontmatter: ${file}`);
      continue;
    }
    const englishTitle = titleMatch[1].replace(/['"]/g, '').trim();

    // Hash source content to detect changes
    const sourceHash = crypto.createHash('md5').update(content).digest('hex');
    const hashMarker = `<!-- source_hash: ${sourceHash} -->`;

    for (const locale of targetLocales) {
      const destDir = path.join(docsDir, `../${locale}/guides`);
      if (!fs.existsSync(destDir)) {
        fs.mkdirSync(destDir, { recursive: true });
      }

      const destPath = path.join(destDir, file);

      // Check cache
      if (fs.existsSync(destPath)) {
        const existingContent = fs.readFileSync(destPath, 'utf8');
        if (existingContent.includes(hashMarker)) {
          console.log(`Docs translation for ${file} in ${locale} is up to date. Skipping.`);
          continue;
        }
      }

      console.log(`Translating documentation ${file} into ${locale}...`);
      try {
        // Translate Title
        const translatedTitle = await translateText(englishTitle, locale, 'short title text');
        
        // Translate Body
        const translatedBody = await translateText(mdBody, locale, 'markdown document body');

        // Construct target frontmatter replacing only title and updating slug if present
        let targetYaml = rawYaml.replace(/^title:\s*(.+)$/m, `title: ${JSON.stringify(translatedTitle)}`);
        if (targetYaml.includes('slug:')) {
          targetYaml = targetYaml.replace(/^slug:\s*(.+)$/m, `slug: ${locale}/$1`);
        }
        
        const finalContent = `---\n${targetYaml}\n---\n\n${translatedBody}\n\n${hashMarker}`;
        fs.writeFileSync(destPath, finalContent, 'utf8');
        console.log(`Saved translated documentation to ${destPath}`);
      } catch (e) {
        console.error(`Failed to translate docs file ${file} to ${locale}:`, e);
      }
    }
  }
}

async function run() {
  await translateUi();
  await translateDocs();
}

run();
