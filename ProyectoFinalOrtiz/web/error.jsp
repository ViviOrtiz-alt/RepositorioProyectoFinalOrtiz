<%-- 
    Document   : error
    Created on : 22 may 2026, 13:49:16
    Author     : Vivi Ortiz
--%>

<%-- error.jsp — NUEVO ARCHIVO --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Error — Aprendizaje Digital</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home.jsp">Aprendizaje Digital</a>
    </div>
</nav>
<div class="container text-center" style="margin-top:100px;">
    <div class="display-1 text-danger">⚠️</div>
    <h2 class="mt-4">Ocurrió un error inesperado</h2>
    <p class="text-muted mt-3">
        Lo sentimos, algo no salió bien. Por favor regresa al inicio e intenta de nuevo.
    </p>
    <a href="home.jsp" class="btn btn-warning rounded-pill px-4 mt-3 fw-semibold">
        Regresar al inicio
    </a>
</div>
<footer class="py-4 bg-dark mt-5">
    <div class="container text-center">
        <p class="m-0 text-white">© Viviana Ortiz Tellez</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

