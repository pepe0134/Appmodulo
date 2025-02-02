﻿// ==========================
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
// Cambiar de Admin.aspx a Menu.aspx
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
            window.location.href = 'Menu.aspx';  // Redirige al menú post-login
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
    // Proteger acceso directo a Admin.aspx sin sesión activa
    if (window.location.pathname.includes('Admin.aspx')) {
        if (!sessionStorage.getItem('logueado')) {
            alert("Por favor inicia sesión para acceder.");
            window.location.href = 'Login.aspx';
        }
    }

    // Si la sesión es válida y estamos en Menu.aspx, no hacer nada
    if (window.location.pathname.includes('Menu.aspx')) {
        if (!sessionStorage.getItem('logueado')) {
            alert("Por favor inicia sesión para acceder.");
            window.location.href = 'Login.aspx';
        }
    }

    // Generar botones en Principal.aspx
    if (window.location.pathname.includes('Principal.aspx')) {
        generarBotones();
    }
}
16


// ==========================
// GENERACIÓN DE BOTONES (MÓDULOS) aa
// ==========================
let turnos = {};  // Almacenará el turno actual por módulo
let historialTurnos = {};  // Almacenará el historial de turnos de cada módulo

function generarBotones() {
    const contenedor = document.getElementById('botones-modulo');

    if (!contenedor) {
        console.warn("Contenedor 'botones-modulo' no encontrado.");
        return;
    }

    contenedor.innerHTML = '';  // Limpiar botones previos

    let modulosDisponibles = localStorage.getItem('modulos') || 5;

    for (let i = 1; i <= modulosDisponibles; i++) {
        const divModulo = document.createElement('div');
        divModulo.classList.add('modulo-contenedor');

        const botonModulo = document.createElement('button');
        botonModulo.textContent = `Módulo ${i}`;
        botonModulo.classList.add('boton-modulo');
        botonModulo.addEventListener('click', () => siguienteTurno(i));


        // Botón de repetir turno
        const botonRepetir = document.createElement('button');
        botonRepetir.textContent = 'Repetir';
        botonRepetir.classList.add('boton-secundario');
        botonRepetir.setAttribute('onclick', `repetirTurno(${i})`);

        // Botón de retroceder turno
        const botonRetroceder = document.createElement('button');
        botonRetroceder.textContent = 'Retroceder';
        botonRetroceder.classList.add('boton-secundario');
        botonRetroceder.setAttribute('onclick', `retrocederTurno(${i})`);

        // Añadir botones al contenedor del módulo
        divModulo.appendChild(botonModulo);
        divModulo.appendChild(botonRepetir);
        divModulo.appendChild(botonRetroceder);
        contenedor.appendChild(divModulo);

        // Inicializar turnos si no están definidos
        if (!turnos[i]) {
            turnos[i] = 1;
            historialTurnos[i] = [];
        }
    }
}

//prueba de cambios

// ==========================
// ASIGNACIÓN DE TURNOS
// ==========================

// Turno general para sincronizar módulos
let turnoGlobal = 1;

// Función para avanzar al siguiente turno
function siguienteTurno(modulo) {
    let turnosPrevios = JSON.parse(localStorage.getItem('turnosPrevios')) || [];

    // Obtener el rango máximo configurado (por defecto 99)
    let rangoMaximo = parseInt(localStorage.getItem('turnos') || '99');

    // Incrementar el turno global
    turnoGlobal++;

    // Si se excede el rango, volver a 1
    if (turnoGlobal > rangoMaximo) {
        turnoGlobal = 1;
    }

    turnos[modulo] = turnoGlobal;
    historialTurnos[modulo].push(turnoGlobal);

    turnosPrevios.push({ turno: turnoGlobal, modulo: modulo });

    // Mantener solo los últimos 6 turnos en la lista
    if (turnosPrevios.length > 6) {
        turnosPrevios = turnosPrevios.slice(-6);
    }

    localStorage.setItem('turnosPrevios', JSON.stringify(turnosPrevios));
    localStorage.setItem('turno', turnoGlobal);
    localStorage.setItem('modulo', modulo);

    document.getElementById('turno-actual').textContent = turnoGlobal.toString().padStart(3, '0');
    document.getElementById('modulo-actual').textContent = modulo;

    // Forzar actualización manual de Pantalla.aspx
    window.dispatchEvent(new Event('actualizarPantalla'));
}



// ==========================
// REPETIR Y RETROCEDER TURNOS
// ==========================



// Repetir Turno desde Principal.aspx
function repetirTurno(modulo) {
    if (historialTurnos[modulo].length > 0) {
        let ultimoTurno = historialTurnos[modulo][historialTurnos[modulo].length - 1];
        console.log(`Repetir turno ${ultimoTurno} para módulo ${modulo}`);

        // Actualizar turno mostrado
        actualizarTurno(modulo, ultimoTurno);

        // Guardar en localStorage
        localStorage.setItem('turno', ultimoTurno);
        localStorage.setItem('modulo', modulo);

        let turnosPrevios = JSON.parse(localStorage.getItem('turnosPrevios')) || [];
        turnosPrevios.push({ turno: ultimoTurno, modulo: modulo });

        if (turnosPrevios.length > 6) {
            turnosPrevios = turnosPrevios.slice(-6);
        }

        localStorage.setItem('turnosPrevios', JSON.stringify(turnosPrevios));
        localStorage.setItem('actualizacionPantalla', Date.now());

        enviarMensajePantalla();  // Notificar a Pantalla.aspx
    } else {
        console.log(`No hay turnos previos para repetir en módulo ${modulo}`);
    }
}

// Retroceder Turno desde Principal.aspx
function retrocederTurno(modulo) {
    if (historialTurnos[modulo].length > 1) {
        historialTurnos[modulo].pop();  // Eliminar último turno
        let turnoAnterior = historialTurnos[modulo][historialTurnos[modulo].length - 1];
        turnos[modulo] = turnoAnterior;

        console.log(`Retroceder al turno ${turnoAnterior} para módulo ${modulo}`);

        // Actualizar turno mostrado
        actualizarTurno(modulo, turnoAnterior);

        // Guardar en localStorage
        localStorage.setItem('turno', turnoAnterior);
        localStorage.setItem('modulo', modulo);

        let turnosPrevios = JSON.parse(localStorage.getItem('turnosPrevios')) || [];
        turnosPrevios.push({ turno: turnoAnterior, modulo: modulo });

        if (turnosPrevios.length > 6) {
            turnosPrevios = turnosPrevios.slice(-6);
        }

        localStorage.setItem('turnosPrevios', JSON.stringify(turnosPrevios));
        localStorage.setItem('actualizacionPantalla', Date.now());

        enviarMensajePantalla();  // Notificar a Pantalla.aspx
    } else {
        console.log(`No es posible retroceder en módulo ${modulo}`);
    }
}


// Función para enviar mensaje a Pantalla.aspx
function enviarMensajePantalla() {
    const pantalla = window.open('', 'pantallaTurnos');  // Nombre de la ventana o iframe
    if (pantalla) {
        pantalla.postMessage('actualizarPantalla', '*');  // Enviar mensaje para actualizar
    } else {
        console.log('Pantalla no encontrada.');
    }
}




// ==========================
// ACTUALIZACIÓN VISUAL
// ==========================

// Actualiza el turno mostrado
function actualizarTurno(modulo, turno = turnos[modulo]) {
    document.getElementById('turno-actual').textContent = turno.toString().padStart(3, '0');
    document.getElementById('modulo-actual').textContent = modulo;

    // Actualizar el título de turno en proceso (opcional)
    document.getElementById('turno-llamado').textContent = `Turno en Proceso: ${turno}`;
}

// ==========================
// INICIALIZACIÓN DE BOTONES
// ==========================
window.onload = function () {
    generarBotones();
}
