<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication1.Admin" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Configuración de Módulos</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <div class="contenedor">
        <h1>Configuración del Sistema de Turnos</h1>
        <form onsubmit="guardarConfiguracion(event)">
            <label for="modulos">Número de Módulos:</label>
            <input type="number" id="modulos" min="1" max="20" value="5">
            
            <label for="turnos">Turnos (máx):</label>
            <input type="number" id="turnos" min="1" max="99" value="99">
            
            <button type="submit">Guardar Configuración</button>
        </form>

        <p id="mensaje" style="display:none;">Configuración Guardada ✔️</p>
        <a href="Principal.aspx">Ir a Pantalla de Turnos</a>
    </div>

    <script>
        function guardarConfiguracion(event) {
            event.preventDefault();

            let modulos = parseInt(document.getElementById('modulos').value);
            let turnos = parseInt(document.getElementById('turnos').value);

            // Guardar en LocalStorage
            localStorage.setItem('modulos', modulos);
            localStorage.setItem('turnos', turnos);

            console.log("Módulos guardados:", modulos);
            console.log("Turnos guardados:", turnos);

            document.getElementById('mensaje').style.display = 'block';
            setTimeout(() => {
                document.getElementById('mensaje').style.display = 'none';
            }, 2000);
        }

    </script>
</body>
</html>

