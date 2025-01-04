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
    <div class="pantalla">
        <div class="cabecera">
            <div class="fecha" id="fecha"></div>
            <div class="hora" id="hora"></div>
        </div>

        <div class="titulo">
            <h1>AQUÍ INGRESAR NOMBRE DE ENTIEDAD</h1>
            <p>SUB INFORMACIÓN DE IDENTIDAD</p>
        </div>

        <div class="tabla-turnos">
            <table>
                <thead>
                    <tr>
                        <th>NÚMERO</th>
                        <th>MÓDULO</th>
                    </tr>
                </thead>
                <tbody id="lista-turnos">
                    <tr>
                        <td id="turno-pantalla">--</td>
                        <td id="modulo-pantalla">--</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function actualizarPantalla() {
            const turno = localStorage.getItem('turno') || '--';
            const modulo = localStorage.getItem('modulo') || '--';

            document.getElementById('turno-pantalla').textContent = turno;
            document.getElementById('modulo-pantalla').textContent = modulo;
        }

        function actualizarHoraFecha() {
            const now = new Date();
            const fecha = now.toLocaleDateString('es-ES', { weekday: 'long', day: 'numeric', month: 'long' });
            const hora = now.toLocaleTimeString();

            document.getElementById('fecha').textContent = fecha;
            document.getElementById('hora').textContent = hora;
        }

        setInterval(actualizarPantalla, 1000);  // Actualizar turnos cada segundo
        setInterval(actualizarHoraFecha, 1000); // Actualizar hora en tiempo real
    </script>
</body>
</html>
