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
    
<h2 style="margin: 10px 0;">Listado de videos</h2>

<%
    PreparedStatement ps = conexion.prepareStatement(
        "SELECT id_video, titulo, descripcion, url_video FROM videos"
    );
    ResultSet rs = ps.executeQuery();

  while (rs.next()) {

        int idVideo = rs.getInt("id_video");

        // 🔍 Verificar si el video es favorito
        PreparedStatement psFav = conexion.prepareStatement(
            "SELECT 1 FROM favoritos WHERE id_usuario = ? AND tipo_contenido = 'video' AND id_contenido = ?"
        );
        psFav.setInt(1, idUsuario);
        psFav.setInt(2, idVideo);

        ResultSet rsFav = psFav.executeQuery();
        boolean esFavorito = rsFav.next();

        rsFav.close();
        psFav.close();
%>

    <div class="favorita video">
        <h3><%= rs.getString("titulo") %></h3>
        <p><%= rs.getString("descripcion") %></p>

        <iframe
            src="<%= rs.getString("url_video") %>"
            frameborder="0"
            allowfullscreen>
        </iframe>

        <% if (esFavorito) { %>
            <a href="marcarFavorita.jsp?accion=quitar&tipo_contenido=video&id_contenido=<%= idVideo %>">
                ❤️ Quitar de favoritos
            </a>
        <% } else { %>
            <a href="marcarFavorita.jsp?accion=agregar&tipo_contenido=video&id_contenido=<%= idVideo %>">
                🤍 Marcar como favorito
            </a>
        <% } %>
    </div>

<%
    }
    rs.close();
    ps.close();
%>

<!-- Footer-->
<footer class="py-5 bg-dark">
    <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Viviana Ortiz Tellez</p></div>
</footer>

</body>
</html>
