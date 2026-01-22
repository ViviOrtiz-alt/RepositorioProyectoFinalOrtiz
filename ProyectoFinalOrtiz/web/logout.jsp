<%-- 
    Document   : logout
    Created on : 22 ene 2026, 12:00:28
    Author     : Vivi Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();   // Cierra la sesión
    response.sendRedirect("index.jsp"); // Regresa al login
%>

