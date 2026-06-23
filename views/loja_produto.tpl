<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>{{produto['nome']}} - Mercado BIG BOM</title>
    <link rel="stylesheet" href="/static/css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div class="container">
        <header class="header">
            <div class="logo">
                <a href="/">🛒 Mercado BIG BOM</a>
            </div>
            <nav class="nav">
                <a href="/">Início</a>
                <a href="/loja">Loja</a>
                <a href="/loja/carrinho">🛒 Carrinho</a>
                % if 'cliente_id' in request.cookies:
                    <a href="/cliente_area">Minha Conta</a>
                    <a href="/logout_cliente">Sair</a>
                % else:
                    <a href="/login_cliente">Login</a>
                % end
            </nav>
        </header>

        <main>
            <div class="card" style="max-width: 600px; margin: 0 auto;">
                <h1>{{produto['nome']}}</h1>
                
                <div class="d-flex justify-between align-center mt-2">
                    <a href="/loja" class="btn">← Voltar para Loja</a>
                    <a href="/loja/carrinho" class="btn btn-success">🛒 Ver Carrinho</a>
                </div>
                
                <div class="card mt-3">
                    <table class="table">
                        <tr>
                            <th>Preço</th>
                            <td style="font-size: 24px; color: var(--roxo-principal); font-weight: bold;">
                                R$ {{'%.2f' % produto['preco']}}
                            </td>
                        </tr>
                        <tr>
                            <th>Estoque Disponível</th>
                            <td>
                                <span class="badge {% if produto['estoque'] <= 10 %}badge-danger{% elif produto['estoque'] <= 20 %}badge-warning{% else %}badge-success{% end %}">
                                    {{produto['estoque']}} unidades
                                </span>
                            </td>
                        </tr>
                    </table>
                    
                    % if produto['estoque'] > 0:
                    <form action="/loja/carrinho/adicionar" method="post" class="mt-3">
                        <input type="hidden" name="produto_id" value="{{produto['id']}}">
                        
                        <div class="form-group">
                            <label for="quantidade">Quantidade:</label>
                            <input type="number" id="quantidade" name="quantidade" value="1" 
                                   min="1" max="{{produto['estoque']}}" class="form-control" style="width: 100px;">
                        </div>
                        
                        <div class="d-flex gap-1 mt-3">
                            <button type="submit" class="btn btn-success btn-large">
                                ➕ Adicionar ao Carrinho
                            </button>
                        </div>
                    </form>
                    % else:
                    <div class="alert alert-danger mt-3">
                        <p>⚠️ Produto esgotado</p>
                    </div>
                    % end
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Loja Online</p>
        </footer>
    </div>
</body>
</html>