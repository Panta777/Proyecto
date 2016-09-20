<%-- 
    Document   : i18
    Created on : 19/09/2016, 07:00:09 PM
    Author     : panle
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%-- language maneja el idioma actual --%>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="com.me.jsp.bundle" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Curso</title>
    </head>
    <body>
        <form action="index.jsp" method="POST">
            <input type="submit" value="Volver a Menu" />
        </form><br />
        <h3>Internacionalización</h3>

        <fmt:message key="msg.greeting" /><br />
        <fmt:message key="msg.bye" /><br />
        <fmt:message key="label.require_field" />
        <br /><br />

        <form>
            <fmt:message key="label.select_language" />: 
            <select id="language" name="language" onchange="submit();">
                <option value="es_ES" 
                        <c:if test="${language=='es_ES'}">selected</c:if>>
                    <fmt:message key="label.spanish" />
                </option>
                <option value="en_US" 
                        <c:if test="${language=='en_US'}">selected</c:if>>
                    <fmt:message key="label.english" />
                </option>
            </select>
        </form>
        <br />

        <h3>formatNumber</h3>
        <c:set var="numero" value="125678.4309" />
        formatNumber (1)=> <fmt:message key="label.currency" />: 
        <%-- type= number, currency, percent --%>
        <fmt:formatNumber value="${numero}" type="currency"/><br />

    </body>
</html>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />