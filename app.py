from flask import Flask, Response
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

# Prometheus metric
REQUEST_COUNT = Counter('app_requests_total', 'Total app requests')

@app.route('/')
def home():
    REQUEST_COUNT.inc()
    return """
    <!DOCTYPE html>
    <html>
    <head>
        <title>Airowire</title>
        <style>
            body {
                margin: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background: linear-gradient(135deg, #1e3c72, #2a5298);
                font-family: Arial, sans-serif;
                color: white;
                text-align: center;
            }
            h1 {
                font-size: 3em;
                margin-bottom: 20px;
            }
            h2 {
                font-size: 1.8em;
                font-weight: normal;
            }
        </style>
    </head>
    <body>
        <div>
            <h1>🌈 Welcome todfghjk  Airowireeeeeeeeeeeee 🌻</h1>
            <h2>🌍 Hello DevOps World 🚀</h2>
        </div>
    </body>
    </html>
    """

@app.route('/metrics')
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=6001)
