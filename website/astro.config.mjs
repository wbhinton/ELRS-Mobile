// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import sitemap from '@astrojs/sitemap';
import tailwind from '@astrojs/tailwind';
import localeConfig from './src/config/locales.json' with { type: 'json' };
import { analyticsId, links } from './src/config/site.ts';

const starlightLocales = Object.fromEntries(
  Object.entries(localeConfig.locales).map(([lang, label]) => [
    lang === localeConfig.defaultLocale ? 'root' : lang,
    { label, lang },
  ]),
);

// https://astro.build/config
export default defineConfig({
  site: 'https://elrsmobile.com',
  base: '/',
  integrations: [
    tailwind(),
    starlight({
      title: 'ELRS Mobile',
      description: 'Flash and configure ExpressLRS receivers and transmitters directly from your iOS or Android device. 100% offline flashing, no PC or cables required.',
      logo: {
        src: './src/assets/logo.png',
      },
      favicon: '/favicon.png',
      locales: starlightLocales,
      head: [
        {
          tag: 'script',
          attrs: {
            src: `https://www.googletagmanager.com/gtag/js?id=${analyticsId}`,
            async: true,
          },
        },
        {
          tag: 'script',
          content: `
						window.dataLayer = window.dataLayer || [];
						function gtag(){dataLayer.push(arguments);}
						gtag('js', new Date());
						gtag('config', '${analyticsId}');
					`,
        },
        {
          tag: 'script',
          attrs: {
            src: 'https://storage.ko-fi.com/cdn/scripts/overlay-widget.js',
          },
        },
        {
          tag: 'script',
          content: `
            window.addEventListener('DOMContentLoaded', () => {
              if (typeof kofiWidgetOverlay !== 'undefined') {
                kofiWidgetOverlay.draw('wbhinton', {
                  'type': 'floating-chat',
                  'floating-chat.donateButton.text': 'Support me',
                  'floating-chat.donateButton.background-color': '#FFB114',
                  'floating-chat.donateButton.text-color': '#fff'
                });
              }
            });
          `,
        },
      ],
      social: [
        {
          label: 'GitHub',
          href: links.repo,
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