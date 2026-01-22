<%-- 
    Document   : index
    Created on : 19 ene 2026, 10:31:06
    Author     : Vivi Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%@page import="java.sql.*, java.security.MessageDigest"%>

<%
    String correo = request.getParameter("correo");
    String password = request.getParameter("password");
    String mensaje = "";
    
    if(correo != null && password != null) {
        try {
            // Cifrar contraseña con SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());
            byte[] hash = md.digest();
            StringBuilder sb = new StringBuilder();
            for(byte b : hash) sb.append(String.format("%02x", b));
            String passwordCifrada = sb.toString();

            // Consultar usuario en la base de datos
            PreparedStatement ps = conexion.prepareStatement(
                "SELECT * FROM usuarios WHERE correo = ? AND password = ?"
            );
            ps.setString(1, correo);
            ps.setString(2, passwordCifrada);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                // Guardar datos en sesión
                int idUsuario = rs.getInt("id_usuario");
                String nombre = rs.getString("nombre");
                String correoBD = rs.getString("correo");

                session.setAttribute("id_usuario", idUsuario);
                session.setAttribute("nombre", nombre);
                session.setAttribute("correo", correoBD);

                // Redireccionar al home
                response.sendRedirect("home.jsp");
            } else {
                mensaje = "Correo o contraseña incorrectos";
            }

            rs.close();
            ps.close();
        } catch(Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    }
%>

<% if(!mensaje.isEmpty()) { %>
<script>
    alert("<%=mensaje%>");
    window.location.href="index.jsp";
</script>
<% } %>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inicio de sesión</title>

    <!-- Bootstrap CSS -->
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>

   
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">Aprendizaje Digital</a>
    </div>
</nav>


<!-- SECCIÓN DE FONDO -->
<section class="login-background" style="background-image:url('img/Fondo3.jpg')">
    
     <!-- LOGIN A LA DERECHA -->
    <div class="ms-auto" style="max-width: 500px; width: 100%;">
        <div class="card shadow p-4 card-login">

            <h3 class="text-center mb-3 fw-semibold">Bienvenido</h3>
            <p class="text-center text-muted mb-4">Inicia sesión para continuar</p>

            <form action="index.jsp" method="post">
                
                <!-- CORREO -->
                <div class="mb-3">
                    <label class="form-label text-muted">Correo electrónico</label>
                    <input type="email" class="form-control rounded-pill px-3"
                           name="correo" placeholder="correo@ejemplo.com" required>
                </div>

                <!-- CONTRASEÑA -->
                <div class="mb-3">
                    <label class="form-label text-muted">Contraseña</label>
                     <input type="password" class="form-control rounded-pill px-3"
                           name="password" placeholder="Ingrese su contraseña" required>
                </div>

                <!-- BOTÓN -->
                <div class="d-grid mt-4">
                    <button type="submit" class="btn btn-warning rounded-pill fw-semibold" style="background-color: #24343d; color: white;" >
                        Iniciar sesión
                    </button>
                </div>

            </form>

            <!-- ENLACES -->
            <div class="text-center mt-4">
                <p class="mb-1 text-muted">
                    ¿No tienes cuenta?
                    <a href="registroUsuario.jsp"
                       class="fw-semibold text-decoration-none text-black-50">
                        Regístrate aquí
                    </a>
                </p>
            </div>

        </div>
    </div>
</section>
    <!-- Footer-->
    <footer class="py-5 bg-dark">
        <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Viviana Ortiz Tellez</p></div>
    </footer>
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
 </body>
</html>

