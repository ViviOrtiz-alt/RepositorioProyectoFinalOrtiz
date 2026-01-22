<%-- 
    Document   : home
    Created on : 22 ene 2026, 12:33:15
    Author     : Vivi Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    // Evita que la página se almacene en la memoria cache del navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Verifica si el usuario ha iniciado sesión
    // Si no hay sesión activa, redirige a la página de login
    if (session.getAttribute("correo") == null) {
        response.sendRedirect("index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Inteligencia Artificial</title>
    
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
    
    <!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow">
        <div class="container">
            <a class="navbar-brand" href="#!">Aprendizaje Digital</a>
        </div>
    </nav>

    <header class="py-5 home-bg-image-full" style="background-image: url('img/Fondo.jpg')">
        <div class="d-flex align-items-center justify-content-center" style="height: 20rem;">
            <a class="text-white fs-1 fw-bold text-decoration-none text-soft">Inteligencia Artificial</a>
        </div>
    </header>
    
    <section class="container my-5 text-center">
    <h2 class="fw-bold mb-3">Bienvenido a Aprendizaje Digital</h2>
    <p class="text-muted mx-auto" style="max-width: 750px;">
        Este espacio está diseñado para facilitar el aprendizaje sobre la Inteligencia Artificial 
        y sus aplicaciones actuales. Aquí podrás explorar recursos interactivos, herramientas 
        prácticas y contenido pensado para reforzar tus conocimientos de manera clara y accesible.
        Selecciona una opción para comenzar.
    </p>
</section>

<!-- Sección de opciones con tarjetas (cards) -->
<section class="container my-5">
    <div class="row g-3">
        
        <!-- Primera tarjeta -->
        <div class="col-md-6">
            <div class="card h-100 shadow-sm">
                <a href="tarjetas.jsp" class="text-decoration-none">
                    <img src="img/Inicio.jpg" class="card-img-top" alt="Tarjetas de estudio">
                </a>
                <div class="card-body text-center">
                    <h5 class="card-title fw-bold">Tarjetas de estudio</h5>
                </div>
            </div>
        </div>
        
        <!-- Segunda tarjeta -->
        <div class="col-md-6">
            <div class="card h-100 shadow-sm">
                <a href="videos.jsp" class="text-decoration-none">
                    <img src="img/Inicio2.jpg" class="card-img-top" alt="Opción 2">
                </a>
                <div class="card-body text-center">
                    <h5 class="card-title fw-bold">Videos</h5>
                </div>
            </div>
        </div>
    </div>
</section>

    
</body>
</html>

