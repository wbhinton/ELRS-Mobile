// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import sitemap from '@astrojs/sitemap';
import tailwind from '@astrojs/tailwind';

// https://astro.build/config
export default defineConfig({
  site: 'https://elrsmobile.com',
  base: '/',
  i18n: {
    defaultLocale: 'en',
    locales: ['en', 'de', 'es', 'fr', 'ja', 'uk'],
    routing: {
      prefixDefaultLocale: false,
    }
  },
  integrations: [
    tailwind(),
    starlight({
      title: 'ELRS Mobile',
      description: 'Flash and configure ExpressLRS receivers and transmitters directly from your iOS or Android device. 100% offline flashing, no PC or cables required.',
      logo: {
        src: './src/assets/logo.png',
      },
      favicon: '/favicon.png',
      locales: {
        root: {
          label: 'English',
          lang: 'en',
        },
        de: { label: 'Deutsch', lang: 'de' },
        es: { label: 'Español', lang: 'es' },
        fr: { label: 'Français', lang: 'fr' },
        ja: { label: '日本語', lang: 'ja' },
        uk: { label: 'Українська', lang: 'uk' },
      },
      head: [
        {
          tag: 'script',
          attrs: {
            src: 'https://www.googletagmanager.com/gtag/js?id=G-8X6YE82V0S',
            async: true,
          },
        },
        {
          tag: 'script',
          content: `
						window.dataLayer = window.dataLayer || [];
						function gtag(){dataLayer.push(arguments);}
						gtag('js', new Date());
						gtag('config', 'G-8X6YE82V0S');
					`,
        },
      ],
      social: [
        {
          label: 'GitHub',
          href: 'https://github.com/wbhinton/ELRS-Mobile',
          icon: 'github',
        },
      ],
      customCss: ['./src/styles/custom.css'],
      sidebar: [
        {
          label: 'Guides',
          autogenerate: { directory: 'guides' },
        },
      ],
    }),
    sitemap(),
  ],
});