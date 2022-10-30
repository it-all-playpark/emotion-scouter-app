# save this as app.py
import os
from dotenv import load_dotenv
from flask import Flask, request, jsonify
from flask_httpauth import HTTPTokenAuth
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


@app.route("/", methods=['POST'])
@auth.login_required
def index():
    if request.method == 'POST':
        image = request.json['image']
        return jsonify({"status":"success", "result":get_emotion(image)}),200

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)