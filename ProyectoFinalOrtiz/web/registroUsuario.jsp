<%-- 
    Document   : registroUsuario
    Created on : 22 ene 2026, 8:56:57
    Author     : Vivi Ortiz
--%>

<%-- registroUsuario.jsp — VERSIÓN CORREGIDA GROW --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.sql.PreparedStatement"%>

<%
    String mensaje = "";
    String tipoMensaje = "";
    String nombrePrev = "";
    String correoPrev = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String pass = request.getParameter("password");
        String confirmarPass = request.getParameter("confirmarPassword");
        if (nombre == null) nombre = "";
        if (correo == null) correo = "";
        nombrePrev = nombre;
        correoPrev = correo;

        if (nombre.trim().length() < 2 || nombre.trim().length() > 100) {
            mensaje = "El nombre debe tener entre 2 y 100 caracteres.";
            tipoMensaje = "danger";
        } else if (!nombre.matches("^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$")) {
            mensaje = "El nombre solo puede contener letras y espacios.";
            tipoMensaje = "danger";
        } else if (correo == null || correo.length() > 254 ||
                   !correo.matches("^[\\w._%+\\-]+@[\\w.\\-]+\\.[a-zA-Z]{2,}$")) {
            mensaje = "El formato del correo no es válido.";
            tipoMensaje = "danger";
        } else if (pass == null || pass.length() < 8 || pass.length() > 128 ||
                   !pass.matches(".*[A-Z].*") || !pass.matches(".*[0-9].*")) {
            mensaje = "La contraseña debe tener mínimo 8 caracteres, una mayúscula y un número.";
            tipoMensaje = "danger";
        } else if (!pass.equals(confirmarPass)) {
            mensaje = "Las contraseñas no coinciden.";
            tipoMensaje = "danger";
        } else {
            try {
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                md.update(pass.getBytes("UTF-8"));
                byte[] hash = md.digest();
                StringBuilder sb = new StringBuilder();
                for (byte b : hash) sb.append(String.format("%02x", b));
                String passwordCifrada = sb.toString();

                PreparedStatement ps = conexion.prepareStatement(
                    "INSERT INTO usuarios(nombre, correo, password) VALUES (?,?,?)"
                );
                ps.setString(1, nombre);
                ps.setString(2, correo);
                ps.setString(3, passwordCifrada);
                ps.executeUpdate();
                ps.close();

                mensaje = "Registro exitoso. Ahora puedes iniciar sesión.";
                tipoMensaje = "success";
            } catch (Exception e) {
                mensaje = "Ocurrió un error al registrar el usuario.";
                tipoMensaje = "danger";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de usuario</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home.jsp">Aprendizaje Digital</a>
    </div>
</nav>
<section class="py-5 bg-section" style="background-image:url('img/inteligencia-artificial.jpg')">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-body p-4">
                        <h3 class="text-center mb-3 fw-semibold">Crear cuenta</h3>
                        <% if (!mensaje.isEmpty()) { %>
                        <div class="alert alert-<%= tipoMensaje %> text-center" role="alert">
                            <%= mensaje %>
                        </div>
                        <% } %>
                        <p class="text-center text-muted mb-4">Regístrate para acceder a la plataforma</p>
                        <form action="registroUsuario.jsp" method="post">
                            <div class="mb-3">
                                <label class="form-label text-muted">
                                    Nombre completo <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control rounded-pill px-3"
                                       name="nombre" id="inputNombre" maxlength="100"
                                       placeholder="Ingrese su nombre" required
                                       tabindex="1" aria-label="Nombre completo"
                                       value="<%= nombrePrev %>">
                                <small id="contadorNombre" class="text-muted">100 caracteres disponibles</small>
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted">
                                    Correo electrónico <span class="text-danger">*</span>
                                </label>
                                <input type="email" class="form-control rounded-pill px-3"
                                       name="correo" id="inputCorreo"
                                       placeholder="correo@ejemplo.com" required
                                       tabindex="2" aria-label="Correo electrónico"
                                       maxlength="254"
                                       value="<%= correoPrev %>">
                                <small id="contadorCorreo" class="text-muted">254 caracteres disponibles</small>
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted">
                                    Contraseña <span class="text-danger">*</span>
                                </label>
                                <input type="password" class="form-control rounded-pill px-3"
                                       name="password" id="inputPass"
                                       placeholder="Mín. 8 chars, 1 mayúscula, 1 número" required
                                       tabindex="3" aria-label="Contraseña"
                                       maxlength="128">
                                <div id="passStrength" class="mt-1" style="font-size:0.8rem;"></div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted">
                                    Confirmar contraseña <span class="text-danger">*</span>
                                </label>
                                <input type="password" class="form-control rounded-pill px-3"
                                       name="confirmarPassword" id="inputConfirm"
                                       placeholder="Repita la contraseña" required
                                       tabindex="4" aria-label="Confirmar contraseña"
                                       maxlength="128">
                            </div>
                            <p class="text-muted" style="font-size:0.8rem;">
                                <span class="text-danger">*</span> Campos obligatorios
                            </p>
                            <div class="d-grid mt-4">
                                <button type="submit"
                                        class="btn btn-warning rounded-pill fw-semibold"
                                        tabindex="5" aria-label="Registrarse">
                                    Registrarse
                                </button>
                            </div>
                        </form>
                        <div class="text-center mt-4">
                            <p class="mb-1 text-muted">
                                ¿Ya tienes cuenta?
                                <a href="index.jsp" class="fw-semibold text-decoration-none text-black-50">
                                    Inicia sesión
                                </a>
                            </p>
                            <div class="mt-2">
                                <a href="faq.jsp" class="text-muted text-decoration-none me-3" style="font-size:0.85rem;">
                                    Preguntas Frecuentes
                                </a>
                                <a href="faq.jsp#privacidad" class="text-muted text-decoration-none" style="font-size:0.85rem;">
                                    Políticas de Privacidad
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<footer class="py-4 bg-dark">
    <div class="container text-center">
        <p class="m-0 text-white">© Viviana Ortiz Tellez</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Contador: Nombre
  var inp = document.getElementById('inputNombre');
  var cnt = document.getElementById('contadorNombre');
  if (inp && cnt) {
    inp.addEventListener('input', function () {
      var r = 100 - inp.value.length;
      cnt.textContent = r + ' caracteres disponibles';
      cnt.style.color = r < 50 ? 'red' : '#6c757d';
    });
  }

  // Contador: Correo
  var inpCorreo = document.getElementById('inputCorreo');
  var cntCorreo = document.getElementById('contadorCorreo');
  if (inpCorreo && cntCorreo) {
    inpCorreo.addEventListener('input', function () {
      var r = 254 - inpCorreo.value.length;
      cntCorreo.textContent = r + ' caracteres disponibles';
      cntCorreo.style.color = r < 50 ? 'red' : '#6c757d';
    });
  }

  // Indicador de fortaleza de contraseña
  var passInp = document.getElementById('inputPass');
  var passDiv = document.getElementById('passStrength');
  if (passInp && passDiv) {
    passInp.addEventListener('input', function () {
      var v = passInp.value;
      var fuerte = v.length >= 8 && /[A-Z]/.test(v) && /[0-9]/.test(v);
      var media  = v.length >= 8 && (/[A-Z]/.test(v) || /[0-9]/.test(v));
      if (fuerte)     { passDiv.textContent = 'Fortaleza: Fuerte'; passDiv.style.color = 'green'; }
      else if (media) { passDiv.textContent = 'Fortaleza: Media';  passDiv.style.color = 'orange'; }
      else            { passDiv.textContent = 'Fortaleza: Débil';  passDiv.style.color = 'red'; }
    });
  }
</script>
</body>
</html>