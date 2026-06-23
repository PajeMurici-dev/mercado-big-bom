<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mercado BIG BOM - Página Inicial</title>
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
                <a href="/" class="active">Início</a>
                <a href="/loja">Loja</a>
                <a href="/login_cliente">Login Cliente</a>
                <a href="/login">Login Funcionário</a>
            </nav>
        </header>

        <main>
            <div class="card text-center">
                <h1>Bem-vindo ao Mercado BIG BOM</h1>
                <div id="ws-status" class="ws-status ws-disconnected">● Conectando...</div>
                
                <div class="mt-3">
                    <div class="d-flex flex-wrap justify-center gap-2">
                        <a href="/login" class="btn">👨‍💼 Login Funcionário</a>
                        <a href="/login_cliente" class="btn btn-success">👤 Login Cliente</a>
                        <a href="/loja" class="btn">🛒 Ver Loja</a>
                    </div>
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Sistema de Gerenciamento</p>
        </footer>
    </div>

    <script src="/static/js/websocket.js"></script>
    <script src="/static/js/script.js"></script>
</body>
</html>