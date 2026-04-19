import { createServer } from 'node:http';
import { buildImageUploadTarget, buildStorageConfig } from './storage.mjs';

const snapshot = {
  generatedAt: '2026-04-19T10:45:00-04:00',
  marketFocus: 'Miami proof of concept with nationwide luxury expansion',
  headline: 'The MaRe Luxury Growth Engine',
  statusDotColor: 'yellow',
  metrics: {
    luxuryProspects: 12480,
    approvedOutreach: 42,
    contentAssetsReady: 56,
    retailLiftPotential: '3% to 40%+',
  },
  aiError: {
    hasError: true,
    title: 'Revenue verification gap on 14 shortlisted salons',
    description:
      'The AI agent could not fully verify recent revenue signals, so the backend moved those leads into review rather than risking brand-damaging automation.',
    fallbacks: [
      'Score leads with aesthetic, wellness, and multi-location signals.',
      'Require Rebecca or Marianna approval before outreach send.',
      'Fallback to blog-first content if video credits are exhausted.',
    ],
  },
};

const agentResult = {
  status: 'guarded',
  tone: 'luxury, warm, systematic',
  nextAction: 'Draft outreach but block send until human approval.',
  yellowDot: true,
};

createServer((request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*');
  response.setHeader('Content-Type', 'application/json');
  const url = new URL(request.url ?? '/', 'http://localhost:4300');

  if (url.pathname === '/api/snapshot') {
    response.end(JSON.stringify(snapshot));
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
