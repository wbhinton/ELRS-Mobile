// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import sitemap from '@astrojs/sitemap';
import tailwind from '@astrojs/tailwind';
import localeConfig from './src/config/locales.json' with { type: 'json' };
import { analyticsId, links } from './src/config/site.ts';
import docsConfig from './src/config/docs.json' with { type: 'json' };
import ui from './src/i18n/ui.json' with { type: 'json' };

const starlightLocales = Object.fromEntries(
  Object.entries(localeConfig.locales).map(([lang, label]) => [
    lang === localeConfig.defaultLocale ? 'root' : lang,
    { label, lang },
  ]),
);

// Sidebar groups from src/config/docs.json, labels translated from ui.json.
const sidebar = docsConfig.groups.map((group) => ({
  label: ui.en[group.label],
  translations: Object.fromEntries(
    Object.keys(localeConfig.locales)
      .filter((lang) => lang !== localeConfig.defaultLocale && ui[lang]?.[group.label])
      .map((lang) => [lang, ui[lang][group.label]]),
  ),
  items: group.slugs.map((slug) => ({ slug })),
}));

const site = 'https://elrsmobile.com';
const ogImage = `${site}/images/og-image.png`;

// https://astro.build/config
export default defineConfig({
  site,
  base: '/',
  // Video thumbnails are fetched and optimised at build time.
  image: { domains: ['i.ytimg.com'] },
  integrations: [
    tailwind({ applyBaseStyles: false }),
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
            // One delegated listener: any element with data-track="<event>" sends
            // that event, with its other data-* attributes as parameters.
            document.addEventListener('click', (e) => {
              const el = e.target.closest('[data-track]');
              if (!el) return;
              const { track, ...params } = el.dataset;
              gtag('event', track, params);
            });
          `,
        },
        { tag: 'meta', attrs: { property: 'og:image', content: ogImage } },
        { tag: 'meta', attrs: { property: 'og:image:width', content: '1200' } },
        { tag: 'meta', attrs: { property: 'og:image:height', content: '630' } },
        { tag: 'meta', attrs: { name: 'twitter:image', content: ogImage } },
      ],
      components: {
        Header: './src/components/starlight/Header.astro',
        Footer: './src/components/starlight/Footer.astro',
        ThemeProvider: './src/components/starlight/ThemeProvider.astro',
        ThemeSelect: './src/components/starlight/ThemeSelect.astro',
      },
      social: [
        {
          label: 'GitHub',
          href: links.repo,
          icon: 'github',
        },
      ],
      customCss: ['./src/styles/tailwind.css', './src/styles/custom.css'],
      sidebar,
    }),
    sitemap(),
  ],
});