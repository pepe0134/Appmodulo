<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pantalla.aspx.cs" Inherits="WebApplication1.Pantalla" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pantalla de Turnos</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <div class="pantalla-turno">
        <h1 id="turno-pantalla">Turno: 000</h1>
        <h2 id="modulo-pantalla">Módulo: --</h2>
    </div>

    <script>
        function actualizarPantalla() {
            const turno = localStorage.getItem('turno') || '000';
            const modulo = localStorage.getItem('modulo') || '--';

            document.getElementById('turno-pantalla').textContent = `Turno: ${turno}`;
            document.getElementById('modulo-pantalla').textContent = `Módulo: ${modulo}`;
        }

        setInterval(actualizarPantalla, 1000);  // Actualizar cada segundo
    </script>
</body>
</html>
