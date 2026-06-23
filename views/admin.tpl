<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Área Administrativa - Mercado BIG BOM</title>
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
                <a href="/produtos" class="active">Produtos</a>
                <a href="/logout">Sair</a>
            </nav>
        </header>

        <main>
            <div class="card">
                <h1>👨‍💼 Área Administrativa</h1>
                <p class="text-muted mt-1">Bem-vindo, <strong>{{funcionario}}</strong>!</p>
                
                <div class="mt-3">
                    <div class="card">
                        <h3>📦 Gerenciar Produtos</h3>
                        <div class="d-flex flex-wrap gap-1 mt-2">
                            <a href="/produtos" class="btn">📋 Listar Produtos</a>
                            <a href="/produtos/novo" class="btn btn-success">➕ Adicionar Produto</a>
                        </div>
                    </div>
                    
                    <div class="card mt-2">
                        <h3>⚙️ Conta</h3>
                        <div class="mt-2">
                            <a href="/logout" class="btn btn-danger">🚪 Sair do Sistema</a>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Área Administrativa</p>
        </footer>
    </div>
</body>
</html>