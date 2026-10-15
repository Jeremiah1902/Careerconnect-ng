import { defineConfig } from 'astro/config';
import netlify from '@astrojs/netlify';
export default defineConfig({site:'https://careerconnectng.netlify.app',output:'server',adapter:netlify(
    {
    devFeatures: {
      edgeFunctions: false,
    },
  })
});