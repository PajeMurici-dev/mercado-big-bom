from bottle import get, post, request, redirect, template
import sqlite3

def get_connection():
    conn = sqlite3.connect("database.db")
    conn.row_factory = sqlite3.Row
    return conn

def init_cliente_routes(app):

    @app.get("/clientes")
    def listar_clientes():
        conn = get_connection()
        clientes = conn.execute("SELECT * FROM clientes").fetchall()
        conn.close()

        return template("clientes_listar", clientes=clientes, request=request)

    @app.get("/clientes/novo")
    def novo_cliente():
        return template("clientes_novo", request=request)

    @app.post("/clientes/novo")
    def salvar_cliente():
        nome = request.forms.get("nome")
        senha = request.forms.get("senha")
        cep = request.forms.get("cep")

        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute(
            "INSERT INTO clientes (nome, senha, cep) VALUES (?, ?, ?)",
            (nome, senha, cep)
        )

        conn.commit()
        conn.close()

        return redirect("/clientes")

    @app.get("/clientes/editar/<id:int>")
    def editar_cliente(id):
        conn = get_connection()
        cliente = conn.execute(
            "SELECT * FROM clientes WHERE id = ?", (id,)
        ).fetchone()
        conn.close()

        if cliente is None:
            return "Cliente não encontrado!"

        return template("clientes_editar", cliente=cliente, request=request)

    @app.post("/clientes/editar/<id:int>")
    def salvar_edicao(id):
        nome = request.forms.get("nome")
        senha = request.forms.get("senha")
        cep = request.forms.get("cep")

        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute(
            "UPDATE clientes SET nome=?, senha=?, cep=? WHERE id=?",
            (nome, senha, cep, id)
        )

        conn.commit()
        conn.close()

        return redirect("/clientes")

    @app.get("/clientes/deletar/<id:int>")
    def deletar_cliente(id):
        conn = get_connection()
        conn.execute("DELETE FROM clientes WHERE id=?", (id,))
        conn.commit()
        conn.close()

        return redirect("/clientes")