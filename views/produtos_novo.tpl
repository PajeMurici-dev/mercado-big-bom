<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Novo Produto - Mercado BIG BOM</title>
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
                <a href="/admin">Admin</a>
                <a href="/produtos">Produtos</a>
                <a href="/logout">Sair</a>
            </nav>
        </header>

        <main>
            <div class="card" style="max-width: 600px; margin: 0 auto;">
                <h1>➕ Novo Produto</h1>
                
                <form action="/produtos/novo" method="post">
                    <div class="form-group">
                        <label for="nome">Nome do Produto:</label>
                        <input type="text" id="nome" name="nome" class="form-control" 
                               placeholder="Ex: Arroz 5kg" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="preco">Preço (R$):</label>
                        <input type="number" id="preco" name="preco" step="0.01" min="0" class="form-control"
                               placeholder="Ex: 25.90" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="estoque">Quantidade em Estoque:</label>
                        <input type="number" id="estoque" name="estoque" min="0" class="form-control"
                               placeholder="Ex: 100" required>
                    </div>
                    
                    <div class="form-group d-flex gap-1">
                        <button type="submit" class="btn btn-success">💾 Salvar Produto</button>
                        <a href="/produtos" class="btn">❌ Cancelar</a>
                    </div>
                </form>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Cadastro de Produtos</p>
        </footer>
    </div>
</body>
</html>