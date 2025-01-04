// ==========================
// REGISTRO DE USUARIOS
// ==========================
window.registrarUsuario = function (event) {
    event.preventDefault();
    console.log("Función registrarUsuario llamada.");

    let usuario = document.getElementById('nuevoUsuario').value.trim();
    let correo = document.getElementById('nuevoCorreo').value.trim();
    let contrasena = document.getElementById('nuevaContrasena').value.trim();

    if (usuario === "" || correo === "" || contrasena === "") {
        alert("Por favor completa todos los campos.");
        return;
    }

    if (localStorage.getItem(usuario)) {
        alert("El usuario ya está registrado. Inicia sesión.");
        window.location.href = 'Login.aspx';
        return;
    }

    let usuarioData = {
        correo: correo,
        contrasena: contrasena
    };

    localStorage.setItem(usuario, JSON.stringify(usuarioData));
    alert("Registro exitoso. Redirigiendo al inicio de sesión...");
    window.location.href = 'Login.aspx';
}

// Mensaje de prueba para asegurar que se carga la función
console.log("Función registrarUsuario añadida al objeto window.");

// ==========================
// INICIO DE SESIÓN
// ==========================
window.validarLogin = function (event) {
    event.preventDefault();
    console.log("Intentando iniciar sesión...");

    let usuario = document.getElementById('usuario').value.trim();
    let contrasena = document.getElementById('contrasena').value.trim();

    if (usuario === "" || contrasena === "") {
        alert("Por favor ingresa usuario y contraseña.");
        return;
    }

    let datosUsuario = localStorage.getItem(usuario);

    if (datosUsuario) {
        let usuarioObj = JSON.parse(datosUsuario);
        console.log("Usuario encontrado:", usuarioObj);

        if (usuarioObj.contrasena === contrasena) {
            alert("Bienvenido " + usuario);
            sessionStorage.setItem('logueado', true);  // Guardar sesión activa
            window.location.href = 'Admin.aspx';  // Redirigir al panel de administración
        } else {
            alert("Contraseña incorrecta.");
        }
    } else {
        alert("Usuario no encontrado. Regístrate primero.");
    }
}

// ==========================
// PROTECCIÓN DE Admin.aspx
// ==========================
window.onload = function () {
    // Evitar acceso directo a Admin.aspx sin haber iniciado sesión
    if (window.location.pathname.includes('Admin.aspx')) {
        if (!sessionStorage.getItem('logueado')) {
            alert("Por favor inicia sesión para acceder.");
            window.location.href = 'Login.aspx';
        }
    }

    // Generar botones en la página principal (si aplica)
    if (window.location.pathname.includes('Principal.aspx')) {
        generarBotones();
    }
}

// ==========================
// GENERACIÓN DE BOTONES (MÓDULOS)
// ==========================
function generarBotones() {
    const contenedor = document.getElementById('botones-modulo');

    // Verificar que el contenedor exista antes de manipularlo
    if (!contenedor) {
        console.warn("Contenedor 'botones-modulo' no encontrado.");
        return;
    }

    contenedor.innerHTML = '';  // Limpiar botones previos

    let modulosDisponibles = localStorage.getItem('modulos') || 5;  // Por defecto 5 módulos

    console.log("Módulos cargados desde LocalStorage:", modulosDisponibles);

    // Generar botones dinámicamente
    for (let i = 1; i <= modulosDisponibles; i++) {
        const boton = document.createElement('button');
        boton.textContent = `Módulo ${i}`;
        boton.classList.add('boton-modulo');
        boton.setAttribute('onclick', `siguienteTurno(${i})`);
        contenedor.appendChild(boton);
    }
}

// ==========================
// ASIGNACIÓN DE TURNOS
// ==========================
function siguienteTurno(modulo) {
    let turnoActual = localStorage.getItem('turno') || 1;
    alert(`Turno ${turnoActual} asignado al módulo ${modulo}`);
    turnoActual++;
    localStorage.setItem('turno', turnoActual);
}
