<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Minha Conta - Mercado BIG BOM</title>
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
                <a href="/loja/carrinho">Carrinho</a>
                <a href="/logout_cliente">Sair</a>
            </nav>
        </header>

        <main>
            <div class="card">
                <h1>👤 Minha Conta</h1>
                
                <div class="card mt-2">
                    <h3>📋 Informações da Conta</h3>
                    <table class="table mt-2">
                        <tr>
                            <th>Nome:</th>
                            <td>{{cliente["nome"]}}</td>
                        </tr>
                        <tr>
                            <th>ID do Cliente:</th>
                            <td><strong>{{cliente["id"]}}</strong></td>
                        </tr>
                        <tr>
                            <th>CEP:</th>
                            <td>{{cliente["cep"]}}</td>
                        </tr>
                    </table>
                </div>
                
                <div class="card mt-2">
                    <h3>🛒 Menu de Opções</h3>
                    <div class="d-flex flex-wrap gap-1 mt-2">
                        <a href="/loja" class="btn">🛍️ Ir para Loja</a>
                        <a href="/loja/carrinho" class="btn btn-success">🛒 Meu Carrinho</a>
                        <a href="/" class="btn">🏠 Página Inicial</a>
                        <a href="/logout_cliente" class="btn btn-danger">🚪 Sair</a>
                    </div>
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Área do Cliente</p>
        </footer>
    </div>
</body>
</html>