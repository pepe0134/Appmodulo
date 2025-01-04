<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.Login" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>

    <div class="contenedor">
        <h1>Iniciar Sesión</h1>
        <form onsubmit="validarLogin(event)">
            <label for="usuario">Usuario:</label>
            <input type="text" id="usuario" required>

            <label for="contrasena">Contraseña:</label>
            <input type="password" id="contrasena" required>
            <button type="submit">Ingresar</button>
        </form>

        <p>¿No tienes una cuenta? <a href="Registro.aspx">Regístrate aquí</a></p>
        <p id="error" style="color:red; display:none;">Usuario o contraseña incorrectos</p>
    </div>

    <script src="script.js"></script>
    </body>
</html>
