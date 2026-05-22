<%-- 
    Document   : marcarFavorita
    Created on : 22 ene 2026, 19:50:28
    Author     : Vivi Ortiz
--%>

<%-- marcarFavorita.jsp — VERSIÓN CORREGIDA GROW --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String accion = request.getParameter("accion");
    String tipoContenido = request.getParameter("tipo_contenido");
    String idContenidoStr = request.getParameter("id_contenido");

    if (accion != null && tipoContenido != null && idContenidoStr != null) {
        try {
            int idContenido = Integer.parseInt(idContenidoStr);
            if ("agregar".equals(accion)) {
                PreparedStatement ps = conexion.prepareStatement(
                    "INSERT IGNORE INTO favoritos (id_usuario, tipo_contenido, id_contenido) VALUES (?, ?, ?)"
                );
                ps.setInt(1, idUsuario);
                ps.setString(2, tipoContenido);
                ps.setInt(3, idContenido);
                ps.executeUpdate();
                ps.close();
            } else if ("quitar".equals(accion)) {
                PreparedStatement ps = conexion.prepareStatement(
                    "DELETE FROM favoritos WHERE id_usuario=? AND tipo_contenido=? AND id_contenido=?"
                );
                ps.setInt(1, idUsuario);
                ps.setString(2, tipoContenido);
                ps.setInt(3, idContenido);
                ps.executeUpdate();
                ps.close();
            }
        } catch (Exception e) {
            response.sendRedirect("error.jsp");
            return;
        }
    }
    // Redirigir con parámetro ok=1 para mostrar toast de confirmación
    if ("video".equals(tipoContenido)) {
        response.sendRedirect("videos.jsp?ok=1");
    } else if ("tarjeta".equals(tipoContenido)) {
        response.sendRedirect("tarjetas.jsp?ok=1");
    } else if ("chat".equals(tipoContenido)) {
        response.sendRedirect("home.jsp?ok=1");
    } else {
        response.sendRedirect("home.jsp");
    }
%>
