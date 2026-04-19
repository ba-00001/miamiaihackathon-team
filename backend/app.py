from flask import Flask
from flask_cors import CORS
import os
from dotenv import load_dotenv
from extensions import db

load_dotenv()

app = Flask(__name__)
CORS(app)

app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

from routes.api import api_bp
app.register_blueprint(api_bp)

if __name__ == '__main__':
    with app.app_context():
        from models.generation import Generation
        db.create_all()
    app.run(host='0.0.0.0', port=8080, debug=True)