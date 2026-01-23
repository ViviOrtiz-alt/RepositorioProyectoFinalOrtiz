<%-- 
    Document   : videos
    Created on : 22 ene 2026, 20:20:41
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
%>
