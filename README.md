# Careerconnect NG — starter project

Responsive Astro job board with mobile layout, individual vacancy URLs, search/filtering, SEO metadata, JobPosting structured data, sitemap/robots.txt, Supabase-backed admin login, manual vacancy management and CSV bulk import.

## A. Run in VS Code
1. Install Node.js 22+ and VS Code.
2. Extract this folder and open it in VS Code.
3. Select Terminal > New Terminal.
4. Run `npm install`, then `npm run dev`.
5. Open the local URL shown (usually http://localhost:4321).
6. Demo listings appear before Supabase is configured. They are examples, not real jobs.

## B. Configure the real admin dashboard
1. Create a project at https://supabase.com/.
2. Open SQL Editor, paste all of `supabase-schema.sql`, and run it.
3. Copy your Supabase Project URL and publishable/anon key from Project Settings/API.
4. Copy `.env.example` to a new file named `.env`; fill in `PUBLIC_SUPABASE_URL` and `PUBLIC_SUPABASE_ANON_KEY`. Never use a service-role/secret key in browser code.
5. Restart `npm run dev`.
6. In Supabase Authentication > Users, create an admin user with your email and a strong password.
7. Copy that user's UUID. In SQL Editor run `insert into public.admin_users(user_id) values ('PASTE-USER-UUID-HERE');` with the real UUID.
8. Open `/admin` on your local site and sign in. RLS policies limit edits to authorized admin users.
9. Add jobs manually or download `public/jobs-template.csv`, fill it with verified listings, then import it in the dashboard. Required CSV columns: title, company, location, category, description, application_url. Check for duplicate slugs before importing; a duplicate will be rejected.

## C. Deploy to Netlify
1. Create a new GitHub repository.
2. Push the project folder to GitHub using VS Code Source Control or GitHub Desktop.
3. In Netlify choose Add new project > Import an existing project, connect GitHub, and choose the repository.
4. Build command `npm run build`; publish directory `dist`. `netlify.toml` already declares these.
5. In Netlify site environment variables, add `PUBLIC_SUPABASE_URL` and `PUBLIC_SUPABASE_ANON_KEY` (same values as `.env`). Do not upload `.env` to GitHub.
6. Deploy. Test homepage, a job URL, `/admin`, CSV import and admin permissions.
7. Netlify gives the site a URL ending in `.netlify.app`. Update `site` in `astro.config.mjs` to your actual final HTTPS URL, then commit and push again. This updates canonical links and sitemap.

## Notes
- The site is a starter, so test it thoroughly before public launch.
- Job descriptions and application links must be checked for accuracy. Don't publish sample data as real vacancies.
- Google indexing/rankings are not guaranteed. Connect Google Search Console after deployment.
- Supabase and Netlify plan limits may change; review current plan terms before relying on free tiers.
