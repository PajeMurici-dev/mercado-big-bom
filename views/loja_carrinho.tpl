<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrinho - Mercado BIG BOM</title>
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
                <a href="/loja/carrinho" class="active">Carrinho</a>
                % if 'cliente_id' in request.cookies:
                    <a href="/cliente_area">Minha Conta</a>
                    <a href="/logout_cliente">Sair</a>
                % else:
                    <a href="/login_cliente">Login</a>
                % end
            </nav>
        </header>

        <main>
            <div class="card">
                <h1>🛒 Carrinho de Compras</h1>
                
                <div class="d-flex justify-between align-center mt-2">
                    <a href="/loja" class="btn">← Continuar Comprando</a>
                    % if produtos:
                    <a href="/loja/carrinho/limpar" class="btn btn-danger" 
                       onclick="return confirm('Tem certeza?')">🗑️ Limpar</a>
                    % end
                </div>
                
                % if not produtos:
                <div class="alert alert-info mt-3 text-center">
                    <h3>Seu carrinho está vazio</h3>
                    <p class="text-muted mt-2">Adicione produtos para continuar</p>
                    <a href="/loja" class="btn btn-success mt-2">🛍️ Ir para Loja</a>
                </div>
                % else:
                <div class="card mt-3">
                    % for p in produtos:
                    <div class="d-flex justify-between align-center mb-2 pb-2 border-bottom">
                        <div>
                            <h4 style="margin: 0;">{{p['nome']}}</h4>
                            <p class="text-muted">R$ {{'%.2f' % p['preco']}} cada</p>
                        </div>
                        
                        <div class="d-flex align-center gap-1">
                            <form action="/loja/carrinho/atualizar" method="post" class="d-flex align-center gap-1">
                                <input type="hidden" name="produto_id" value="{{p['id']}}">
                                <input type="number" name="quantidade" value="{{p['quantidade']}}" 
                                       min="0" max="100" class="form-control" style="width: 80px;">
                                <button type="submit" class="btn btn-small">🔄</button>
                            </form>
                            
                            <span class="ml-2" style="min-width: 100px; text-align: right;">
                                R$ {{'%.2f' % p['subtotal']}}
                            </span>
                            
                            <form action="/loja/carrinho/atualizar" method="post">
                                <input type="hidden" name="produto_id" value="{{p['id']}}">
                                <input type="hidden" name="quantidade" value="0">
                                <button type="submit" class="btn btn-small btn-danger ml-1"
                                        onclick="return confirm('Remover?')">🗑️</button>
                            </form>
                        </div>
                    </div>
                    % end
                    
                    <div class="mt-3 pt-3 border-top">
                        <h3 class="text-right">Total: R$ {{'%.2f' % total}}</h3>
                    </div>
                    
                    <div class="d-flex justify-between mt-3">
                        <a href="/loja" class="btn">← Continuar Comprando</a>
                        <a href="/loja/finalizar" class="btn btn-success btn-large">
                            ✅ Finalizar Compra
                        </a>
                    </div>
                </div>
                % end
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Carrinho de Compras</p>
        </footer>
    </div>
</body>
</html>