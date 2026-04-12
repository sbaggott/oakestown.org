import { defineMiddleware } from 'astro:middleware';

export const onRequest = defineMiddleware(async (context, next) => {
  const { pathname } = new URL(context.request.url);

  const isAdminPage = pathname.startsWith('/admin') && pathname !== '/admin/login';
  const isAdminApi = pathname.startsWith('/api/admin');

  if (!isAdminPage && !isAdminApi) {
    return next();
  }

  const sessionId = context.cookies.get('session')?.value;

  if (!sessionId) {
    return isAdminApi
      ? new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401, headers: { 'Content-Type': 'application/json' } })
      : context.redirect('/admin/login');
  }

  const db = context.locals.runtime.env.prod_d1_oakestown;
  const session = await db
    .prepare("SELECT id FROM admin_sessions WHERE id = ? AND expires_at > datetime('now')")
    .bind(sessionId)
    .first();

  if (!session) {
    context.cookies.delete('session', { path: '/' });
    return isAdminApi
      ? new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401, headers: { 'Content-Type': 'application/json' } })
      : context.redirect('/admin/login');
  }

  context.locals.user = { authenticated: true };
  return next();
});
