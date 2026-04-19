import { createServer } from 'node:http';
import { buildImageUploadTarget, buildStorageConfig } from './storage.mjs';

const appState = {
  appName: 'MaRe',
  tagline:
    'One luxury scalp-health app for guests, MaRe growth teams, partner salons, and clients.',
  updatedAt: '2026-04-19T11:45:00-04:00',
  guest: {
    title: 'Discover MaRe without signing in',
    description:
      'Guest mode lets future salon partners and curious clients explore the MaRe brand before creating an account.',
    highlights: [
      'Browse luxury scalp-health education',
      'Find partner salons and MaRe locations',
      'Apply to become a MaRe salon partner',
    ],
  },
  roles: [
    {
      id: 'internal',
      title: 'MaRe Internal',
      summary:
        'Prospect salons, generate luxury outreach, scale content, and manage approvals.',
    },
    {
      id: 'owner',
      title: 'Salon Owner',
      summary:
        'Track partner performance, staff enablement, consultation quality, and reorder needs.',
    },
    {
      id: 'client',
      title: 'Client',
      summary:
        'Follow a personal scalp-health journey with routines, appointments, progress, and product recommendations.',
    },
  ],
  aiNotice: {
    hasError: true,
    title: 'AI output is guarded by role and fallback mode',
    description:
      'Guests only see public education, salon owners only see partner data, and clients only see their own journey.',
    fallbacks: [
      'Fallback to approved templates when live generation is unavailable.',
      'Block sends or publishes until a human approves uncertain output.',
      'Keep the yellow dot visible anywhere AI or fallback logic is active.',
    ],
  },
};

const agentResult = {
  status: 'guarded',
  tone: 'luxury, warm, systematic',
  nextAction:
    'Let guests browse publicly, let signed-in users choose their role, and keep uncertain AI actions in review.',
  yellowDot: true,
};

createServer((request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*');
  response.setHeader('Content-Type', 'application/json');
  const url = new URL(request.url ?? '/', 'http://localhost:4300');

  if (url.pathname === '/api/snapshot' || url.pathname === '/api/app-state') {
    response.end(JSON.stringify(appState));
    return;
  }

  if (url.pathname === '/api/agent') {
    response.end(JSON.stringify(agentResult));
    return;
  }

  if (url.pathname === '/api/storage/config') {
    response.end(JSON.stringify(buildStorageConfig()));
    return;
  }

  if (url.pathname === '/api/storage/prepare-upload') {
    const filename = url.searchParams.get('filename') ?? 'mare-image.jpg';
    response.end(JSON.stringify(buildImageUploadTarget(filename)));
    return;
  }

  response.statusCode = 404;
  response.end(
    JSON.stringify({
      error: 'not_found',
      fallback: 'Show cached dashboard data and keep the yellow AI dot visible.',
    }),
  );
}).listen(4300, () => {
  console.log('Flutter demo backend listening on http://localhost:4300');
});
