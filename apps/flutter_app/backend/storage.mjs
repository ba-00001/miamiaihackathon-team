const bucket = process.env.AWS_S3_BUCKET ?? 'mare-demo-assets';
const region = process.env.AWS_REGION ?? 'us-east-1';
const prefix = process.env.AWS_S3_PREFIX ?? 'uploads';

function sanitizeFilename(filename) {
  return filename.replace(/[^a-zA-Z0-9._-]/g, '-').toLowerCase();
}

export function buildStorageConfig() {
  return {
    provider: 'aws-s3',
    bucket,
    region,
    prefix,
    imageBaseUrl: `https://${bucket}.s3.${region}.amazonaws.com/${prefix}`,
    fallback:
      'If signed upload flow is unavailable, keep the image card visible and route the asset into manual review.',
  };
}

export function buildImageUploadTarget(filename) {
  const safeFilename = sanitizeFilename(filename);
  const key = `${prefix}/${Date.now()}-${safeFilename}`;

  return {
    provider: 'aws-s3',
    bucket,
    region,
    key,
    method: 'PUT',
    uploadUrl: `https://${bucket}.s3.${region}.amazonaws.com/${key}`,
    publicUrl: `https://${bucket}.s3.${region}.amazonaws.com/${key}`,
    note:
      'Swap this placeholder upload target for a real presigned URL flow when AWS credentials are connected.',
  };
}
