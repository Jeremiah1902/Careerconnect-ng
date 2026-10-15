
import type { APIRoute } from 'astro';
import { jobs } from '../data/jobs.js';

export const GET: APIRoute = async ({ site }) => {
  const base = (site ?? new URL('https://careerconnectng.netlify.app'))
    .toString()
    .replace(/\/$/, '');

  const all = await jobs();

  const urls = [
    '',
    '/about',
    ...all.map((j: { slug: string }) => '/jobs/' + encodeURIComponent(j.slug)),
  ]
    .map(
      (path) =>
        `<url><loc>${base}${path}</loc></url>`
    )
    .join('');

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls}
</urlset>`;

  return new Response(xml, {
    headers: {
      'Content-Type': 'application/xml; charset=utf-8',
    },
  });
};
