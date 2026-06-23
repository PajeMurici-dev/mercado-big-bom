<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro Realizado - Mercado BIG BOM</title>
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
            <div class="card text-center" style="max-width: 600px; margin: 0 auto;">
                <div class="alert alert-success">
                    <h2 style="margin: 0;">✅ Cadastro Realizado com Sucesso!</h2>
                </div>
                
                <div class="card mt-3">
                    <h3>📋 Seus Dados Cadastrados</h3>
                    <table class="table mt-2">
                        <tr>
                            <th>Nome:</th>
                            <td>{{cliente_nome}}</td>
                        </tr>
                        <tr>
                            <th>CEP:</th>
                            <td>{{cliente_cep}}</td>
                        </tr>
                        <tr>
                            <th>ID do Cliente:</th>
                            <td><strong>{{cliente_id}}</strong></td>
                        </tr>
                    </table>
                    
                    <div class="alert alert-info mt-2">
                        <p><strong>⚠️ Guarde seu ID para futuras consultas!</strong></p>
                    </div>
                </div>
                
                <div class="d-flex flex-wrap justify-center gap-2 mt-3">
                    <a href="/login_cliente" class="btn btn-success">📲 Fazer Login</a>
                    <a href="/" class="btn">🏠 Página Inicial</a>
                    <a href="/loja" class="btn">🛒 Ir para Loja</a>
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Cadastro Concluído</p>
        </footer>
    </div>
</body>
</html>