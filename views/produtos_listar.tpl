<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Produtos - Mercado BIG BOM</title>
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
                <a href="/produtos" class="active">Produtos</a>
                <a href="/logout">Sair</a>
            </nav>
        </header>

        <main>
            <div class="card">
                <div class="d-flex justify-between align-center">
                    <h1>📦 Gerenciar Produtos</h1>
                    <a href="/produtos/novo" class="btn btn-success">➕ Novo Produto</a>
                </div>
                
                % if produtos:
                <div class="mt-3">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Preço</th>
                                <th>Estoque</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            % for p in produtos:
                            <tr>
                                <td>{{p["id"]}}</td>
                                <td>{{p["nome"]}}</td>
                                <td>R$ {{'%.2f' % p["preco"]}}</td>
                                <td>
                                    <span class="badge {% if p['estoque'] <= 10 %}badge-danger{% elif p['estoque'] <= 20 %}badge-warning{% else %}badge-success{% end %}">
                                        {{p["estoque"]}} unidades
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex gap-1">
                                        <a href="/produtos/editar/{{p['id']}}" class="btn btn-small">✏️ Editar</a>
                                        <a href="/produtos/deletar/{{p['id']}}" class="btn btn-small btn-danger" 
                                           onclick="return confirm('Tem certeza?')">🗑️ Excluir</a>
                                    </div>
                                </td>
                            </tr>
                            % end
                        </tbody>
                    </table>
                </div>
                % else:
                <div class="alert alert-info mt-3 text-center">
                    <h3>Nenhum produto cadastrado</h3>
                    <p class="text-muted">Comece cadastrando seu primeiro produto</p>
                    <a href="/produtos/novo" class="btn btn-success mt-2">➕ Cadastrar Primeiro Produto</a>
                </div>
                % end
                
                <div class="mt-3">
                    <a href="/admin" class="btn">← Voltar para Admin</a>
                </div>
            </div>
        </main>

        <footer class="footer">
            <p>© 2025 Mercado BIG BOM - Gerenciamento de Produtos</p>
        </footer>
    </div>
</body>
</html>