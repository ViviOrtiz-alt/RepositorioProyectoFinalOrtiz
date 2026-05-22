<%-- 
    Document   : home
    Created on : 22 ene 2026, 12:33:15
    Author     : Vivi Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%@ include file="conexion.jsp" %>

<%
    // =========================
    // EVITAR CACHE
    // =========================

    response.setHeader(
        "Cache-Control",
        "no-cache, no-store, must-revalidate"
    );

    response.setHeader("Pragma", "no-cache");

    response.setDateHeader("Expires", 0);

    // =========================
    // VALIDAR SESIÓN
    // =========================

    if (session.getAttribute("correo") == null) {

        response.sendRedirect("index.jsp");
        return;
    }

    // =========================
    // TOAST CONFIRMACIÓN
    // =========================

    String ok = request.getParameter("ok");
%>

<!DOCTYPE html>

<html lang="es">

<head>

    <meta charset="utf-8" />

    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <title>Inteligencia Artificial</title>

    <link href="css/styles.css" rel="stylesheet" />

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
          rel="stylesheet">

</head>

<body>

<!-- TOAST -->
<% if ("1".equals(ok)) { %>

<div class="position-fixed bottom-0 end-0 p-3"
     style="z-index:1100">

    <div id="toastOk"
         class="toast align-items-center text-white bg-success border-0 show"
         role="alert"
         aria-live="assertive">

        <div class="d-flex">

            <div class="toast-body">

                ✅ Favorito actualizado correctamente.

            </div>

            <button type="button"
                    class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast">
            </button>

        </div>

    </div>

</div>

<% } %>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow">

    <div class="container">

        <a class="navbar-brand" href="#!">

            Aprendizaje Digital

        </a>

        <!-- NAV -->
        <ul class="navbar-nav ms-auto align-items-center">

            <li class="nav-item">

                <a class="nav-link"
                   href="favoritas.jsp">

                    <i class="bi bi-heart-fill text-danger"></i>

                    Favoritos

                </a>

            </li>

        </ul>

        <!-- DROPDOWN -->
        <div class="dropdown ms-2">

            <button class="btn btn-dark dropdown-toggle"
                    type="button"
                    data-bs-toggle="dropdown"
                    aria-expanded="false">

                ☰

            </button>

            <ul class="dropdown-menu dropdown-menu-end shadow">

                <li class="px-3 py-2 text-center">

                    <strong>

                        <%= session.getAttribute("nombre") %>

                    </strong>

                    <br>

                    <small class="text-muted">

                        <%= session.getAttribute("correo") %>

                    </small>

                </li>

                <li>

                    <hr class="dropdown-divider">

                </li>

                <!-- LOGOUT -->
                <li class="text-center">

                    <button type="button"
                            class="dropdown-item text-danger"
                            data-bs-toggle="modal"
                            data-bs-target="#modalLogout"
                            aria-label="Cerrar sesión">

                        Cerrar sesión

                    </button>

                </li>

            </ul>

        </div>

    </div>

</nav>

<!-- HEADER -->
<header class="py-5 home-bg-image-full"
        style="background-image: url('img/Fondo.jpg')">

    <div class="d-flex align-items-center justify-content-center"
         style="height: 20rem;">

        <a class="text-white fs-1 fw-bold text-decoration-none text-soft">

            Inteligencia Artificial

        </a>

    </div>

</header>

<!-- BIENVENIDA -->
<section class="container my-5 text-center">

    <h2 class="fw-bold mb-3">

        Bienvenido a Aprendizaje Digital

    </h2>

    <p class="text-muted mx-auto"
       style="max-width: 750px;">

        Este espacio está diseñado para facilitar el aprendizaje
        sobre la Inteligencia Artificial y sus aplicaciones actuales.

        Aquí podrás explorar recursos interactivos,
        herramientas prácticas y contenido pensado
        para reforzar tus conocimientos de manera clara y accesible.

        Selecciona una opción para comenzar.

    </p>

</section>

<!-- CARDS -->
<section class="container my-5">

    <div class="row g-3">

        <!-- CARD 1 -->
        <div class="col-md-6">

            <div class="card h-100 shadow-sm">

                <a href="tarjetas.jsp"
                   class="text-decoration-none">

                    <img src="img/Inicio.jpg"
                         class="card-img-top"
                         alt="Tarjetas de estudio">

                </a>

                <div class="card-body text-center">

                    <h5 class="card-title fw-bold">

                        Tarjetas de estudio

                    </h5>

                </div>

            </div>

        </div>

        <!-- CARD 2 -->
        <div class="col-md-6">

            <div class="card h-100 shadow-sm">

                <a href="videos.jsp"
                   class="text-decoration-none">

                    <img src="img/Inicio2.jpg"
                         class="card-img-top"
                         alt="Videos">

                </a>

                <div class="card-body text-center">

                    <h5 class="card-title fw-bold">

                        Videos

                    </h5>

                </div>

            </div>

        </div>

    </div>

</section>

<!-- IMAGEN -->
<div class="py-5 bg-image-full"
     style="background-image: url('img/Inicio3.jpg')">

    <div style="height: 20rem"></div>

</div>

<!-- CHATS -->
<section class="py-5">

    <div class="container my-5">

        <div class="row justify-content-center">

            <h2 class="text-center mb-4">

                Chats de apoyo

            </h2>

<%
    Integer idUsuario =
        (Integer) session.getAttribute("id_usuario");

    PreparedStatement ps =
        conexion.prepareStatement(
            "SELECT id_chat, titulo, descripcion, url_chat, icono FROM chats_home"
        );

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {

        int idChat = rs.getInt("id_chat");

        PreparedStatement psFav =
            conexion.prepareStatement(
                "SELECT 1 FROM favoritos " +
                "WHERE id_usuario = ? " +
                "AND tipo_contenido = 'chat' " +
                "AND id_contenido = ?"
            );

        psFav.setInt(1, idUsuario);
        psFav.setInt(2, idChat);

        ResultSet rsFav =
            psFav.executeQuery();

        boolean esFavorito =
            rsFav.next();

        rsFav.close();
        psFav.close();
%>

<!-- CHAT -->
<div class="card mb-3 shadow-sm">

    <div class="row g-0 align-items-center">

        <div class="col-md-3 text-center p-3">

            <img src="<%= rs.getString("icono") %>"
                 class="img-fluid"
                 style="max-height: 80px;"
                 alt="Icono chat">

        </div>

        <div class="col-md-9">

            <div class="card-body">

                <h5 class="card-title fw-bold">

                    <%= rs.getString("titulo") %>

                </h5>

                <p class="card-text text-muted">

                    <%= rs.getString("descripcion") %>

                </p>

                <!-- ABRIR CHAT -->
                <a href="<%= rs.getString("url_chat") %>"
                   target="_blank"
                   class="btn btn-outline-primary btn-sm me-2">

                    Abrir chat

                </a>

                <!-- FAVORITOS -->
                <% if (esFavorito) { %>

                    <!-- BOTÓN QUITAR -->
                    <button type="button"
                            class="btn btn-outline-danger btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#modalQuitar"
                            data-url="marcarFavorita.jsp?accion=quitar&tipo_contenido=chat&id_contenido=<%= idChat %>"
                            aria-label="Quitar de favoritos">

                        ❤️ Quitar de favoritos

                    </button>

                <% } else { %>

                    <!-- AGREGAR -->
                    <a href="marcarFavorita.jsp?accion=agregar&tipo_contenido=chat&id_contenido=<%= idChat %>"
                       class="btn btn-outline-warning btn-sm">

                        🤍 Marcar como favorito

                    </a>

                <% } %>

            </div>

        </div>

    </div>

</div>

<%
    }

    rs.close();
    ps.close();
%>

        </div>

    </div>

</section>

<!-- FOOTER -->
<footer class="py-5 bg-dark">

    <div class="container">

        <p class="m-0 text-center text-white">

            Copyright &copy; Viviana Ortiz Tellez

        </p>

    </div>

</footer>

<!-- MODAL LOGOUT -->
<div class="modal fade"
     id="modalLogout"
     tabindex="-1"
     aria-labelledby="modalLogoutLabel"
     aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title"
                    id="modalLogoutLabel">

                    Cerrar sesión

                </h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Cancelar">
                </button>

            </div>

            <div class="modal-body">

                ¿Estás seguro de que deseas cerrar sesión?

            </div>

            <div class="modal-footer">

                <button type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">

                    Cancelar

                </button>

                <a href="logout.jsp"
                   class="btn btn-danger"
                   aria-label="Confirmar cierre de sesión">

                    Sí, cerrar sesión

                </a>

            </div>

        </div>

    </div>

</div>

<!-- MODAL FAVORITOS -->
<div class="modal fade"
     id="modalQuitar"
     tabindex="-1"
     aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title">

                    Quitar de favoritos

                </h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal">
                </button>

            </div>

            <div class="modal-body">

                ¿Deseas quitar este chat de favoritos?

            </div>

            <div class="modal-footer">

                <button type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">

                    Cancelar

                </button>

                <a id="btnConfirmarQuitar"
                   href="#"
                   class="btn btn-danger">

                    Sí, quitar

                </a>

            </div>

        </div>

    </div>

</div>

<!-- BOOTSTRAP -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- SCRIPT MODAL -->
<script>

document.getElementById('modalQuitar')
.addEventListener('show.bs.modal', function(e) {

    var url =
        e.relatedTarget.getAttribute('data-url');

    document.getElementById('btnConfirmarQuitar')
    .setAttribute('href', url);

});

</script>

</body>

</html>