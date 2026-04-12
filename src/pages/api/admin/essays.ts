export const prerender = false;
import type { APIContext } from 'astro';

export async function GET({ locals }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;
  const { results } = await db.prepare('SELECT * FROM essays ORDER BY sort_order').all();
  return new Response(JSON.stringify(results), { headers: { 'Content-Type': 'application/json' } });
}

export async function POST({ locals, request }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;
  const body = await request.json() as any;
  const { title, publication, url, quote, sort_order } = body;

  const result = await db
    .prepare('INSERT INTO essays (title, publication, url, quote, sort_order) VALUES (?, ?, ?, ?, ?) RETURNING id')
    .bind(title, publication, url ?? null, quote, sort_order ?? 0)
    .first<{ id: number }>();

  return new Response(JSON.stringify({ id: result!.id }), { status: 201, headers: { 'Content-Type': 'application/json' } });
}
