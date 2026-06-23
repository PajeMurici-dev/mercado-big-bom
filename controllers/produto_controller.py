from bottle import get, post, request, redirect, template
from database import get_connection

def init_produto_routes(app):

    @app.get("/produtos")
    def listar_produtos():
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM produtos")
        produtos = cursor.fetchall()
        conn.close()
        return template("produtos_listar", produtos=produtos, request=request)

    @app.get("/produtos/novo")
    def novo_produto():
        return template("produtos_novo", request=request)

    @app.post("/produtos/novo")
    def criar_produto():
        nome = request.forms.get("nome")
        preco = request.forms.get("preco")
        estoque = request.forms.get("estoque")

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO produtos (nome, preco, estoque) VALUES (?, ?, ?)",
            (nome, preco, estoque)
        )
        conn.commit()
        conn.close()

        return redirect("/produtos")

    @app.get("/produtos/editar/<id:int>")
    def editar_produto(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM produtos WHERE id=?", (id,))
        produto = cursor.fetchone()
        conn.close()
        return template("produtos_editar", produto=produto, request=request)

    @app.post("/produtos/editar/<id:int>")
    def salvar_produto(id):
        nome = request.forms.get("nome")
        preco = request.forms.get("preco")
        estoque = request.forms.get("estoque")

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE produtos SET nome=?, preco=?, estoque=? WHERE id=?",
            (nome, preco, estoque, id)
        )
        conn.commit()
        conn.close()

        return redirect("/produtos")

    @app.get("/produtos/deletar/<id:int>")
    def deletar_produto(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM produtos WHERE id=?", (id,))
        conn.commit()
        conn.close()

        return redirect("/produtos")