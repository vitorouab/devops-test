from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from GCP Cloud Run!"

@app.route('/healthz')
def health():
    return "OK", 200