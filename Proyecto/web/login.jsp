<%-- 
    Document   : login
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="Controlador.login"%>
<%@page import="modelo.Idioma"%>
<%@page import="modelo.OperacionesCliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ingresar al Sistema</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico "/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    </head>
    <body class="landing">
        <%
            Idioma idioma = null;
            if (session.getAttribute("Idioma") == null || session.getAttribute("Idioma").equals("Español")) {
                session.setAttribute("Idioma", "Español");
                idioma = new Idioma("Español");
            } else {
                idioma = new Idioma("Ingles");
            }

            String nivel = "";
            if (session.getAttribute("nivel") != null) {
                nivel = session.getAttribute("nivel").toString();
            }
            if (nivel.equals("2") || nivel.equals("1")) {
                response.sendRedirect("modificaCliente.jsp");
            }
        %>
        <section id="container" > 
            <div id="page-wrapper">
                <!-- Header -->
                <header id="header" >
                    <nav id="nav">
                        <ul>
                            <li><a href="index.jsp">Inicio</a></li>
                            <li>
                                <a href="#" class="icon fa-angle-down">Menu</a>
                                <ul>
                                    <li><a href="catalogo.jsp">Catálogo Productos</a></li>
                                    <li><a href="contact.jsp">Contacto</a></li>
                                    <li>
                                        <a href="#">Opciones</a>
                                        <ul>
                                            <li><a href="#">Buscar Productos</a></li>
                                            <li><a href="#">Ver Pedido</a></li>  
                                            <li><a href="#">Comentarios</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>     
                    </nav>
                </header>
                <!-- Banner -->
                <section id="banner" class ="box">
                    <img class="image featured" src="images/logo.png" alt="log" />
                    <p>Sirviendole con total amabilidad desde 1985.</p>
                </section>                    
                <!-- Main -->
                <section id="main" class="container">
                    <section class="box special">
                        <header class="major">
                            <h2>INGRESO AL SISTEMA</h2>
                            <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                        </header>                
                    </section>
                    <div class="row">
                        <div class="12u">
                            <!-- Form -->
                            <section class="box">
                                <h1><p>Ingrese sus datos registrados para poder realizar su compra.</p></h1>
                                <form method="post" action="login">
                                    <div class="row uniform 50%">
                                        <div class="6u 12u(mobilep)">
                                            <input type="text" name="user" id="query" value="" placeholder="Ingrese su Usuario" />
                                        </div>
                                        <div class="6u 12u(mobilep)">
                                            <input type="password" name="password" id="query" value="" placeholder="Ingrese su contraseña" />
                                        </div>
                                    </div>
                                    <div class="row uniform">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li> <input type="submit" value="Entrar" class="fit" name = "Enviar"/></li>
                                            </ul>
                                        </div>
                                        <% if (nivel.equals("3")) {
                                                out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Usuario ha sido detectado como Inactivo o Bloqueado, contacte  a itMueblesLosAlpes@gmail.com </p></h5>");
                                            }%>

                                        <% if (nivel.equals("4")) {
                                                out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Login fallido, intente nuevamente</p></h5>");
                                            }%>
                                    </div>
                                </form>
                                <hr />
                            </section>
                        </div>
                    </div>    
                </section>
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
        </section>
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