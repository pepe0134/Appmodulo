<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="WebApplication1.Registro" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Usuario</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>

    <div class="contenedor">
        <h1>Registro de Usuario</h1>
     <form>
    <label for="nuevoUsuario">Usuario:</label>
    <input type="text" id="nuevoUsuario" required>

    <label for="nuevoCorreo">Correo Electrónico:</label>
    <input type="email" id="nuevoCorreo" required>

    <label for="nuevaContrasena">Contraseña:</label>
    <input type="password" id="nuevaContrasena" required>

    <button type="button" onclick="registrarUsuario(event)">Registrarse</button>
</form>


        <p>¿Ya tienes una cuenta? <a href="Login.aspx">Inicia sesión aquí</a></p>
        <p id="registroExitoso" style="color:green; display:none;">Registro exitoso. Inicia sesión.</p>

    </div>

    <script src="script.js" defer></script>

</body>
</html>
