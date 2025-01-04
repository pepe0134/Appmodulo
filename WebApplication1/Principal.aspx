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
            <h2>TURNO: <span id="numero-turno">001</span></h2>
            <h3>MÓDULO: <span id="numero-modulo">1</span></h3>
        </div>

        <div class="botones-modulo" id="botones-modulo">

            <!-- Botones se generan dinámicamente aquí -->
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
