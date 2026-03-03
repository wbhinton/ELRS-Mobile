// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
  site: 'https://elrsmobile.com',
  base: '/',
  integrations: [
    starlight({
      title: 'ELRS Mobile',
      description: 'Advanced WiFi Flashing and Configuration for ExpressLRS',
      logo: {
        src: './src/assets/logo.png',
      },
      favicon: '/favicon.png',
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
  ],
});