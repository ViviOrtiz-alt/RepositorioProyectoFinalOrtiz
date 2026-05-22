<%-- 
    Document   : faq
    Created on : 22 may 2026, 13:50:08
    Author     : Vivi Ortiz
--%>

<%-- faq.jsp — NUEVO ARCHIVO --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FAQ y Políticas — Aprendizaje Digital</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">Aprendizaje Digital</a>
    </div>
</nav>
<div class="container py-5" style="max-width:800px;">
    <h2 class="fw-bold mb-4">Preguntas Frecuentes</h2>
    <div class="accordion" id="accordionFAQ">
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                        data-bs-target="#faq1">
                    ¿Cómo creo mi cuenta?
                </button>
            </h2>
            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#accordionFAQ">
                <div class="accordion-body">
                    Haz clic en 'Regístrate aquí' en la pantalla de inicio de sesión.
                    Completa los campos de nombre, correo y contraseña, y confirma tu contraseña.
                </div>
            </div>
        </div>
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                        data-bs-target="#faq2">
                    ¿Cuáles son los requisitos de la contraseña?
                </button>
            </h2>
            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#accordionFAQ">
                <div class="accordion-body">
                    La contraseña debe tener mínimo 8 caracteres, al menos una letra mayúscula
                    y al menos un número.
                </div>
            </div>
        </div>
        <div class="accordion-item">
            <h2 class="accordion-header" id="recuperar">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                        data-bs-target="#faq3">
                    ¿Cómo recupero mi contraseña?
                </button>
            </h2>
            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#accordionFAQ">
                <div class="accordion-body">
                    Contacta al administrador de la plataforma con tu correo registrado para
                    solicitar el restablecimiento de tu contraseña.
                </div>
            </div>
        </div>
    </div>

    <h2 class="fw-bold mt-5 mb-4" id="privacidad">Políticas de Privacidad</h2>
    <p>La plataforma recopila únicamente los datos necesarios para la operación del servicio:
       nombre, correo electrónico y contraseña cifrada.</p>
    <p>Los datos no son compartidos con terceros y se almacenan de forma segura
       en la base de datos del sistema.</p>
    <p>El usuario puede solicitar la eliminación de su cuenta y sus datos en cualquier momento
       contactando al administrador.</p>
    <a href="index.jsp" class="btn btn-warning rounded-pill px-4 mt-3 fw-semibold">
        Regresar
    </a>
</div>
<footer class="py-4 bg-dark mt-3">
    <div class="container text-center">
        <p class="m-0 text-white">© Viviana Ortiz Tellez</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
