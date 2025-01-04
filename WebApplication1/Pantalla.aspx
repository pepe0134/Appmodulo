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

    <!-- Contenedor Principal de Pantalla -->
    <div class="pantalla">

        <!-- Cabecera con Fecha y Hora -->
        <div class="cabecera">
            <div id="fecha"></div>
            <div id="hora"></div>
        </div>

        <!-- Título y Subtítulo de la Entidad -->
        <div class="titulo">
            <h1>AQUÍ INGRESAR NOMBRE DE ENTIDAD</h1>
            <p>SUB INFORMACIÓN DE IDENTIDAD</p>
        </div>

        <!-- Tabla para Mostrar Turnos y Módulos -->
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
                        <td>3</td>
                        <td>2</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Script para Actualizar Hora y Fecha -->
    <script>
        // Actualiza la Hora y Fecha en Tiempo Real
        function actualizarHoraFecha() {
            const now = new Date();
            const fecha = now.toLocaleDateString('es-ES', { weekday: 'long', day: 'numeric', month: 'long' });
            const hora = now.toLocaleTimeString();

            document.getElementById('fecha').textContent = fecha;
            document.getElementById('hora').textContent = hora;
        }

        // Ejecuta la Función Cada Segundo
        setInterval(actualizarHoraFecha, 1000);
        actualizarHoraFecha();  // Llama a la función para mostrar hora/fecha de inmediato
    </script>

</body>
</html>
