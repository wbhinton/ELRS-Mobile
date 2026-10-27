// Fails if any built page links to a site-relative URL that doesn't exist in dist/.
// Run after `astro build`: `npm run check:links`.
import { readdirSync, readFileSync, existsSync, statSync } from 'node:fs';
import { join, relative } from 'node:path';

const dist = new URL('../dist/', import.meta.url).pathname;

function* htmlFiles(dir) {
	for (const entry of readdirSync(dir, { withFileTypes: true })) {
		const path = join(dir, entry.name);
		if (entry.isDirectory()) yield* htmlFiles(path);
		else if (entry.name.endsWith('.html')) yield path;
	}
}

function exists(urlPath) {
	const target = join(dist, decodeURIComponent(urlPath));
	if (existsSync(target) && statSync(target).isFile()) return true;
	return existsSync(join(target, 'index.html')) || existsSync(`${target}.html`);
}

const broken = new Map();
for (const file of htmlFiles(dist)) {
	const html = readFileSync(file, 'utf8');
	for (const [, url] of html.matchAll(/\s(?:href|src)="(\/(?!\/)[^"#?]*)/g)) {
		if (!exists(url)) broken.set(url, [...(broken.get(url) ?? []), relative(dist, file)]);
	}
}

if (broken.size) {
	for (const [url, pages] of broken) console.error(`Broken link ${url} (on ${pages.length} pages, e.g. ${pages[0]})`);
	process.exit(1);
}
console.log('No broken internal links.');
