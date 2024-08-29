// Simulate service status checks
document.addEventListener('DOMContentLoaded', function() {
    const services = [
        { id: 'status-mariadb', status: 'Running' },
        { id: 'status-wordpress', status: 'Running' },
        { id: 'status-nginx', status: 'Running' },
        { id: 'status-redis', status: 'Running' },
        { id: 'status-adminer', status: 'Running' },
        { id: 'status-portainer', status: 'Running' }
    ];

    services.forEach(service => {
        document.getElementById(service.id).innerText = service.status;
    });
});
