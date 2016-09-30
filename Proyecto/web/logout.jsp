<%-- 
    Document   : logout
    Created on : 16/09/2016, 10:30:37 PM
    Author     : panle
--%>

<%@page import="java.awt.SystemColor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Refresh" content="10; url=index.jsp">
        <title>JSP Page</title>
        <%
        HttpSession sesion = request.getSession(true);
            response.setContentType("text/html");
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");

            request.getSession().removeAttribute("user");
            request.getSession().removeAttribute("nivel");

// session.removeAttribute("logueado");
// session.setMaxInactiveInterval(1);
            sesion.invalidate();
            response.sendRedirect("index.jsp");
        %>
    </head>
    <body>
    </body>
</html>
