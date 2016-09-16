<%-- 
    Document   : login
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>
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
        <script>
            function abrirVentana(url) {
    window.open(url, "nuevo", "directories=no, location=no, menubar=no, scrollbars=yes, statusbar=no, tittlebar=no, width=400, height=400");
}
        </script>
    </head>
    <body>
        <div id="page-wrapper">
            <!-- Header -->
            <header id="header">
                <h1><a href="index.jsp">Inicio</a></h1>
                <nav id="nav">
                    <ul>
                        <li><a href="index.jsp">Inicio</a></li>
                        <li>
                            <a href="#" class="icon fa-angle-down">Layouts</a>
                            <ul>
                                <li><a href="generic.jsp">Generic</a></li>
                                <li><a href="contact.jsp">Contact</a></li>
                                <li><a href="elements.jsp">Elements</a></li>
                                <li>
                                    <a href="#">Submenu</a>
                                    <ul>
                                        <li><a href="#">Option One</a></li>
                                        <li><a href="#">Option Two</a></li>
                                        <li><a href="#">Option Three</a></li>
                                        <li><a href="#">Option Four</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#" class="button">Sign Up</a></li>
                    </ul>
                </nav>
            </header>
            <!-- Main -->
            <section id="main" class="container">
                <header>
                    <h2>Ingreso al Sistema</h2>
                    <a href="#" onClick="abrirVentana('http://www.w3api.com')">W3Api</a><br />
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