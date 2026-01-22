<%-- 
    Document   : index
    Created on : 19 ene 2026, 10:31:06
    Author     : Vivi Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%@page import="java.sql.*"%>

<%
    String correo = request.getParameter("correo");
    String password = request.getParameter("password");
%>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inicio de sesión</title>

    <!-- Bootstrap CSS -->
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>

   
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">Viviana Ortiz</a>
    </div>
</nav>


<!-- SECCIÓN DE FONDO -->
<section class="login-background" style="background-image:url('img/Fondo3.jpg')">
    
     <!-- LOGIN A LA DERECHA -->
    <div class="ms-auto" style="max-width: 500px; width: 100%;">
        <div class="card shadow p-4 card-login">

            <h3 class="text-center mb-3 fw-semibold">Bienvenido</h3>
            <p class="text-center text-muted mb-4">Inicia sesión para continuar</p>

            <form action="index.jsp" method="post">
                
                <!-- CORREO -->
                <div class="mb-3">
                    <label class="form-label text-muted">Correo electrónico</label>
                    <input type="email" class="form-control rounded-pill px-3"
                           name="correo" placeholder="correo@ejemplo.com" required>
                </div>

                <!-- CONTRASEÑA -->
                <div class="mb-3">
                    <label class="form-label text-muted">Contraseña</label>
                     <input type="password" class="form-control rounded-pill px-3"
                           name="password" placeholder="Ingrese su contraseña" required>
                </div>

                <!-- BOTÓN -->
                <div class="d-grid mt-4">
                    <button type="button" class="btn btn-warning rounded-pill fw-semibold">
                        Iniciar sesión
                    </button>
                </div>

            </form>

            <!-- ENLACES -->
            <div class="text-center mt-4">
                <p class="mb-1 text-muted">
                    ¿No tienes cuenta?
                    <a href="registroUsuario.jsp"
                       class="fw-semibold text-decoration-none text-black-50">
                        Regístrate aquí
                    </a>
                </p>
            </div>

        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

