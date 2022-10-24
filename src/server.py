# save this as app.py
from flask import Flask, request, jsonify
from src.emotion import get_emotion

app = Flask(__name__)

@app.route("/", methods=['POST'])
def index():
    if request.method == 'POST':
        image = request.json['image']
    return jsonify({"status":"success", "result":get_emotion(image)}),200

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)