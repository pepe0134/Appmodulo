<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pantalla.aspx.cs" Inherits="WebApplication1.Pantalla" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pantalla de Turnos</title>
    <link rel="stylesheet" href="Style.css">
    <style>
        .turno-destacado {
            font-size: 8rem;
            color: #1f5aa6;
            font-weight: bold;
        }
        .modulo-destacado {
            font-size: 5rem;
            color: #e74c3c;
            font-weight: bold;
        }
        .tabla-turnos th, .tabla-turnos td {
            font-size: 2.5rem;
            text-align: center;
        }
        .tabla-turnos th {
            background-color: #e74c3c;
            color: white;
        }
    </style>
</head>
<body>

    <div class="pantalla">
        <div class="cabecera">
            <div class="logo">
                &nbsp;</div>
            <div class="fecha-hora">
                <div id="fecha">
                <img src="logo.png" alt="LOGO" style="height: 101px; width: 106px" /></div>
                <div id="hora"></div>
            </div>
        </div>

        <div class="turno-actual">
            <h2>TURNO</h2>
            <div class="turno-destacado" id="turno-llamado">--- </div>
            <p>MÓDULO <span class="modulo-destacado" id="modulo-actual">--</span></p>
        </div>

        <div class="tabla-turnos">
            <h2>ÚLTIMOS NÚMEROS LLAMADOS</h2>
            <table>
                <thead>
                    <tr>
                        <th>TURNO</th>
                        <th>MÓDULO</th>
                    </tr>
                </thead>
                <tbody id="lista-turnos">
                </tbody>
            </table>
        </div>
    </div>

<script>
    function actualizarPantalla() {
        const turno = localStorage.getItem('turno') || '---';
        const modulo = localStorage.getItem('modulo') || '--';

        document.getElementById('turno-llamado').textContent = turno.padStart(3, '0');
        document.getElementById('modulo-actual').textContent = modulo;

        const turnosPrevios = JSON.parse(localStorage.getItem('turnosPrevios')) || [];
        let tablaHtml = '';

        turnosPrevios.slice(-4).reverse().forEach(item => {
            tablaHtml += `
            <tr>
                <td>${item.turno}</td>
                <td>${item.modulo}</td>
            </tr>`;
        });

        document.getElementById('lista-turnos').innerHTML = tablaHtml;
    }

    window.addEventListener('actualizarPantalla', () => {
        console.log("Evento recibido en Pantalla.aspx");
        actualizarPantalla();
    });

 
    actualizarPantalla();

    // Actualización completa cada 500 ms
    setInterval(() => {
        actualizarPantalla();
    }, 500);

    // Escuchar cambios en localStorage para actualizar la pantalla
    window.addEventListener('storage', (event) => {
        if (event.key === 'actualizacionPantalla') {
            console.log("Pantalla.aspx detectó un cambio. Actualizando...");
            actualizarPantalla();
        }
    });

    // Escuchar mensajes desde Principal.aspx
    window.addEventListener('message', (event) => {
        if (event.data === 'actualizarPantalla') {
            console.log("Mensaje recibido en Pantalla.aspx. Actualizando...");
            actualizarPantalla();
        }
    });


</script>

</body>
</html>

