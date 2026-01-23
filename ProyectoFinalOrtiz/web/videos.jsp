<%-- 
    Document   : videos
    Created on : 22 ene 2026, 20:20:41
    Author     : Vivi Ortiz
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    //  Validar sesión
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
    <title>Videos</title>
    <link href="css/styles.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home.jsp">Aprendizaje Digital</a>

        <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item">
                <a class="nav-link" href="home.jsp">
                    <i class="bi bi-house-fill"></i> Home
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="favoritas.jsp">
                    <i class="bi bi-heart-fill text-danger"></i> Mis Favoritas
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="logout.jsp">Cerrar sesión</a>
            </li>
        </ul>
    </div>
</nav> 
    
<h2>Listado de videos</h2>
