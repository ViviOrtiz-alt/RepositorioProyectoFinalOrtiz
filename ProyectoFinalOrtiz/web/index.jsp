<%-- 
    Document   : index
    Created on : 19 ene 2026, 10:31:06
    Author     : Vivi Ortiz
--%>

<%-- index.jsp — VERSIÓN CORREGIDA GROW --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>

<%@page import="java.sql.*"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.util.HashMap"%>

<%
    String correo   = request.getParameter("correo");
    String password = request.getParameter("password");
    String mensaje  = "";

    if (correo != null && password != null) {

        correo = correo.trim().toLowerCase();

        // =========================
        // OBTENER MAPAS DE SESIÓN
        // =========================

        HashMap<String, Integer> mapaIntentos =
            (HashMap<String, Integer>) session.getAttribute("mapaIntentos");

        HashMap<String, Long> mapaBloqueos =
            (HashMap<String, Long>) session.getAttribute("mapaBloqueos");

        // =========================
        // CREAR MAPAS SI NO EXISTEN
        // Compatible con Java 1.5
        // =========================

        if (mapaIntentos == null) {
            mapaIntentos = new HashMap<String, Integer>();
        }

        if (mapaBloqueos == null) {
            mapaBloqueos = new HashMap<String, Long>();
        }

        // =========================
        // OBTENER INTENTOS
        // Compatible con Java 1.5
        // =========================

        int intentos = 0;

        if (mapaIntentos.containsKey(correo)) {
            intentos = mapaIntentos.get(correo);
        }

        Long bloqueadoHasta = mapaBloqueos.get(correo);

        // =========================
        // VALIDAR BLOQUEO
        // =========================

        if (bloqueadoHasta != null &&
            System.currentTimeMillis() < bloqueadoHasta) {

            long min =
                (bloqueadoHasta - System.currentTimeMillis()) / 60000 + 1;

            mensaje =
                "Cuenta bloqueada. Intenta en " + min + " minuto(s).";

        } else {

            // =========================
            // LIMPIAR BLOQUEO EXPIRADO
            // =========================

            if (bloqueadoHasta != null &&
                System.currentTimeMillis() >= bloqueadoHasta) {

                mapaIntentos.remove(correo);
                mapaBloqueos.remove(correo);

                intentos = 0;
            }

            try {

                // =========================
                // CIFRAR PASSWORD
                // =========================

                MessageDigest md =
                    MessageDigest.getInstance("SHA-256");

                md.update(password.getBytes("UTF-8"));

                byte[] hash = md.digest();

                StringBuilder sb = new StringBuilder();

                for (byte b : hash) {
                    sb.append(String.format("%02x", b));
                }

                String passwordCifrada = sb.toString();

                // =========================
                // VALIDAR LOGIN
                // =========================

                PreparedStatement ps =
                    conexion.prepareStatement(
                        "SELECT * FROM usuarios " +
                        "WHERE correo = ? AND password = ?"
                    );

                ps.setString(1, correo);
                ps.setString(2, passwordCifrada);

                ResultSet rs = ps.executeQuery();

                // =========================
                // LOGIN CORRECTO
                // =========================

                if (rs.next()) {

                    session.setAttribute(
                        "id_usuario",
                        rs.getInt("id_usuario")
                    );

                    session.setAttribute(
                        "nombre",
                        rs.getString("nombre")
                    );

                    session.setAttribute(
                        "correo",
                        rs.getString("correo")
                    );

                    // Limpiar intentos
                    mapaIntentos.remove(correo);
                    mapaBloqueos.remove(correo);

                    session.setAttribute(
                        "mapaIntentos",
                        mapaIntentos
                    );

                    session.setAttribute(
                        "mapaBloqueos",
                        mapaBloqueos
                    );

                    rs.close();
                    ps.close();

                    response.sendRedirect("home.jsp");
                    return;

                } else {

                    // =========================
                    // LOGIN INCORRECTO
                    // =========================

                    intentos++;

                    mapaIntentos.put(correo, intentos);

                    if (intentos >= 5) {

                        mapaBloqueos.put(
                            correo,
                            System.currentTimeMillis()
                            + (15 * 60 * 1000L)
                        );

                        mensaje =
                            "Demasiados intentos. " +
                            "Cuenta bloqueada 15 minutos.";

                    } else {

                        mensaje =
                            "Correo o contraseña incorrectos. " +
                            "Intento " + intentos + " de 5.";
                    }

                    session.setAttribute(
                        "mapaIntentos",
                        mapaIntentos
                    );

                    session.setAttribute(
                        "mapaBloqueos",
                        mapaBloqueos
                    );
                }

                rs.close();
                ps.close();

            } catch (Exception e) {

                mensaje =
                    "Error interno. Intenta más tarde.";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inicio de sesión</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">Aprendizaje Digital</a>
    </div>
</nav>
<section class="login-background" style="background-image:url('img/Fondo3.jpg')">
    <div class="ms-auto" style="max-width:500px; width:100%;">
        <div class="card shadow p-4 card-login">
            <h3 class="text-center mb-3 fw-semibold">Bienvenido</h3>
            <p class="text-center text-muted mb-3">Inicia sesión para continuar</p>
            <div id="mensajeError" class="alert alert-danger"
                 role="alert"
                 style="display:<%= (mensaje != null && !mensaje.isEmpty()) ? "block" : "none" %>;">
                <%= mensaje != null ? mensaje : "" %>
            </div>
            <form id="formLogin" action="index.jsp" method="post">
                <div class="mb-3">
                    <label class="form-label text-muted">
                        Correo electrónico <span class="text-danger">*</span>
                    </label>
                    <input type="email" class="form-control rounded-pill px-3"
                           id="inputCorreo" name="correo"
                           placeholder="correo@ejemplo.com" required
                           tabindex="1" aria-label="Correo electrónico"
                           maxlength="254"
                           value="<%= correo != null ? correo : "" %>">
                </div>
                <div class="mb-3">
                    <label class="form-label text-muted">
                        Contraseña <span class="text-danger">*</span>
                    </label>
                    <input type="password" class="form-control rounded-pill px-3"
                           id="inputPass" name="password"
                           placeholder="Ingrese su contraseña" required
                           tabindex="2" aria-label="Contraseña"
                           maxlength="128">
                </div>
                <p class="text-muted" style="font-size:0.8rem;">
                    <span class="text-danger">*</span> Campos obligatorios
                </p>
                <div class="d-grid mt-4">
                    <button type="submit"
                            class="btn btn-warning rounded-pill fw-semibold"
                            style="background-color:#24343d; color:white;"
                            tabindex="3" aria-label="Iniciar sesión">
                        Iniciar sesión
                    </button>
                </div>
            </form>
            <div class="text-center mt-4">
                <p class="mb-1 text-muted">
                    ¿No tienes cuenta?
                    <a href="registroUsuario.jsp" class="fw-semibold text-decoration-none text-black-50">
                        Regístrate aquí
                    </a>
                </p>
                <div class="mt-2">
                    <a href="faq.jsp#recuperar" class="text-muted text-decoration-none" style="font-size:0.85rem;">
                        ¿Olvidaste tu contraseña?
                    </a>
                </div>
                <div class="mt-1">
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
</section>
<footer class="py-5 bg-dark">
    <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Viviana Ortiz Tellez</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById('formLogin').addEventListener('submit', function(e) {
    var correo = document.getElementById('inputCorreo').value.trim();
    var pass   = document.getElementById('inputPass').value;
    var regex  = /^[\w._%+\-]+@[\w.\-]+\.[a-zA-Z]{2,}$/;
    var errDiv = document.getElementById('mensajeError');
    if (!regex.test(correo)) {
      errDiv.textContent = 'El formato del correo no es válido.';
      errDiv.style.display = 'block';
      e.preventDefault(); return;
    }
    if (pass.length < 8) {
      errDiv.textContent = 'La contraseña debe tener al menos 8 caracteres.';
      errDiv.style.display = 'block';
      e.preventDefault();
    }
  });
</script>
</body>
</html>