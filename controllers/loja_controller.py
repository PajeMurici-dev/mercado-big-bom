from bottle import get, post, request, redirect, template, response
from database import get_connection
import json

def init_loja_routes(app):
    
    @app.get("/loja")
    def loja_home():
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM produtos WHERE estoque > 0 ORDER BY nome")
        produtos = cursor.fetchall()
        conn.close()
        return template("loja_home", produtos=produtos, request=request)
    
    @app.get("/loja/produto/<id:int>")
    def ver_produto(id):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM produtos WHERE id = ?", (id,))
        produto = cursor.fetchone()
        conn.close()
        
        if produto is None:
            return redirect("/loja")
        
        return template("loja_produto", produto=produto, request=request)
    
    @app.get("/loja/carrinho")
    def ver_carrinho():
        carrinho_cookie = request.get_cookie("carrinho")
        carrinho = {}
        if carrinho_cookie:
            try:
                carrinho = json.loads(carrinho_cookie)
            except:
                carrinho = {}
        produtos_carrinho = []
        total = 0
        if carrinho:
            conn = get_connection()
            cursor = conn.cursor()
            
            for produto_id, quantidade in carrinho.items():
                cursor.execute("SELECT * FROM produtos WHERE id = ?", (int(produto_id),))
                produto = cursor.fetchone()
                
                if produto:
                    subtotal = produto["preco"] * quantidade
                    produtos_carrinho.append({
                        "id": produto["id"],
                        "nome": produto["nome"],
                        "preco": produto["preco"],
                        "quantidade": quantidade,
                        "subtotal": subtotal
                    })
                    total += subtotal
            
            conn.close()
        
        return template("loja_carrinho", 
                       produtos=produtos_carrinho, 
                       total=total,
                       request=request)
    
    @app.post("/loja/carrinho/adicionar")
    def adicionar_carrinho():
        produto_id = request.forms.get("produto_id")
        quantidade = int(request.forms.get("quantidade", 1))
        
        carrinho_cookie = request.get_cookie("carrinho")
        carrinho = {}
        
        if carrinho_cookie:
            try:
                carrinho = json.loads(carrinho_cookie)
            except:
                carrinho = {}
        if produto_id in carrinho:
            carrinho[produto_id] += quantidade
        else:
            carrinho[produto_id] = quantidade
        
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT estoque FROM produtos WHERE id = ?", (produto_id,))
        produto = cursor.fetchone()
        conn.close()
        
        if produto and carrinho[produto_id] > produto["estoque"]:
            carrinho[produto_id] = produto["estoque"]
        
        response.set_cookie("carrinho", json.dumps(carrinho), path="/")
        
        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return {"success": True, "message": "Produto adicionado ao carrinho"}
        else:
            return redirect("/loja/carrinho")
    
    @app.post("/loja/carrinho/atualizar")
    def atualizar_carrinho():
        produto_id = request.forms.get("produto_id")
        quantidade = int(request.forms.get("quantidade", 0))
        
        carrinho_cookie = request.get_cookie("carrinho")
        carrinho = {}
        
        if carrinho_cookie:
            try:
                carrinho = json.loads(carrinho_cookie)
            except:
                carrinho = {}
        
        if quantidade <= 0:
            if produto_id in carrinho:
                del carrinho[produto_id]
        else:
            carrinho[produto_id] = quantidade
            conn = get_connection()
            cursor = conn.cursor()
            cursor.execute("SELECT estoque FROM produtos WHERE id = ?", (produto_id,))
            produto = cursor.fetchone()
            conn.close()
            
            if produto and carrinho[produto_id] > produto["estoque"]:
                carrinho[produto_id] = produto["estoque"]
        response.set_cookie("carrinho", json.dumps(carrinho), path="/")
        
        return redirect("/loja/carrinho")
    
    @app.get("/loja/carrinho/limpar")
    def limpar_carrinho():
        response.delete_cookie("carrinho", path="/")
        return redirect("/loja/carrinho")
    
    @app.get("/loja/finalizar")
    def finalizar_compra():
        cliente_id = request.get_cookie("cliente_id")
        
        if not cliente_id:
            return redirect("/login_cliente")
        
        carrinho_cookie = request.get_cookie("carrinho")
        if not carrinho_cookie:
            return redirect("/loja/carrinho")
        
        carrinho = json.loads(carrinho_cookie)
        
        if not carrinho:
            return redirect("/loja/carrinho")
        conn = get_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute(
                "INSERT INTO pedidos (cliente_id, data_pedido, status) VALUES (?, datetime('now'), 'pendente')",
                (int(cliente_id),)
            )
            pedido_id = cursor.lastrowid
            
            total_pedido = 0
            
            for produto_id, quantidade in carrinho.items():
                cursor.execute("SELECT * FROM produtos WHERE id = ?", (int(produto_id),))
                produto = cursor.fetchone()
                
                if produto:
                    preco_unitario = produto["preco"]
                    subtotal = preco_unitario * quantidade
                    total_pedido += subtotal
                    cursor.execute(
                        """INSERT INTO itens_pedido 
                           (pedido_id, produto_id, quantidade, preco_unitario) 
                           VALUES (?, ?, ?, ?)""",
                        (pedido_id, produto_id, quantidade, preco_unitario)
                    )

                    novo_estoque = produto["estoque"] - quantidade
                    cursor.execute(
                        "UPDATE produtos SET estoque = ? WHERE id = ?",
                        (novo_estoque, produto_id)
                    )

            cursor.execute(
                "UPDATE pedidos SET total = ? WHERE id = ?",
                (total_pedido, pedido_id)
            )
            
            conn.commit()
            response.delete_cookie("carrinho", path="/")
            return template("loja_compra_finalizada", 
                          pedido_id=pedido_id, 
                          total=total_pedido,
                          request=request)
        
        except Exception as e:
            conn.rollback()
            return f"Erro ao processar pedido: {str(e)}"
        finally:
            conn.close()