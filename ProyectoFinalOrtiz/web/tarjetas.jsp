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

