<%-- 
    Document   : logout
    Created on : 16/09/2016, 10:30:37 PM
    Author     : panle
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            response.setContentType("text/html");
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");

            request.getSession().removeAttribute("logueado");

// session.removeAttribute("logueado");
// session.setMaxInactiveInterval(1);
            session.invalidate();

            response.sendRedirect("index.jsp");
        %>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
