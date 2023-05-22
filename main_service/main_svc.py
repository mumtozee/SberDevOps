from flask import Flask
import json
import requests

app = Flask(__name__)

URL = "http://my-nginx.mesh-external.svc.cluster.local"


@app.route("/")
def hello():
    return "<h1>Hello, World!</h1>"


@app.route("/test", methods=["GET"])
def get_random_activity():
    try:
        r = requests.get(url=URL)
        result = r.status_code
        return f"<h1>External service query returned: {result}.</h1>"
    except Exception as e:
        return f"<h2>Error: {e}</h2>"


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
