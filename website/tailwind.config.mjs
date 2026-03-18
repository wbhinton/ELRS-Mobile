/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        primary: '#00bfa5',
        background: '#1e1e1e',
        surface: '#2d2d2d',
        'text-muted': '#bdbdbd',
      },
    },
  },
  plugins: [],
};
