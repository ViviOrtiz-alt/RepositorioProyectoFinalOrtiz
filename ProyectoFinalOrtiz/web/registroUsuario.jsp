<%-- 
    Document   : registroUsuario
    Created on : 22 ene 2026, 8:56:57
    Author     : Vivi Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.sql.PreparedStatement"%>

<%
    String mensaje = "";
    String tipoMensaje = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String pass = request.getParameter("password");
        String confirmarPass = request.getParameter("confirmarPassword");

        if (!pass.equals(confirmarPass)) {
            mensaje = "Las contraseñas no coinciden";
            tipoMensaje = "danger";
        } else {
            try {
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                md.update(pass.getBytes());
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
                mensaje = "Ocurrió un error al registrar el usuario";
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
        
        <!-- Bootstrap CSS -->
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body>
    
    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home.jsp">Aprendizaje Digital</a>
        </div>
    </nav>

    <!-- CONTENIDO -->
<section class="py-5 bg-section" style="background-image:url('img/inteligencia-artificial.jpg')">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-body p-4">
                        <h3 class="text-center mb-3 fw-semibold">
                            Crear cuenta
                        </h3>

                        <% if (!mensaje.isEmpty()) { %>
                        <div class="alert alert-<%= tipoMensaje %> text-center" role="alert">
                            <%= mensaje %>
                        </div>
                        <% } %>

                        <p class="text-center text-muted mb-4">
                            Regístrate para acceder a la plataforma
                        </p>

                        <!-- Aquí va el formulario -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
    
    </body>
</html>
