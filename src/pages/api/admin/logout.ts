export const prerender = false;
import type { APIContext } from 'astro';

export async function POST({ cookies, locals, redirect }: APIContext) {
  const sessionId = cookies.get('session')?.value;

  if (sessionId) {
    const db = locals.runtime.env.prod_d1_oakestown;
    await db.prepare('DELETE FROM admin_sessions WHERE id = ?').bind(sessionId).run();
  }

  cookies.delete('session', { path: '/' });
  return redirect('/admin/login');
}
