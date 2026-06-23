import sqlite3
from bottle import get, post, request, redirect, template, response
from database import get_connection

def init_auth_routes(app):

    @app.get("/login")
    def login_page():
        return template("login", erro="", request=request)

    @app.post("/login")
    def login_post():
        usuario = request.forms.get("usuario")
        senha = request.forms.get("senha")

        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute(
            "SELECT * FROM funcionarios WHERE usuario = ? AND senha = ?",
            (usuario, senha)
        )
        funcionario = cursor.fetchone()

        conn.close()

        if funcionario is None:
            return template("login", erro="Usuário ou senha incorretos.", request=request)

        response.set_cookie("funcionario", usuario, path="/")
        return redirect("/admin")

    @app.get("/admin")
    def admin_area():
        funcionario = request.get_cookie("funcionario")

        if not funcionario:
            return redirect("/login")

        return template("admin", funcionario=funcionario, request=request)

    @app.get("/logout")
    def logout():
        response.delete_cookie("funcionario", path="/")
        return redirect("/login")