# save this as app.py
from flask import Flask, request
import sys
sys.path.append("../src")
from emotion import get_emotion

app = Flask(__name__)

@app.route("/", methods=['POST'])
def index():
    if request.method == 'POST':
        image = request.json['image']
    return get_emotion(image)

if __name__ == '__main__':
    app.run()