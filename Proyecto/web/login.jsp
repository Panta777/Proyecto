<%-- 
    Document   : login
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="modelo.Idioma"%>
<%@page import="modelo.Operaciones"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ingresar al Sistema</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    </head>
    <body>
        <%
        Idioma idioma = null;

            if (session.getAttribute("Idioma") == null || session.getAttribute("Idioma").equals("Español")) {
                session.setAttribute("Idioma", "Español");
                idioma = new Idioma("Español");
            } else {
                idioma = new Idioma("Ingles");
            }
        
            String nivel = "", usuario = "";
            if (session.getAttribute("nivel") != null) 
            {
                response.sendRedirect("modificaCliente.jsp");
            }
        %>
        <div id="page-wrapper">
            <!-- Header -->
                <header id="header" >
                    <nav id="nav">
                        <ul>
                            <li><a href="index.jsp">Inicio</a></li>
                            <li>
                                <a href="#" class="icon fa-angle-down">Menu</a>
                                <ul>
                                    <% if (session.getAttribute("user") == null) {%>
                                    <li><a href="nuevoCliente.jsp">Registro Nuevo Cliente</a></li>
                                    <%} else {%>
                                    <li> <a href="modificaCliente.jsp" class ="actions">Modificar mis Datos</a> </li>
                                    <%}%> 
                                    <li><a href="catalogo.jsp">Catálogo Productos</a></li>
                                    <li><a href="contact.jsp">Contacto</a></li>
                                    <li>
                                        <a href="#">Opciones</a>
                                        <ul>
                                            <li><a href="#">Buscar Productos</a></li>
                                            <li><a href="#">Ver Pedido</a></li>  
                                            <li><a href="#">Comentarios</a></li>
                                            <%if (nivel.equals("1")) {%>
                                            <li><a href="#">Reporteria</a></li>
                                            <li><a href="#">Administracion</a></li>
                                            <%}%>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <%if (usuario != "") {%>
                            <li>
                                <a  class= "button">Usuario:  <%=session.getAttribute("user").toString()%><img src="images/vercarrito.gif" width="25" height="21" border="0"> </a>
                                <ul>
                                    <% if (session.getAttribute("user") != null) {%>
                                    <li> <a href="logout.jsp" class ="actions">Salir</a> </li>
                                </ul>
                                <%}%>
                            </li>
                            <%}%>
                        </ul>     
                    </nav>
                </header>
            <!-- Main -->
            <section id="main" class="container">
                <header>
                    <h2>Ingreso al Sistema</h2>
                </header>
            </section>
            <div class="row">
                <div class="12u">
                    <!-- Form -->
                    <section class="box">
                        <h3><p>Ingrese sus Datos</p></h3>
                        <hr />
                        <form method="post" action="login.jsp">
                            <div class="row uniform 50%">
                                <div class="6u 12u(mobilep)">
                                    <input type="text" name="user" id="query" value="" placeholder="Ingrese su Usuario" />
                                </div>
                                <div class="6u 12u(mobilep)">
                                    <input type="password" name="password" id="query" value="" placeholder="Ingrese su contraseña" />
                                </div>
                                <div class="row uniform 50%">
                                    <div class="12u">
                                        <ul class="actions">
                                            <li> <input type="submit" value="Entrar" class="fit" name = "Enviar"/></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <%
                            Operaciones op = new Operaciones();
                            if (request.getParameter("Enviar") != null && request.getParameter("user") != null && request.getParameter("password") != null) {
                                String usu = request.getParameter("user");
                                String contra = request.getParameter("password");
                                HttpSession sesion = request.getSession();
                                switch (op.loguear(usu, contra)) {
                                    case 1:
                                        sesion.setAttribute("user", usu);
                                        sesion.setAttribute("nivel", "1");
                                        response.sendRedirect("index.jsp");
                                        break;
                                    case 2:
                                        sesion.setAttribute("user", usu);
                                        sesion.setAttribute("nivel", "2");
                                        response.sendRedirect("index.jsp");
                                        break;
                                    case 3:
                                        out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Usuario ha sido detectado como Inactivo o Bloqueado, contacte  a itMueblesLosAlpes@gmail.com </p></h5>");
                                        break;
                                    default:
                                        out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Login fallido, intente nuevamente</p></h5>");
                                        break;
                                }
                            }
                        %>
                    </section>
                </div>
            </div>
            <!-- Footer -->
            <footer id="footer">
                <ul class="icons">
                    <li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
                    <li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
                    <li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
                    <li><a href="#" class="icon fa-google-plus"><span class="label">Google+</span></a></li>
                </ul>
                <ul class="copyright">
                    <li>&copy; Todos los Derechos Reservados</li><li>Diseñado por: <a href="https://www.facebook.com/panta.medrano">Pantaleón Medrano</a></li>
                </ul>
            </footer>
        </div>
        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/jquery.dropotron.min.js"></script>
        <script src="assets/js/jquery.scrollgress.min.js"></script>
        <script src="assets/js/skel.min.js"></script>
        <script src="assets/js/util.js"></script>
        <!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
        <script src="assets/js/main.js"></script>
    </body>
</html>