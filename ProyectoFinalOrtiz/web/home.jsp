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
         <!-- Opciones del nav -->
        <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item">
                <a class="nav-link" href="favoritas.jsp">
                    <i class="bi bi-heart-fill text-danger"></i> Favoritos
                </a>
            </li>
        </ul>

        <!-- Menú usuario -->
        <div class="dropdown ms-2">
            <button class="btn btn-dark dropdown-toggle"
                    type="button"
                    data-bs-toggle="dropdown"
                    aria-expanded="false">
                ☰
            </button>

            <ul class="dropdown-menu dropdown-menu-end shadow">
                <li class="px-3 py-2 text-center">
                    <strong><%= session.getAttribute("nombre") %></strong><br>
                    <small class="text-muted">
                        <%= session.getAttribute("correo") %>
                    </small>
                </li>

                <li><hr class="dropdown-divider"></li>

                <li class="text-center">
                    <form action="logout.jsp" method="post" class="m-0">
                        <button type="submit" class="dropdown-item text-danger">
                            Cerrar sesión
                        </button>
                    </form>
                </li>
            </ul>
        </div>
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

<div class="py-5 bg-image-full" style="background-image: url('img/Inicio3.jpg')">
            <!-- Put anything you want here! The spacer below with inline CSS is just for demo purposes!-->
            <div style="height: 20rem"></div>
        </div>

<!-- Sección principal de chats de apoyo -->
<section class="py-5">
    <div class="container my-5">
        <div class="row justify-content-center">
            <h2 class="text-center mb-4">Chats de apoyo</h2>

<%
    // Captura el ID del usuario de la sesión actual
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");

    // Consulta a la base de datos para obtener todos los chats disponibles
    PreparedStatement ps = conexion.prepareStatement(
        "SELECT id_chat, titulo, descripcion, url_chat, icono FROM chats_home"
    );
    ResultSet rs = ps.executeQuery();

    // Itera sobre cada chat para mostrarlo en la página
    while (rs.next()) {
        int idChat = rs.getInt("id_chat");

        // Verifica si este chat está marcado como favorito por el usuario
        PreparedStatement psFav = conexion.prepareStatement(
            "SELECT 1 FROM favoritos WHERE id_usuario = ? AND tipo_contenido = 'chat' AND id_contenido = ?"
        );
        psFav.setInt(1, idUsuario);
        psFav.setInt(2, idChat);

        ResultSet rsFav = psFav.executeQuery();
        boolean esFavorito = rsFav.next();

        // Cierra recursos de la consulta de favoritos
        rsFav.close();
        psFav.close();
%>

<!-- Tarjeta individual del chat -->
<div class="card mb-3 shadow-sm">
    <div class="row g-0 align-items-center">
        <div class="col-md-3 text-center p-3">
            <img src="<%= rs.getString("icono") %>" class="img-fluid" style="max-height: 80px;" alt="Icono chat">
        </div>
        <div class="col-md-9">
            <div class="card-body">
                <h5 class="card-title fw-bold"><%= rs.getString("titulo") %></h5>
                <p class="card-text text-muted"><%= rs.getString("descripcion") %></p>
                <a href="<%= rs.getString("url_chat") %>" target="_blank" class="btn btn-outline-primary btn-sm me-2">Abrir chat</a>
                <% if (esFavorito) { %>
                    <a href="marcarFavorita.jsp?accion=quitar&tipo_contenido=chat&id_contenido=<%= idChat %>" class="btn btn-outline-danger btn-sm">❤️ Quitar de favoritos</a>
                <% } else { %>
                    <a href="marcarFavorita.jsp?accion=agregar&tipo_contenido=chat&id_contenido=<%= idChat %>" class="btn btn-outline-warning btn-sm">🤍 Marcar como favorito</a>
                <% } %>
            </div>
        </div>
    </div>
</div>

<%
    }// Fin del while que recorre los chats
    // Cierre de recursos de la consulta principal
    rs.close();
    ps.close();
%>

        </div>
    </div>
</section>
    
<!-- Footer-->
<footer class="py-5 bg-dark">
    <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Viviana Ortiz Tellez</p>
    </div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

