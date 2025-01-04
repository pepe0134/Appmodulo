<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="WebApplication1.Menu" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú Principal</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <div class="contenedor">
        <h1>Selecciona una Opción</h1>
        <div class="opciones">
            <button onclick="window.location.href='Principal.aspx'">Solo Módulos</button>
            <button onclick="window.open('pantalla.aspx', '_blank')">Solo Pantalla</button>
        </div>
        <button onclick="guardarSesion()">Solo Módulos</button>

<script>
    function guardarSesion() {
        sessionStorage.setItem('logueado', true);
        window.location.href = 'Admin.aspx';
    }
</script>

    </div>
</body>
</html>
