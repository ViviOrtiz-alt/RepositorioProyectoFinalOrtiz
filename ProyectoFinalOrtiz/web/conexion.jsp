<%-- 
    Document   : conexion
    Created on : 20 ene 2026, 17:12:11
    Author     : Vivi Ortiz
--%>

<%@page import="java.sql.*" %>

<%
    Connection conexion = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/bd_plataforma_ia",
            "uortizis",
            "udl123"
        );
    } catch (Exception e) {
        out.print("Error de conexi?n: " + e.getMessage());
    }
%>
