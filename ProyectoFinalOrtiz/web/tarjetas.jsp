<%-- 
    Document   : tarjetas
    Created on : 22 ene 2026, 19:01:36
    Author     : Vivi Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%@page import="java.sql.*"%>


<%
    //Validar sesión
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    //Acción para favoritos
    String accion = request.getParameter("accion");
    String idTarjetaStr = request.getParameter("id_tarjeta");

    if (accion != null && idTarjetaStr != null) {
        int idTarjeta = Integer.parseInt(idTarjetaStr);

        // Agrega la tarjeta a favoritos
        if ("agregar".equals(accion)) {
            PreparedStatement ps = conexion.prepareStatement(
                "INSERT INTO favoritos (id_usuario, tipo_contenido, id_contenido) VALUES (?, 'tarjeta', ?)"
            );
            ps.setInt(1, idUsuario);
            ps.setInt(2, idTarjeta);
            ps.executeUpdate();
            ps.close();

        // Elimina la tarjeta de favoritos
        } else if ("quitar".equals(accion)) {
            PreparedStatement ps = conexion.prepareStatement(
                "DELETE FROM favoritos WHERE id_usuario = ? AND tipo_contenido = 'tarjeta' AND id_contenido = ?"
            );
            ps.setInt(1, idUsuario);
            ps.setInt(2, idTarjeta);
            ps.executeUpdate();
            ps.close();
        }
    }
%>



<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Tarjetas de Estudio</title>
</head>
<body>

<h2>Tarjetas de Estudio</h2>

</body>
</html>

