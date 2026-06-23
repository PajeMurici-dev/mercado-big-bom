from bottle import request, response, redirect, template
from database import get_connection

def init_cliente_auth_routes(app):

    @app.get("/login_cliente")
    def escolher_login_cliente():
        return template("cliente_login", erro=None, request=request)

    @app.post("/login_cliente")
    def login_cliente():
        nome = request.forms.get("nome")
        senha = request.forms.get("senha")

        db = get_connection()
        cliente = db.execute(
            "SELECT * FROM clientes WHERE nome = ? AND senha = ?",
            (nome, senha)
        ).fetchone()

        db.close()

        if cliente is None:
            return template("cliente_login", erro="Nome ou senha incorretos", request=request)

        response.set_cookie(
            "cliente_id",
            str(cliente["id"]),
            path="/",
            max_age=3600,
            httponly=True,
            secure=False
        )

        return redirect("/loja")

    @app.get("/cliente_area")
    def area_cliente():
        cliente_id = request.get_cookie("cliente_id")

        if not cliente_id:
            return redirect("/login_cliente")

        db = get_connection()
        cliente = db.execute("SELECT * FROM clientes WHERE id = ?", (cliente_id,)).fetchone()
        db.close()

        if cliente is None:
            return redirect("/login_cliente")

        return template("area_cliente", cliente=cliente, request=request)

    @app.get("/logout_cliente")
    def logout_cliente():
        response.delete_cookie("cliente_id", path="/")
        return redirect("/login_cliente")

    @app.get("/cadastrar_cliente")
    def cadastrar_cliente_page():
        return template("cliente_cadastrar", erro=None, request=request)

    @app.post("/cadastrar_cliente")
    def cadastrar_cliente_post():
        nome = request.forms.get("nome")
        senha = request.forms.get("senha")
        cep = request.forms.get("cep")
        
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM clientes WHERE nome = ?", (nome,))
        if cursor.fetchone():
            conn.close()
            return template("cliente_cadastrar", erro="Nome já existe!", request=request)
        
        cursor.execute(
            "INSERT INTO clientes (nome, senha, cep) VALUES (?, ?, ?)",
            (nome, senha, cep)
        )
        
        cliente_id = cursor.lastrowid
        
        conn.commit()
        conn.close()
        
        return template("cadastro_sucesso", 
                       cliente_nome=nome, 
                       cliente_cep=cep, 
                       cliente_id=cliente_id,
                       request=request)