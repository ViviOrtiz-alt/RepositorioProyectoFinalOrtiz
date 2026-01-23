<%-- 
    Document   : marcarFavorita
    Created on : 22 ene 2026, 19:50:28
    Author     : Vivi Ortiz
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    //Validar sesión
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    //Capturar parámetros de acción y contenido
    String accion = request.getParameter("accion"); // agregar o quitar
    String tipoContenido = request.getParameter("tipo_contenido"); // tarjeta, video o chat
    String idContenidoStr = request.getParameter("id_contenido");

        // Verifica que se recibieron los parámetros necesarios
        if (accion != null && tipoContenido != null && idContenidoStr != null) {
        int idContenido = Integer.parseInt(idContenidoStr);

        // Si la acción es "agregar", inserta el contenido en la tabla de favoritos
        if ("agregar".equals(accion)) {
            PreparedStatement ps = conexion.prepareStatement(
                "INSERT INTO favoritos (id_usuario, tipo_contenido, id_contenido) VALUES (?, ?, ?)"
            );
            ps.setInt(1, idUsuario);
            ps.setString(2, tipoContenido);
            ps.setInt(3, idContenido);
            ps.executeUpdate();
            ps.close();
            
            
        // Si la acción es "quitar", elimina el contenido de favoritos
        } else if ("quitar".equals(accion)) {
            PreparedStatement ps = conexion.prepareStatement(
                "DELETE FROM favoritos WHERE id_usuario = ? AND tipo_contenido = ? AND id_contenido = ?"
            );
            ps.setInt(1, idUsuario);
            ps.setString(2, tipoContenido);
            ps.setInt(3, idContenido);
            ps.executeUpdate();
            ps.close();
        }

%>

