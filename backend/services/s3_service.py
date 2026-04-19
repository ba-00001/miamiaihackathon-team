import os
import uuid
import boto3
import requests
from dotenv import load_dotenv

load_dotenv()

class S3Service:
    def __init__(self):
        self.region = os.getenv('AWS_REGION', 'us-east-2')
        self.s3 = boto3.client(
            's3',
            aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'),
            aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY'),
            region_name=self.region,
        )
        self.bucket = os.getenv('S3_BUCKET_NAME')
        if not self.bucket:
            raise ValueError("S3_BUCKET_NAME is missing from .env")

    def upload_from_url(self, media_url: str, model_type: str) -> str:
        ext = ".mp4" if model_type in ["seedance", "wan"] else ".mp3"
        key = f"generations/{model_type}/{uuid.uuid4()}{ext}"

        response = requests.get(media_url, stream=True)
        response.raise_for_status()

        self.s3.upload_fileobj(
            response.raw,
            self.bucket,
            key,
            ExtraArgs={'ContentType': response.headers.get('content-type', 'video/mp4')},
        )
        return key

    def upload_file(self, file_obj, original_filename: str, content_type: str) -> str:
        ext = os.path.splitext(original_filename)[1] or self._guess_ext(content_type)
        key = f"uploads/{uuid.uuid4()}{ext}"

        self.s3.upload_fileobj(
            file_obj,
            self.bucket,
            key,
            ExtraArgs={'ContentType': content_type},
        )
        return key

    def upload_url_public(self, source_url: str) -> str:
        resp = requests.get(source_url, stream=True)
        resp.raise_for_status()
        ct = resp.headers.get('content-type', 'application/octet-stream')
        ext = self._guess_ext(ct)
        key = f"uploads/{uuid.uuid4()}{ext}"

        self.s3.upload_fileobj(
            resp.raw,
            self.bucket,
            key,
            ExtraArgs={'ContentType': ct},
        )
        return key

    def get_public_url(self, s3_key: str) -> str:
        return f"https://{self.bucket}.s3.{self.region}.amazonaws.com/{s3_key}"

    def get_presigned_url(self, s3_key: str, expires_in: int = 3600) -> str:
        return self.s3.generate_presigned_url(
            'get_object',
            Params={'Bucket': self.bucket, 'Key': s3_key},
            ExpiresIn=expires_in,
        )

    @staticmethod
    def _guess_ext(content_type: str) -> str:
        mapping = {
            'image/png': '.png', 'image/jpeg': '.jpg', 'image/webp': '.webp',
            'image/gif': '.gif', 'video/mp4': '.mp4', 'video/webm': '.webm',
            'audio/mpeg': '.mp3', 'audio/wav': '.wav',
        }
        return mapping.get(content_type, '.bin')