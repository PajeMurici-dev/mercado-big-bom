<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Compra Finalizada - Mercado BIG BOM</title>
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
                % if 'cliente_id' in request.cookies:
                    <a href="/cliente_area">Minha Conta</a>
                    <a href="/logout_cliente">Sair</a>
                % else:
                    <a href="/login_cliente">Login</a>
                % end
            </nav>
        </header>

        <main>
            <div class="card text-center" style="max-width: 600px; margin: 0 auto;">
                <div class="alert alert-success">
                    <h2 style="margin: 0;">✅ Compra Finalizada com Sucesso!</h2>
                </div>
                
                <div class="card mt-3">
                    <h3>📋 Resumo do Pedido</h3>
                    <table class="table mt-2">
                        <tr>
                            <th>Número do Pedido:</th>
                            <td><strong>#{{pedido_id}}</strong></td>
                        </tr>
                        <tr>
                            <th>Total:</th>
                            <td style="font-size: 24px; color: var(--roxo-principal); font-weight: bold;">
                                R$ {{'%.2f' % total}}
                            </td>
                        </tr>
                    </table>
                    
                    <div class="alert alert-info mt-2">
                        <p>Seu pedido foi registrado com sucesso!</p>
                    </div>
                </div>
                
                <div class="d-flex flex-wrap justify-center gap-2 mt-3">
                    <a href="/loja" class="btn btn-success">🛍️ Continuar Comprando</a>
                    <a href="/" class="btn">🏠 Página Inicial</a>
                    <a href="/cliente_area" class="btn">👤 Minha Conta</a>
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Compra Finalizada</p>
        </footer>
    </div>
</body>
</html>