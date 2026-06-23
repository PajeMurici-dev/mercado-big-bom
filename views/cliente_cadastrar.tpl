<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Cliente - Mercado BIG BOM</title>
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
                <a href="/login_cliente">Login</a>
            </nav>
        </header>

        <main>
            <div class="card" style="max-width: 400px; margin: 50px auto;">
                <div class="text-center">
                    <h2>📝 Novo Cliente</h2>
                    <p class="text-muted mt-2">Crie sua conta para comprar na loja</p>
                </div>
                
                % if erro:
                <div class="alert alert-danger mt-3">
                    {{ erro }}
                </div>
                % end
                
                <form action="/cadastrar_cliente" method="post" class="mt-3">
                    <div class="form-group">
                        <label for="nome">Nome Completo:</label>
                        <input type="text" id="nome" name="nome" class="form-control" 
                               placeholder="Digite seu nome completo" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="senha">Senha:</label>
                        <input type="password" id="senha" name="senha" class="form-control" 
                               placeholder="Crie uma senha segura" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="cep">CEP:</label>
                        <input type="text" id="cep" name="cep" class="form-control" 
                               placeholder="00000-000" pattern="\d{5}-?\d{3}" required>
                        <small class="text-muted">Formato: 12345-678</small>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-success btn-large w-100">
                            ✅ Criar Minha Conta
                        </button>
                    </div>
                </form>
                
                <div class="text-center mt-3">
                    <p class="text-muted">Já tem uma conta? 
                        <a href="/login_cliente" class="btn btn-small">🔑 Faça login aqui</a>
                    </p>
                    <a href="/" class="btn btn-secondary btn-small mt-1">← Voltar</a>
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Cadastro de Clientes</p>
        </footer>
    </div>
</body>
</html>