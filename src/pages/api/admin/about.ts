import type { APIContext } from 'astro';

export async function GET({ locals }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;
  const { results } = await db.prepare('SELECT * FROM about_paragraphs ORDER BY position').all();
  return new Response(JSON.stringify(results), { headers: { 'Content-Type': 'application/json' } });
}

export async function PUT({ locals, request }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;
  const body = await request.json() as any;
  const paragraphs: string[] = body.paragraphs ?? [];

  const statements = [
    db.prepare('DELETE FROM about_paragraphs'),
    ...paragraphs.map((content, i) =>
      db.prepare('INSERT INTO about_paragraphs (content, position) VALUES (?, ?)').bind(content, i + 1)
    ),
  ];

  await db.batch(statements);

  return new Response(JSON.stringify({ ok: true }), { headers: { 'Content-Type': 'application/json' } });
}
