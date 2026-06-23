from bottle import Bottle, run, static_file, template, request, redirect
from bottle.ext.websocket import GeventWebSocketServer, websocket
from database import init_db
import json
from datetime import datetime
import os

app = Bottle()
init_db()

active_connections = []

@app.route("/static/css/<filepath:path>")
def serve_css(filepath):
    return static_file(filepath, root="static/css/")

@app.route("/static/js/<filepath:path>")
def serve_js(filepath):
    return static_file(filepath, root="static/js/")

@app.route("/static/<filepath:path>")
def serve_static(filepath):
    return static_file(filepath, root="static/")

@app.get("/")
def index():
    return template("index", request=request)

@app.route('/websocket', apply=[websocket])
def handle_websocket(ws):
    active_connections.append(ws)
    
    try:
        ws.send(json.dumps({
            'type': 'connection',
            'message': 'Conectado ao Mercado BIG BOM',
            'timestamp': datetime.now().isoformat()
        }))
        
        while True:
            message = ws.receive()
            if message is None:
                break
                
            try:
                data = json.loads(message)
                print(f"WebSocket mensagem: {data}")
                
                ws.send(json.dumps({
                    'type': 'echo',
                    'original': data,
                    'timestamp': datetime.now().isoformat()
                }))
                
            except json.JSONDecodeError:
                ws.send(json.dumps({
                    'type': 'error',
                    'message': 'Mensagem JSON inválida'
                }))
                
    except Exception as e:
        print(f"Erro WebSocket: {e}")
    finally:
        if ws in active_connections:
            active_connections.remove(ws)

def send_websocket_notification(notification_type, data):
    notification = {
        'type': notification_type,
        'data': data,
        'timestamp': datetime.now().isoformat()
    }
    
    for connection in active_connections:
        try:
            connection.send(json.dumps(notification))
        except:
            if connection in active_connections:
                active_connections.remove(connection)

try:
    from controllers.produto_controller import init_produto_routes
    from controllers.funcionario_auth_controller import init_auth_routes
    from controllers.cliente_controller import init_cliente_routes
    from controllers.cliente_auth_controller import init_cliente_auth_routes
    from controllers.loja_controller import init_loja_routes
    
    init_auth_routes(app)
    init_cliente_routes(app)
    init_cliente_auth_routes(app)
    init_produto_routes(app)
    init_loja_routes(app)
    
    print("✅ Todos os controllers carregados com sucesso!")
    
except ImportError as e:
    print(f"⚠️  Erro ao carregar controllers: {e}")
except Exception as e:
    print(f"⚠️  Erro inesperado: {e}")

app.send_websocket_notification = send_websocket_notification

if __name__ == '__main__':
    print("=" * 60)
    print("MERCADO BIG BOM - SISTEMA ORGANIZADO")
    print("=" * 60)
    print(f" Servidor: http://localhost:8000")
    print(f" WebSocket: ws://localhost:8000/websocket")
    print(f" CSS: /static/css/style.css")
    print(f" JS: /static/js/")
    print("=" * 60)
    
    try:
        run(app, 
            host="localhost", 
            port=8000, 
            debug=True, 
            reloader=True,
            server=GeventWebSocketServer)
    except KeyboardInterrupt:
        print("\n  Servidor encerrado")
    except Exception as e:
        print(f"\n Erro: {e}")