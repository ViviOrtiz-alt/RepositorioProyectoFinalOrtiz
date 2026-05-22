<%-- 
    Document   : videos
    Created on : 22 ene 2026, 20:20:41
    Author     : Vivi Ortiz
--%>

<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%@ include file="conexion.jsp" %>

<%
    // =========================
    // VALIDAR SESIÓN
    // =========================

    Integer idUsuario =
        (Integer) session.getAttribute("id_usuario");

    if (idUsuario == null) {

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

    <meta charset="UTF-8">

    <title>Videos</title>

    <link href="css/styles.css" rel="stylesheet">

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

        <a class="navbar-brand fw-bold"
           href="home.jsp">

            Aprendizaje Digital

        </a>

        <ul class="navbar-nav ms-auto align-items-center">

            <li class="nav-item">

                <a class="nav-link"
                   href="home.jsp">

                    <i class="bi bi-house-fill"></i>

                    Home

                </a>

            </li>

            <li class="nav-item">

                <a class="nav-link"
                   href="favoritas.jsp">

                    <i class="bi bi-heart-fill text-danger"></i>

                    Mis Favoritas

                </a>

            </li>

            <li class="nav-item">

                <a class="nav-link"
                   href="logout.jsp">

                    Cerrar sesión

                </a>

            </li>

        </ul>

    </div>

</nav>

<!-- TÍTULO -->
<h2 style="margin: 10px 0; text-align: center;">

    Listado de videos

</h2>

<!-- CONTENEDOR -->
<div class="listado-videos">

<%
    PreparedStatement ps =
        conexion.prepareStatement(
            "SELECT id_video, titulo, descripcion, url_video FROM videos"
        );

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {

        int idVideo = rs.getInt("id_video");

        // =========================
        // VALIDAR FAVORITO
        // =========================

        PreparedStatement psFav =
            conexion.prepareStatement(
                "SELECT 1 FROM favoritos " +
                "WHERE id_usuario = ? " +
                "AND tipo_contenido = 'video' " +
                "AND id_contenido = ?"
            );

        psFav.setInt(1, idUsuario);
        psFav.setInt(2, idVideo);

        ResultSet rsFav = psFav.executeQuery();

        boolean esFavorito = rsFav.next();

        rsFav.close();
        psFav.close();
%>

<!-- VIDEO -->
<div class="video-card">

    <h3>

        <%= rs.getString("titulo") %>

    </h3>

    <p>

        <%= rs.getString("descripcion") %>

    </p>

    <iframe
        src="<%= rs.getString("url_video") %>"
        frameborder="0"
        allowfullscreen>

    </iframe>

    <!-- FAVORITOS -->
    <% if (esFavorito) { %>

        <!-- BOTÓN QUITAR -->
        <button type="button"
                class="btn btn-outline-danger btn-sm mt-2"
                data-bs-toggle="modal"
                data-bs-target="#modalQuitar"
                data-url="marcarFavorita.jsp?accion=quitar&tipo_contenido=video&id_contenido=<%= idVideo %>"
                aria-label="Quitar de favoritos">

            ❤️ Quitar de favoritos

        </button>

    <% } else { %>

        <!-- AGREGAR FAVORITO -->
        <a href="marcarFavorita.jsp?accion=agregar&tipo_contenido=video&id_contenido=<%= idVideo %>"
           class="btn btn-outline-warning btn-sm mt-2">

            🤍 Marcar como favorito

        </a>

    <% } %>

</div>

<%
    }

    rs.close();
    ps.close();
%>

</div>

<!-- FOOTER -->
<footer class="py-5 bg-dark">

    <div class="container">

        <p class="m-0 text-center text-white">

            Copyright &copy; Viviana Ortiz Tellez

        </p>

    </div>

</footer>

<!-- MODAL -->
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

                ¿Deseas quitar este video de favoritos?

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