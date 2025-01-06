<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pantalla.aspx.cs" Inherits="WebApplication1.Pantalla" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pantalla de Turnos</title>
    <link rel="stylesheet" href="Style.css">
    <style type="text/css">
        .auto-style1 {
            width: 763px;
        }
        .auto-style2 {
            width: 98%;
        }
    </style>
</head>
<body>

    <div class="pantalla">
        <!-- Cabecera con Logo y Hora -->
        <div class="cabecera">
            <div class="logo">
                &nbsp;<img src="logo.png" alt="LOGO" style="height: 101px; width: 106px" /></div>
            <div class="fecha-hora">
                <div id="fecha"></div>
                <div id="hora"></div>
            </div>
        </div>

        <!-- Tabla con los Últimos Turnos Llamados -->
        <div class="tabla-turnos">
            <table class="auto-style2">
                <thead>
                    <tr>
                        <th class="auto-style1">MÓDULO</th>
                        <th>TURNO</th>
                    </tr>
                </thead>
                <tbody id="lista-turnos">
                    <!-- Los turnos se llenarán dinámicamente -->
                </tbody>
            </table>
        </div>

        <!-- Turno en Pantalla Grande (Actual) -->
        <div class="turno-actual">
            <h2>TURNO</h2>
            <div class="turno-destacado">
                <span id="turno-llamado">EM-010</span>
                <p>MÓDULO <span id="modulo-actual">2</span></p>
            </div>
        </div>

        <!-- Mensaje de Bienvenida -->
        <div class="mensaje-bienvenida">
            Bienvenidos, nuestro horario de atención es de...
        </div>

    </div>

    <!-- Script para Actualizar la Hora y la Lista de Turnos -->
  <script>
      if (!localStorage.getItem('rangoMaximo')) {
          localStorage.setItem('rangoMaximo', 99);  // Por defecto 99
      }

      function actualizarHoraFecha() {
          const now = new Date();
          const fecha = now.toLocaleDateString('es-ES', { weekday: 'long', day: 'numeric', month: 'long' });
          const hora = now.toLocaleTimeString();

          document.getElementById('fecha').textContent = fecha;
          document.getElementById('hora').textContent = hora;
      }

      // Actualiza Turnos en Pantalla desde LocalStorage
      function actualizarTurnoDinamico() {
          const turno = localStorage.getItem('turno') || '---';
          const modulo = localStorage.getItem('modulo') || '--';

          document.getElementById('turno-llamado').textContent = turno;
          document.getElementById('modulo-actual').textContent = modulo;

          // Obtener lista de turnos previos
          const turnosPrevios = JSON.parse(localStorage.getItem('turnosPrevios')) || [];
          let tablaHtml = '';

          turnosPrevios.slice(-6).reverse().forEach(item => {
              tablaHtml += `
                <tr>
                    <td>${item.modulo}</td>
                    <td>${item.turno}</td>
                </tr>
            `;
          });

          document.getElementById('lista-turnos').innerHTML = tablaHtml;
      }

      // Escuchar Cambios en LocalStorage (cuando se llama desde otra ventana)
      window.addEventListener('actualizarPantalla', () => {
          actualizarTurnoDinamico();
      });

      // Actualización manual de la tabla de turnos
      function actualizarTurnoDinamico() {
          const turno = localStorage.getItem('turno') || '---';
          const modulo = localStorage.getItem('modulo') || '--';

          document.getElementById('turno-llamado').textContent = turno;
          document.getElementById('modulo-actual').textContent = modulo;

          const turnosPrevios = JSON.parse(localStorage.getItem('turnosPrevios')) || [];
          let tablaHtml = '';

          turnosPrevios.slice(-6).reverse().forEach(item => {
              tablaHtml += `
            <tr>
                <td>${item.modulo}</td>
                <td>${item.turno}</td>
            </tr>
        `;
          });

          document.getElementById('lista-turnos').innerHTML = tablaHtml;
      }

  </script>





</body>
</html>
