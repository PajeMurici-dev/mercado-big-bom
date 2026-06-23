<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Loja Online - Mercado BIG BOM</title>
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
                <a href="/loja" class="active">Loja</a>
                % if 'cliente_id' in request.cookies:
                    <a href="/cliente_area">Minha Conta</a>
                    <a href="/loja/carrinho">🛒 Carrinho</a>
                    <a href="/logout_cliente">Sair</a>
                % else:
                    <a href="/login_cliente">Login Cliente</a>
                % end
            </nav>
        </header>

        <main>
            <div class="card">
                <div class="d-flex justify-between align-center">
                    <h1 style="margin: 0;">🛒 Loja Online</h1>
                    <a href="/loja/carrinho" class="btn btn-success">🛍️ Ver Carrinho</a>
                </div>
                
                % if not produtos:
                <div class="alert alert-info mt-3 text-center">
                    <h3>⏳ Aguarde...</h3>
                    <p class="text-muted">Estamos preparando nossos produtos.</p>
                </div>
                % else:
                <div class="mt-3">
                    % for p in produtos:
                    <div class="card mt-2">
                        <div class="d-flex justify-between align-center">
                            <div>
                                <h3 style="margin: 0;">{{p['nome']}}</h3>
                                <p class="text-muted mt-1">R$ {{'%.2f' % p['preco']}} • 
                                    <span class="badge {% if p['estoque'] <= 10 %}badge-danger{% elif p['estoque'] <= 20 %}badge-warning{% else %}badge-success{% end %}">
                                        {{p['estoque']}} unidades
                                    </span>
                                </p>
                            </div>
                            
                            <form action="/loja/carrinho/adicionar" method="post" class="d-flex align-center gap-1">
                                <input type="hidden" name="produto_id" value="{{p['id']}}">
                                <input type="number" name="quantidade" value="1" 
                                       min="1" max="{{p['estoque']}}" class="form-control" style="width: 80px;">
                                <button type="submit" class="btn btn-success">➕</button>
                                <a href="/loja/produto/{{p['id']}}" class="btn">🔍</a>
                            </form>
                        </div>
                    </div>
                    % end
                </div>
                % end
                
                <div class="mt-3 text-center">
                    <a href="/" class="btn">← Voltar</a>
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Loja Online</p>
        </footer>
    </div>
</body>
</html>