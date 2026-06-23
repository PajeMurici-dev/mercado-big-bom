class WebSocketManager {
    constructor() {
        this.ws = null;
        this.connected = false;
        this.reconnectAttempts = 0;
        this.maxReconnectAttempts = 5;
        this.messageHandlers = [];
        
        this.init();
    }
    
    init() {
        this.connect();
        
        document.addEventListener('visibilitychange', () => {
            if (document.visibilityState === 'visible' && !this.connected) {
                this.connect();
            }
        });
    }
    
    connect() {
        const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
        const wsUrl = `${protocol}//${window.location.host}/websocket`;
        
        this.ws = new WebSocket(wsUrl);
        
        this.ws.onopen = () => {
            console.log('WebSocket conectado');
            this.connected = true;
            this.reconnectAttempts = 0;
            this.showNotification('Conectado ao sistema em tempo real', 'success');
        };
        
        this.ws.onmessage = (event) => {
            const data = JSON.parse(event.data);
            this.handleMessage(data);
        };
        
        this.ws.onclose = () => {
            console.log('WebSocket desconectado');
            this.connected = false;
            this.showNotification('Conexão perdida. Reconectando...', 'warning');
            this.attemptReconnect();
        };
        
        this.ws.onerror = (error) => {
            console.error('Erro WebSocket:', error);
            this.showNotification('Erro na conexão', 'error');
        };
    }
    
    handleMessage(data) {
        console.log('Mensagem recebida:', data);
        
        this.messageHandlers.forEach(handler => {
            try {
                handler(data);
            } catch (error) {
                console.error('Erro no handler:', error);
            }
        });
        
        switch(data.type) {
            case 'message':
                this.showNotification(data.data.text || 'Nova mensagem', 'info');
                break;
                
            case 'product_update':
                this.handleProductUpdate(data.data);
                break;
                
            case 'client_update':
                this.handleClientUpdate(data.data);
                break;
        }
    }
    
    handleProductUpdate(productData) {
        if (window.location.pathname.includes('/produtos')) {
            this.showNotification(`Produto atualizado: ${productData.nome}`, 'info');
            
            setTimeout(() => {
                if (window.location.pathname === '/produtos') {
                    window.location.reload();
                }
            }, 2000);
        }
    }
    
    handleClientUpdate(clientData) {
        this.showNotification(`Novo cliente: ${clientData.nome}`, 'info');
    }
    
    sendMessage(type, data) {
        if (this.connected && this.ws) {
            this.ws.send(JSON.stringify({
                type: type,
                data: data
            }));
            return true;
        }
        return false;
    }
    
    onMessage(handler) {
        this.messageHandlers.push(handler);
    }
    
    attemptReconnect() {
        if (this.reconnectAttempts < this.maxReconnectAttempts) {
            this.reconnectAttempts++;
            const delay = Math.min(1000 * this.reconnectAttempts, 10000);
            
            console.log(`Tentando reconectar em ${delay}ms (tentativa ${this.reconnectAttempts})`);
            
            setTimeout(() => {
                this.connect();
            }, delay);
        }
    }
    
    showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <span>${message}</span>
            <button class="notification-close">&times;</button>
        `;
        
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            background: ${type === 'success' ? '#4CAF50' : 
                        type === 'error' ? '#f44336' : 
                        type === 'warning' ? '#ff9800' : '#2196F3'};
            color: white;
            border-radius: 5px;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            min-width: 300px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        `;
        
        
        notification.querySelector('.notification-close').onclick = () => {
            notification.remove();
        };
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 5000);
    }
}

let wsManager = null;

document.addEventListener('DOMContentLoaded', () => {
    wsManager = new WebSocketManager();
    
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', () => {
            if (wsManager && form.action.includes('/produtos/novo')) {
                setTimeout(() => {
                    wsManager.sendMessage('product_update', {
                        action: 'created',
                        message: 'Novo produto cadastrado'
                    });
                }, 1000);
            }
        });
    });
});