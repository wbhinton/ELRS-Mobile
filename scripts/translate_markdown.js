const fs = require('fs');
const path = require('path');
const https = require('https');
const crypto = require('crypto');

const apiKey = process.env.ARB_TRANSLATE_API_KEY || process.env.GEMINI_API_KEY;

if (!apiKey) {
  console.log("No API key found for Markdown translation. Skipping.");
  process.exit(0);
}

const targetLocales = ['de', 'es', 'fr', 'ja', 'uk', 'pt', 'it', 'pl', 'ko', 'ru', 'nl', 'cs', 'th', 'sv', 'id', 'zh'];
const sourceFile = path.join(__dirname, '../assets/docs/app_faq.md');
const content = fs.readFileSync(sourceFile, 'utf8');

// Compute MD5 hash of the source file content
const sourceHash = crypto.createHash('md5').update(content).digest('hex');
const hashMarker = `<!-- source_hash: ${sourceHash} -->`;

function translate(text, targetLang) {
  return new Promise((resolve, reject) => {
    const postData = JSON.stringify({
      contents: [{
        parts: [{
          text: `Translate the following markdown document into language code '${targetLang}'. Retain all markdown formatting, headers, links, and code blocks exactly. Do not translate technical terms like ExpressLRS, mDNS, WiFi SSID, UART, Baud, STM32, ESP32, ESP8285, FCC, LBT, or brand names:\n\n${text}`
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
            resolve(json.candidates[0].content.parts[0].text);
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

async function run() {
  for (const locale of targetLocales) {
    const targetFile = path.join(__dirname, `../assets/docs/app_faq_${locale}.md`);
    
    // Check if target file already exists and has matching hash marker
    if (fs.existsSync(targetFile)) {
      const existingContent = fs.readFileSync(targetFile, 'utf8');
      if (existingContent.includes(hashMarker)) {
        console.log(`FAQ translation for ${locale} is up to date (hash matches). Skipping.`);
        continue;
      }
    }

    console.log(`Translating FAQ to ${locale}...`);
    try {
      const translated = await translate(content, locale);
      // Append the hash marker to the translated file
      const finalContent = `${translated}\n\n${hashMarker}`;
      fs.writeFileSync(targetFile, finalContent, 'utf8');
      console.log(`Saved translated FAQ to ${targetFile}`);
    } catch (e) {
      console.error(`Failed to translate FAQ to ${locale}:`, e);
    }
  }
}

run();

