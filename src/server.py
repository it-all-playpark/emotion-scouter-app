# save this as app.py
import os
from dotenv import load_dotenv
from flask import Flask, request, jsonify, json
from flask_httpauth import HTTPTokenAuth
from werkzeug.exceptions import HTTPException
from src.emotion import get_emotion #prod実行用
# from emotion import get_emotion #local実行用

app = Flask(__name__)
auth = HTTPTokenAuth(scheme='Bearer')
load_dotenv('/project/src/.env')

tokens = {
    os.environ['ACCESS_TOKEN']: "admin"
}

@auth.verify_token
def verify_token(token):
    if token in tokens:
        return tokens[token]


@app.errorhandler(HTTPException)
def handle_exception(e):
    """Return JSON instead of HTML for HTTP errors."""
    # start with the correct headers and status code from the error
    response = e.get_response()
    # replace the body with JSON
    response.data = json.dumps({
        "code": e.code,
        "name": e.name,
        "description": e.description,
    })
    response.content_type = "application/json"
    return response

@app.route("/", methods=['POST'])
@auth.login_required
def index():
    image = request.json['image']
    return jsonify(status="success", result=get_emotion(image)),200

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)