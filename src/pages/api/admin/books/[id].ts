import type { APIContext } from 'astro';

export async function PUT({ locals, request, params }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;
  const id = Number(params.id);
  const body = await request.json() as any;
  const { title, publisher, year, cover, sort_order, description, endorsements } = body;

  const stmts = [
    db.prepare('UPDATE books SET title=?, publisher=?, year=?, cover=?, sort_order=? WHERE id=?')
      .bind(title, publisher, year, cover ?? null, sort_order ?? 0, id),
    db.prepare('DELETE FROM book_descriptions WHERE book_id=?').bind(id),
    db.prepare('DELETE FROM book_endorsements WHERE book_id=?').bind(id),
  ];

  for (let i = 0; i < (description ?? []).length; i++) {
    stmts.push(
      db.prepare('INSERT INTO book_descriptions (book_id, paragraph, position) VALUES (?, ?, ?)')
        .bind(id, description[i], i + 1)
    );
  }

  for (let i = 0; i < (endorsements ?? []).length; i++) {
    stmts.push(
      db.prepare('INSERT INTO book_endorsements (book_id, quote, attribution, position) VALUES (?, ?, ?, ?)')
        .bind(id, endorsements[i].quote, endorsements[i].attribution, i + 1)
    );
  }

  await db.batch(stmts);

  return new Response(JSON.stringify({ ok: true }), { headers: { 'Content-Type': 'application/json' } });
}

export async function DELETE({ locals, params }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;
  await db.prepare('DELETE FROM books WHERE id=?').bind(Number(params.id)).run();
  return new Response(JSON.stringify({ ok: true }), { headers: { 'Content-Type': 'application/json' } });
}
