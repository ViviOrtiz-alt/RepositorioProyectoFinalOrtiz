<%-- 
    Document   : tarjetas
    Created on : 22 ene 2026, 19:01:36
    Author     : Vivi Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="conexion.jsp"%>

<%@page import="java.sql.*"%>

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

    <title>Tarjetas de Estudio</title>

    <link href="css/styles.css" rel="stylesheet">

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
<h2 style="text-align:center; margin-top: 20px; padding-top: 5px;">

    Tarjetas de Estudio – Inteligencia Artificial

</h2>

<!-- CONTENEDOR -->
<div class="tarjetas-container">

<%
    // =========================
    // CONSULTAR TARJETAS
    // =========================

    Statement st = conexion.createStatement();

    ResultSet rs =
        st.executeQuery(
            "SELECT * FROM tarjetas_estudio"
        );

    while (rs.next()) {

        int idTarjeta =
            rs.getInt("id_tarjeta");

        boolean esFavorita = false;

        // =========================
        // VALIDAR FAVORITOS
        // =========================

        PreparedStatement psFav =
            conexion.prepareStatement(
                "SELECT 1 FROM favoritos " +
                "WHERE id_usuario = ? " +
                "AND tipo_contenido = 'tarjeta' " +
                "AND id_contenido = ?"
            );

        psFav.setInt(1, idUsuario);
        psFav.setInt(2, idTarjeta);

        ResultSet rsFav =
            psFav.executeQuery();

        if (rsFav.next()) {
            esFavorita = true;
        }

        rsFav.close();
        psFav.close();
%>

<!-- TARJETA -->
<div class="tarjeta">

    <div class="tarjeta-inner">

        <!-- FRENTE -->
        <div class="tarjeta-front">

            <h4>

                <%= rs.getString("titulo") %>

            </h4>

            <p>

                <%= rs.getString("frente") %>

            </p>

        </div>

        <!-- REVERSO -->
        <div class="tarjeta-back">

            <p>

                <%= rs.getString("reverso") %>

            </p>

            <!-- FAVORITOS -->
            <% if (esFavorita) { %>

                <!-- BOTÓN QUITAR -->
                <button type="button"
                        class="btn btn-sm btn-outline-danger mt-2"
                        data-bs-toggle="modal"
                        data-bs-target="#modalQuitar"
                        data-url="marcarFavorita.jsp?accion=quitar&tipo_contenido=tarjeta&id_contenido=<%= idTarjeta %>"
                        aria-label="Quitar de favoritas">

                    <i class="bi bi-heart-fill"></i>

                    Quitar de favoritas

                </button>

            <% } else { %>

                <!-- AGREGAR FAVORITO -->
                <a href="marcarFavorita.jsp?accion=agregar&tipo_contenido=tarjeta&id_contenido=<%= idTarjeta %>"
                   class="btn btn-sm btn-outline-warning mt-2">

                    <i class="bi bi-heart"></i>

                    Marcar como favorita

                </a>

            <% } %>

        </div>

    </div>

</div>

<%
    }

    rs.close();
    st.close();
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

                    Quitar de favoritas

                </h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal">
                </button>

            </div>

            <div class="modal-body">

                ¿Deseas quitar esta tarjeta de favoritas?

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