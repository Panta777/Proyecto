<%-- 
    Document   : setAttribute
    Created on : 12/09/2016, 08:24:24 PM
    Author     : panle
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
session.setAttribute("value", request.getParameter("value"));
%>

<h3>session.setAttribute("value",<%=session.getAttribute("value")%>)</h3>
    </body>
</html>
