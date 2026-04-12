import type { APIContext } from 'astro';

export async function GET({ locals }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;

  const { results: books } = await db.prepare('SELECT * FROM books ORDER BY sort_order').all();
  const { results: descs } = await db.prepare('SELECT * FROM book_descriptions ORDER BY book_id, position').all();
  const { results: endorsements } = await db.prepare('SELECT * FROM book_endorsements ORDER BY book_id, position').all();

  const assembled = books.map((book: any) => ({
    id: book.id,
    title: book.title,
    publisher: book.publisher,
    year: book.year,
    cover: book.cover,
    sort_order: book.sort_order,
    description: descs.filter((d: any) => d.book_id === book.id).map((d: any) => d.paragraph),
    endorsements: endorsements.filter((e: any) => e.book_id === book.id).map((e: any) => ({
      id: e.id,
      quote: e.quote,
      attribution: e.attribution,
    })),
  }));

  return new Response(JSON.stringify(assembled), { headers: { 'Content-Type': 'application/json' } });
}

export async function POST({ locals, request }: APIContext) {
  const db = locals.runtime.env.prod_d1_oakestown;
  const body = await request.json() as any;
  const { title, publisher, year, cover, sort_order, description, endorsements } = body;

  const bookResult = await db
    .prepare('INSERT INTO books (title, publisher, year, cover, sort_order) VALUES (?, ?, ?, ?, ?) RETURNING id')
    .bind(title, publisher, year, cover ?? null, sort_order ?? 0)
    .first<{ id: number }>();

  const bookId = bookResult!.id;

  const stmts = [];

  for (let i = 0; i < (description ?? []).length; i++) {
    stmts.push(
      db.prepare('INSERT INTO book_descriptions (book_id, paragraph, position) VALUES (?, ?, ?)')
        .bind(bookId, description[i], i + 1)
    );
  }

  for (let i = 0; i < (endorsements ?? []).length; i++) {
    stmts.push(
      db.prepare('INSERT INTO book_endorsements (book_id, quote, attribution, position) VALUES (?, ?, ?, ?)')
        .bind(bookId, endorsements[i].quote, endorsements[i].attribution, i + 1)
    );
  }

  if (stmts.length > 0) {
    await db.batch(stmts);
  }

  return new Response(JSON.stringify({ id: bookId }), { status: 201, headers: { 'Content-Type': 'application/json' } });
}
