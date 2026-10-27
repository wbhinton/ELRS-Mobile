import starlightPlugin from '@astrojs/starlight-tailwind';

// Brand palette — the single source for both Tailwind utilities and Starlight's
// --sl-color-* variables (mapped by starlightPlugin from `accent` and `gray`).
const accent = {
	200: '#64ffda',
	600: '#00bfa5',
	900: '#004d40',
	950: '#00332b',
};

const gray = {
	100: '#f5f7f8',
	200: '#eceff1',
	300: '#b0bec5',
	400: '#78909c',
	500: '#607d8b',
	600: '#546e7a',
	700: '#37474f',
	800: '#2d2d2d', // surfaces: nav, sidebar, cards
	900: '#1e1e1e', // page background
};

/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
	theme: {
		extend: {
			colors: {
				accent,
				gray,
				// Semantic aliases used throughout components and docs.
				primary: accent[600],
				background: gray[900],
				surface: gray[800],
				'text-muted': '#bdbdbd',
			},
		},
	},
	plugins: [starlightPlugin()],
};
