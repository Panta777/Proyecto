<%-- 
    Document   : ini
    Created on : 16/09/2016, 09:52:42 PM
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

            HttpSession actual = request.getSession(true);
            String id = actual.getId();
            String nombre = (String) actual.getAttribute("user");
            if (actual.isNew()) {
                response.sendRedirect("index.jsp");
                return;
            }

            if (actual == null) {
                response.sendRedirect("index.jsp");
            } else if (actual.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
            }
        %>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
