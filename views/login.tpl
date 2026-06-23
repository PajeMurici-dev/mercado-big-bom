<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Funcionário - Mercado BIG BOM</title>
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
                <a href="/login_cliente">Login Cliente</a>
            </nav>
        </header>

        <main>
            <div class="card" style="max-width: 400px; margin: 50px auto;">
                <div class="text-center">
                    <h2>👨‍💼 Login Funcionário</h2>
                    <p class="text-muted mt-2">Acesso à área administrativa</p>
                </div>
                
                % if erro:
                <div class="alert alert-danger mt-3">
                    {{ erro }}
                </div>
                % end
                
                <form action="/login" method="post" class="mt-3">
                    <div class="form-group">
                        <label for="usuario">Usuário:</label>
                        <input type="text" id="usuario" name="usuario" class="form-control" 
                               placeholder="Digite seu usuário" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="senha">Senha:</label>
                        <input type="password" id="senha" name="senha" class="form-control" 
                               placeholder="Digite sua senha" required>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-large w-100">
                            🔑 Entrar no Sistema
                        </button>
                    </div>
                </form>
                
                <div class="text-center mt-3">
                    <a href="/" class="btn btn-secondary btn-small">← Voltar</a>
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Área Administrativa</p>
        </footer>
    </div>
</body>
</html>