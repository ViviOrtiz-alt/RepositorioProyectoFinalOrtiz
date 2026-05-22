<%-- 
    Document   : favoritas
    Created on : 22 ene 2026, 13:54:18
    Author     : Vivi Ortiz
--%>

<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="conexion.jsp" %>

<%@ page import="java.sql.*" %>

<%
    // =========================
    // VALIDAR SESIÓN
    // =========================

    String correo =
        (String) session.getAttribute("correo");

    if (correo == null) {

        response.sendRedirect("index.jsp");
        return;
    }

    // =========================
    // TOAST CONFIRMACIÓN
    // =========================

    String ok =
        request.getParameter("ok");

    // =========================
    // OBTENER ID USUARIO
    // =========================

    int idUsuario = 0;

    PreparedStatement psId =
        conexion.prepareStatement(
            "SELECT id_usuario FROM usuarios WHERE correo = ?"
        );

    psId.setString(1, correo);

    ResultSet rsId =
        psId.executeQuery();

    if (rsId.next()) {

        idUsuario =
            rsId.getInt("id_usuario");
    }

    rsId.close();
    psId.close();
%>

<!DOCTYPE html>

<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>Mis Favoritas</title>

    <link href="css/styles.css"
          rel="stylesheet">

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
                   href="logout.jsp">

                    Cerrar sesión

                </a>

            </li>

        </ul>

    </div>

</nav>

<!-- TÍTULO -->
<h2 style="text-align:center;">

    Mis Favoritos

</h2>

<!-- CONTENEDOR -->
<div class="tarjetas-container">

<%
    // =========================
    // CONSULTAR FAVORITOS
    // =========================

    PreparedStatement ps =
        conexion.prepareStatement(

            "SELECT f.tipo_contenido, f.id_contenido, " +

            "t.titulo AS tarjeta_titulo, " +
            "t.frente, t.reverso, " +

            "v.titulo AS video_titulo, " +
            "v.descripcion, v.url_video, " +

            "c.titulo AS chat_titulo, " +
            "c.descripcion AS chat_descripcion " +

            "FROM favoritos f " +

            "LEFT JOIN tarjetas_estudio t " +
            "ON f.tipo_contenido='tarjeta' " +
            "AND f.id_contenido=t.id_tarjeta " +

            "LEFT JOIN videos v " +
            "ON f.tipo_contenido='video' " +
            "AND f.id_contenido=v.id_video " +

            "LEFT JOIN chats_home c " +
            "ON f.tipo_contenido='chat' " +
            "AND f.id_contenido=c.id_chat " +

            "WHERE f.id_usuario = ?"

        );

    ps.setInt(1, idUsuario);

    ResultSet rs =
        ps.executeQuery();

    while (rs.next()) {

        String tipo =
            rs.getString("tipo_contenido");

        // =========================
        // TARJETAS
        // =========================

        if ("tarjeta".equals(tipo)) {
%>

<div class="favorita tarjeta">

    <div class="tarjeta-inner">

        <div class="tarjeta-front">

            <h4>

                <%= rs.getString("tarjeta_titulo") %>

            </h4>

            <p>

                <%= rs.getString("frente") %>

            </p>

        </div>

        <div class="tarjeta-back">

            <p>

                <%= rs.getString("reverso") %>

            </p>

            <!-- BOTÓN MODAL -->
            <button type="button"
                    class="btn btn-sm btn-outline-danger mt-2"
                    data-bs-toggle="modal"
                    data-bs-target="#modalQuitar"
                    data-url="marcarFavorita.jsp?accion=quitar&tipo_contenido=tarjeta&id_contenido=<%= rs.getInt("id_contenido") %>"
                    aria-label="Quitar de favoritos">

                ❤️ Quitar de favoritos

            </button>

        </div>

    </div>

</div>

<%
        // =========================
        // VIDEOS
        // =========================

        } else if ("video".equals(tipo)) {
%>

<div class="favorita video">

    <h3>

        <%= rs.getString("video_titulo") %>

    </h3>

    <p>

        <%= rs.getString("descripcion") %>

    </p>

    <iframe src="<%= rs.getString("url_video") %>"
            frameborder="0"
            allowfullscreen>

    </iframe>

    <!-- BOTÓN MODAL -->
    <button type="button"
            class="btn btn-sm btn-outline-danger mt-2"
            data-bs-toggle="modal"
            data-bs-target="#modalQuitar"
            data-url="marcarFavorita.jsp?accion=quitar&tipo_contenido=video&id_contenido=<%= rs.getInt("id_contenido") %>"
            aria-label="Quitar de favoritos">

        ❤️ Quitar de favoritos

    </button>

</div>

<%
        // =========================
        // CHATS
        // =========================

        } else if ("chat".equals(tipo)) {
%>

<div class="favorita chat">

    <h3>

        <%= rs.getString("chat_titulo") %>

    </h3>

    <p>

        <%= rs.getString("chat_descripcion") %>

    </p>

    <a href="chat.jsp?id=<%= rs.getInt("id_contenido") %>">

        💬 Abrir chat

    </a>

    <br><br>

    <!-- BOTÓN MODAL -->
    <button type="button"
            class="btn btn-sm btn-outline-danger mt-2"
            data-bs-toggle="modal"
            data-bs-target="#modalQuitar"
            data-url="marcarFavorita.jsp?accion=quitar&tipo_contenido=chat&id_contenido=<%= rs.getInt("id_contenido") %>"
            aria-label="Quitar de favoritos">

        ❤️ Quitar de favoritos

    </button>

</div>

<%
        }
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

                ¿Deseas quitar este elemento de favoritos?

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