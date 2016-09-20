<%-- 
    Document   : cambioIdioma
    Created on : 19/09/2016, 12:57:27 PM
    Author     : DesarrolloPantaleon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
                
        <%
            session.setAttribute("Idioma", "Ingles");
            response.sendRedirect("index.jsp");
        %>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
