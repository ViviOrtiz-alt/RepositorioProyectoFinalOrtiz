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
    </head>
    <body>
        
    </body>
</html>
