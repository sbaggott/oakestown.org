export const prerender = false;
import type { APIContext } from 'astro';

export async function PUT({ locals, request, params }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;
  const id = Number(params.id);
  const body = await request.json() as any;
  const { title, publication, url, quote, sort_order } = body;

  await db
    .prepare('UPDATE essays SET title=?, publication=?, url=?, quote=?, sort_order=? WHERE id=?')
    .bind(title, publication, url ?? null, quote, sort_order ?? 0, id)
    .run();

  return new Response(JSON.stringify({ ok: true }), { headers: { 'Content-Type': 'application/json' } });
}

export async function DELETE({ locals, params }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;
  await db.prepare('DELETE FROM essays WHERE id=?').bind(Number(params.id)).run();
  return new Response(JSON.stringify({ ok: true }), { headers: { 'Content-Type': 'application/json' } });
}
