<%-- 
    Document   : getAttribute
    Created on : 12/09/2016, 08:24:33 PM
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
       <h3>value = <%=session.getAttribute("value")%></h3>
    </body>
</html>
