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

    <!-- Generar botones y llamar turnos -->
    <script>
        // Generar botones para módulos dinámicamente
        document.addEventListener('DOMContentLoaded', function() {
            const contenedorBotones = document.getElementById('botones-modulo');
            
            // Crear botones para 6 módulos (puedes cambiar la cantidad)
            for (let i = 1; i <= 6; i++) {
                const boton = document.createElement('button');
                boton.textContent = 'Llamar Módulo ' + i;
                boton.onclick = function() {
                    siguienteTurno(i);  // Llama al turno para el módulo seleccionado
                };
                contenedorBotones.appendChild(boton);
            }
        });
    </script>

    <!-- Importar script principal -->
    <script src="script.js"></script>
</body>
</html>
