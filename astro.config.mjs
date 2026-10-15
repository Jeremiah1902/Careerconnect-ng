import { defineConfig } from 'astro/config';
import netlify from '@astrojs/netlify';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://careerconnectng.netlify.app',
  output: 'server',
  adapter: netlify({
    devFeatures: {
      edgeFunctions: false,
    },
  }),
  integrations: [sitemap()],
});