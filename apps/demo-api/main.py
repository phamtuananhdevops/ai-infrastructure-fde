from fastapi import FastAPI
app = FastAPI(title='AI Infrastructure FDE Demo')
@app.get('/healthz')
def healthz():
    return {'status': 'ok'}
@app.get('/api/hello')
def hello():
    return {'message': 'Hello from the FDE lab'}
