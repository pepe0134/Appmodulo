<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="WebApplication1.Principal" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Turnos</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>

    <div class="contenedor">
        <h1>Sistema de Turnos</h1>
        <div class="pantalla">
            <p><strong>TURNO:</strong> <span id="turno-actual">001</span></p>
            <p><strong>MÓDULO:</strong> <span id="modulo-actual">1</span></p>
        </div>

        <!-- Botones generados dinámicamente -->
        <div class="botones-modulo" id="botones-modulo">
            <!-- Se crearán los botones con JS -->
        </div>
    </div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const contenedorBotones = document.getElementById('botones-modulo');

        for (let i = 1; i <= 11; i++) {  // 11 módulos de ejemplo
            const divModulo = document.createElement('div');
            divModulo.classList.add('modulo-contenedor');

            const boton = document.createElement('button');
            boton.textContent = 'Módulo ' + i;
            boton.classList.add('boton-modulo');
            boton.onclick = function () {
                siguienteTurno(i);
                enviarEventoActualizacion();
            };

            const repetir = document.createElement('button');
            repetir.textContent = 'Repetir';
            repetir.classList.add('boton-secundario');
            repetir.onclick = function () {
                repetirTurno();
                enviarEventoActualizacion();
            };

            const retroceder = document.createElement('button');
            retroceder.textContent = 'Retroceder';
            retroceder.classList.add('boton-secundario');
            retroceder.onclick = function () {
                retrocederTurno();
                enviarEventoActualizacion();
            };

            divModulo.appendChild(boton);
            divModulo.appendChild(repetir);
            divModulo.appendChild(retroceder);

            contenedorBotones.appendChild(divModulo);
        }

        // Se ejecuta constantemente para evitar recargar con F5
        setInterval(() => {
            if (localStorage.getItem('actualizacion')) {
                window.dispatchEvent(new Event('actualizarPantalla'));
            }
        }, 500);
    });

    function enviarEventoActualizacion() {
        localStorage.setItem('actualizacion', Date.now());  // Marca de tiempo
        window.dispatchEvent(new Event('actualizarPantalla'));
    }
</script>

<script src="script.js"></script>
</body>
</html>

