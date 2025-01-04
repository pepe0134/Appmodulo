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
        botonModulo.setAttribute('onclick', `siguienteTurno(${i})`);

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
function siguienteTurno(modulo) {
    let turnoActual = localStorage.getItem('turno') || 1;
    alert(`Turno ${turnoActual} asignado al módulo ${modulo}`);
    turnoActual++;
    localStorage.setItem('turno', turnoActual);
}

// Función para avanzar al siguiente turno
function siguienteTurno(modulo) {
    turnos[modulo]++;
    historialTurnos[modulo].push(turnos[modulo]);
    actualizarTurno(modulo);
}

// Función para repetir el último turno
function repetirTurno(modulo) {
    if (historialTurnos[modulo].length > 0) {
        let ultimoTurno = historialTurnos[modulo][historialTurnos[modulo].length - 1];
        alert(`Repetir turno ${ultimoTurno} para módulo ${modulo}`);
        actualizarTurno(modulo, ultimoTurno);
    } else {
        alert(`No hay turnos previos para repetir en módulo ${modulo}`);
    }
}

// Función para retroceder al turno anterior
function retrocederTurno(modulo) {
    if (historialTurnos[modulo].length > 1) {
        historialTurnos[modulo].pop();  // Elimina el último turno
        let turnoAnterior = historialTurnos[modulo][historialTurnos[modulo].length - 1];
        turnos[modulo] = turnoAnterior;
        alert(`Retroceder al turno ${turnoAnterior} para módulo ${modulo}`);
        actualizarTurno(modulo, turnoAnterior);
    } else {
        alert(`No es posible retroceder en módulo ${modulo}`);
    }
}

// Actualiza el turno mostrado
function actualizarTurno(modulo, turno = turnos[modulo]) {
    document.getElementById('turno-actual').textContent = turno.toString().padStart(3, '0');
    document.getElementById('modulo-actual').textContent = modulo;
}


window.onload = function () {
    generarBotones();
}
