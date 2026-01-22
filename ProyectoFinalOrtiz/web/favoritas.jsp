<%-- 
    Document   : favoritas
    Created on : 22 ene 2026, 13:54:18
    Author     : Vivi Ortiz
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="conexion.jsp" %>
<%@ page import="java.sql.*" %>

<%
    // Validar sesión
    String correo = (String) session.getAttribute("correo");
    if(correo == null){
        response.sendRedirect("index.jsp");
        return;
    }

 // Obtener id_usuario
    int idUsuario = 0;
    PreparedStatement psId = conexion.prepareStatement(
        "SELECT id_usuario FROM usuarios WHERE correo = ?"
    );
    psId.setString(1, correo);
    ResultSet rsId = psId.executeQuery();

    if(rsId.next()){
        idUsuario = rsId.getInt("id_usuario");
    }

    rsId.close();
    psId.close();
%>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Favoritas</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>

<h2 style="text-align:center;">Mis Favoritos</h2>

</body>
</html>
