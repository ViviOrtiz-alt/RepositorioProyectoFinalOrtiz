<%-- 
    Document   : tarjetas
    Created on : 22 ene 2026, 19:01:36
    Author     : Vivi Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%@page import="java.sql.*"%>


<%
    //Validar sesión
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    //Acción para favoritos
    String accion = request.getParameter("accion");
    String idTarjetaStr = request.getParameter("id_tarjeta");

    if (accion != null && idTarjetaStr != null) {
        int idTarjeta = Integer.parseInt(idTarjetaStr);

        // Agrega la tarjeta a favoritos
        if ("agregar".equals(accion)) {
            PreparedStatement ps = conexion.prepareStatement(
                "INSERT INTO favoritos (id_usuario, tipo_contenido, id_contenido) VALUES (?, 'tarjeta', ?)"
            );
            ps.setInt(1, idUsuario);
            ps.setInt(2, idTarjeta);
            ps.executeUpdate();
            ps.close();

        // Elimina la tarjeta de favoritos
        } else if ("quitar".equals(accion)) {
            PreparedStatement ps = conexion.prepareStatement(
                "DELETE FROM favoritos WHERE id_usuario = ? AND tipo_contenido = 'tarjeta' AND id_contenido = ?"
            );
            ps.setInt(1, idUsuario);
            ps.setInt(2, idTarjeta);
            ps.executeUpdate();
            ps.close();
        }
    }
%>



<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Tarjetas de Estudio</title>
    
    <link href="css/styles.css" rel="stylesheet">
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


<h2 style="text-align:center; margin-top: 20px; padding-top: 5px;">
    Tarjetas de Estudio – Inteligencia Artificial
</h2>

    <div class="tarjetas-container">

<%
    // Crea la consulta para obtener todas las tarjetas de estudio
    Statement st = conexion.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM tarjetas_estudio");

    // Recorre cada tarjeta obtenida de la base de datos
    while (rs.next()) {
        int idTarjeta = rs.getInt("id_tarjeta");
        boolean esFavorita = false;

        // Consulta para verificar si la tarjeta está en favoritos del usuario
        PreparedStatement psFav = conexion.prepareStatement(
            "SELECT 1 FROM favoritos WHERE id_usuario = ? AND tipo_contenido = 'tarjeta' AND id_contenido = ?"
        );
        psFav.setInt(1, idUsuario);
        psFav.setInt(2, idTarjeta);

        // Ejecuta la consulta y valida si existe el registro
        ResultSet rsFav = psFav.executeQuery();
        if (rsFav.next()) {
            esFavorita = true;
        }
        
        // Cierra recursos
        rsFav.close();
        psFav.close();
%>

<div class="tarjeta">
    <div class="tarjeta-inner">

        <div class="tarjeta-front">
            <h4><%= rs.getString("titulo") %></h4>
            <p><%= rs.getString("frente") %></p>
        </div>

        <div class="tarjeta-back">
            <p><%= rs.getString("reverso") %></p>

            <% if (esFavorita) { %>
                <a href="tarjetas.jsp?accion=quitar&id_tarjeta=<%= idTarjeta %>"
                   class="btn btn-sm btn-outline-danger mt-2">
                    <i class="bi bi-heart-fill"></i> Quitar de favoritas
                </a>
            <% } else { %>
                <a href="tarjetas.jsp?accion=agregar&id_tarjeta=<%= idTarjeta %>"
                   class="btn btn-sm btn-outline-warning mt-2">
                    <i class="bi bi-heart"></i> Marcar como favorita
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

<!-- Footer-->
<footer class="py-5 bg-dark">
    <div class="container">
        <p class="m-0 text-center text-white">
            Copyright &copy; Viviana Ortiz Tellez
        </p>
    </div>
</footer>


</body>
</html>

