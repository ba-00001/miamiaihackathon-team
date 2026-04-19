import os
import time

try:
    import boto3
except ImportError:  # pragma: no cover
    boto3 = None


class S3ImageStorageService:
    def __init__(self) -> None:
        self.bucket = os.getenv("AWS_S3_BUCKET", "mare-demo-assets")
        self.region = os.getenv("AWS_REGION", "us-east-1")
        self.prefix = os.getenv("AWS_S3_PREFIX", "uploads")

    def storage_summary(self) -> dict:
        return {
            "provider": "aws-s3",
            "bucket": self.bucket,
            "region": self.region,
            "prefix": self.prefix,
            "imageBaseUrl": f"https://{self.bucket}.s3.{self.region}.amazonaws.com/{self.prefix}",
            "mode": "live" if self._can_presign() else "demo",
            "fallback": "If AWS credentials are missing, keep the image workflow visible and return a deterministic S3-style target instead of failing silently.",
        }

    def prepare_upload(self, filename: str) -> dict:
        safe_name = self._sanitize_filename(filename)
        key = f"{self.prefix}/{int(time.time())}-{safe_name}"
        public_url = f"https://{self.bucket}.s3.{self.region}.amazonaws.com/{key}"

        if self._can_presign():
            client = boto3.client("s3", region_name=self.region)
            post = client.generate_presigned_post(
                Bucket=self.bucket,
                Key=key,
                Conditions=[["content-length-range", 0, 10 * 1024 * 1024]],
                ExpiresIn=3600,
            )
            return {
                "provider": "aws-s3",
                "mode": "live",
                "bucket": self.bucket,
                "region": self.region,
                "key": key,
                "method": "POST",
                "uploadUrl": post["url"],
                "fields": post["fields"],
                "publicUrl": public_url,
            }

        return {
            "provider": "aws-s3",
            "mode": "demo",
            "bucket": self.bucket,
            "region": self.region,
            "key": key,
            "method": "PUT",
            "uploadUrl": public_url,
            "fields": {},
            "publicUrl": public_url,
            "note": "Live presigned uploads will activate automatically once boto3 and AWS credentials are available.",
        }

    def _can_presign(self) -> bool:
        return boto3 is not None and bool(os.getenv("AWS_ACCESS_KEY_ID")) and bool(
            os.getenv("AWS_SECRET_ACCESS_KEY")
        )

    def _sanitize_filename(self, filename: str) -> str:
        return "".join(
            character.lower() if character.isalnum() or character in "._-" else "-"
            for character in filename
        )
