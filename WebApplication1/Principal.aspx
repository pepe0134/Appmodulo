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
            
            <div 
                id="botones-modulo">

            </div>

        </div>

        <div class="botones-modulo" id="botones-modulo">

            <!-- Botones se generan dinámicamente aquí -->
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
