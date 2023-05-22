from flask import Flask
import json
import requests

app = Flask(__name__)

URL = "https://www.boredapi.com/api/activity"


@app.route("/")
def hello():
    return "<h1>Hello, World!</h1>"


@app.route("/random_activity", methods=["GET"])
def get_random_activity():
    try:
        r = requests.get(url=URL)
        result = json.loads(r.text)
        return f"<p>Today's activity:<p><h1>{result['activity']}.</h1>"
    except Exception as e:
        return f"<h2>Error: {e}</h2>"


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
