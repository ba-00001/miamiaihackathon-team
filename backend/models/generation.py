from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Text
from extensions import db

class Generation(db.Model):
    __tablename__ = 'generations'

    id = Column(Integer, primary_key=True)
    model_type = Column(String(50), nullable=False)
    prompt = Column(Text, nullable=False)
    input_params = Column(Text)
    s3_key = Column(String(500))
    media_type = Column(String(20), default='video')
    status = Column(String(20), default='completed')
    created_at = Column(DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'model_type': self.model_type,
            'prompt': self.prompt,
            'input_params': self.input_params,
            's3_key': self.s3_key,
            'media_type': self.media_type,
            'status': self.status,
            'created_at': self.created_at.isoformat(),
        }