<%-- 
    Document   : logout
    Created on : 22 ene 2026, 12:00:28
    Author     : Vivi Ortiz
--%>

<%-- logout.jsp — VERSIÓN CORREGIDA GROW --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="conexion.jsp"%>
<%
    // Registrar cierre de sesión en bitácora
    try {
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");
        if (idUsuario != null && conexion != null) {
            PreparedStatement ps = conexion.prepareStatement(
                "INSERT INTO bitacora_sesiones (id_usuario, accion) VALUES (?, 'logout')"
            );
            ps.setInt(1, idUsuario);
            ps.executeUpdate();
            ps.close();
        }
    } catch (Exception e) {
        // Error de bitácora no interrumpe el logout
    }
    session.invalidate();
    response.sendRedirect("index.jsp");
%>


