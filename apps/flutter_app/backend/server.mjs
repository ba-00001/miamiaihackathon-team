import { createServer } from 'node:http';
import { buildImageUploadTarget, buildStorageConfig } from './storage.mjs';

const appState = {
  appName: 'MaRe',
  tagline:
    'One luxury scalp-health app for guests, MaRe internal teams, partner operators, and end users.',
  updatedAt: '2026-04-19T16:10:00-04:00',
  guest: {
    title: 'Discover MaRe without signing in',
    description:
      'Guest mode lets wellness enthusiasts, future partner locations, and curious end users explore the MaRe brand before creating an account.',
    highlights: [
      'Browse luxury scalp-health education',
      'Find partner salons and MaRe locations',
      'Shop shampoos, treatments, tools, and gift kits',
    ],
  },
  roles: [
    {
      id: 'internal',
      title: 'MaRe Internal',
      summary:
        'Prospect premium partners, manage outreach, support distributors, scale content, and keep risky actions in human review.',
    },
    {
      id: 'owner',
      title: 'Salon Owner',
      summary:
        'Track partner performance, MaRe Eye workflows, training, certification, consultation quality, and reorder needs.',
    },
    {
      id: 'client',
      title: 'End User',
      summary:
        'Find partner locations, follow a scalp-health journey, and shop MaRe products with personalized recommendations.',
    },
  ],
  aiNotice: {
    hasError: true,
    title: 'AI output is guarded by role and fallback mode',
    description:
      'Guests only see public education, salon owners only see partner data, and end users only see their own journey.',
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
    'Let guests browse publicly, let signed-in users choose their role, and keep uncertain AI actions in review while routing booking, product, and partner flows by role.',
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
