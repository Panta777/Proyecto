<%-- 
    Document   : login
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="Controlador.login"%>
<%@page import="modelo.Idioma"%>
<%@page import="modelo.OperacionesCliente"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Idioma idioma = null;
    HttpSession sesion = request.getSession(true);
    if (sesion.getAttribute("Idioma") == null || sesion.getAttribute("Idioma").equals("Español")) {
        sesion.setAttribute("Idioma", "Español");
        idioma = new Idioma("Español");
    } else {
        idioma = new Idioma("Ingles");
    }

    String nivel = "";
    if (sesion.getAttribute("nivel") != null) {
        nivel = sesion.getAttribute("nivel").toString();
    }

    if (nivel.equals("2") || nivel.equals("1")) {
        response.sendRedirect("modificaCliente.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title><% out.write(idioma.getProperty("INGRESOALSISTEMA"));%></title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico"/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <meta http-equiv="cache-control" content="max-age=0" />
        <meta http-equiv="cache-control" content="no-cache" />
        <meta http-equiv="expires" content="0" />
        <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
        <meta http-equiv="pragma" content="no-cache" />
        <script type ="text/javascript">
            previene = function () {
                window.stop;
                history.go(1);
            };
            window.back = previene();
        </script>
    </head>
    <body class="landing" oncontextmenu='return false'>

        <section id="container" > 
            <div id="page-wrapper">
                <!-- Header -->
                <header id="header" >
                    <h1><a href="#main"><% out.write(idioma.getProperty("mueblierialosalpes"));%></a></h1>
                    <nav id="nav">
                        <ul>    
                            <li><a href="index.jsp"><% out.write(idioma.getProperty("inicio"));%></a></li>
                            <li>
                                <a href="#" class="icon fa-angle-down">Menu</a>
                                <ul>
                                    <li><a href="catalogo.jsp#main"><% out.write(idioma.getProperty("CatálogoProductos"));%></a></li>
                                    <li><a href="contact.jsp#main"><% out.write(idioma.getProperty("Contacto"));%></a></li>
                                    <li>
                                        <a  href="#"><% out.write(idioma.getProperty("Opciones"));%></a>
                                        <ul>                                            
                                            <li><a  href="catalogo.jsp"><% out.write(idioma.getProperty("BuscarProductos"));%></a></li>

                                            <li><a  href="#"><% out.write(idioma.getProperty("VerPedido"));%></a></li>

                                            <li><a  href="#"><% out.write(idioma.getProperty("Comentarios"));%></a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <% if (nivel.equals("3") || nivel.equals("4") || nivel.equals("")) {%>
                            <li>
                                <a href="login.jsp" class= "button special"><% out.write(idioma.getProperty("Entrar"));%> <img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                                <ul>
                                    <li> <a href="nuevoCliente.jsp" class ="actions"><% out.write(idioma.getProperty("Registrate"));%></a> </li>

                                </ul>
                            </li>             
                            <%}%>
                        </ul>     
                    </nav>
                </header>
                <!-- Banner -->
                <section id="banner" class ="box">
                    <img class="image featured" src="images/logo.png" alt="log" />
                    <p><% out.write(idioma.getProperty("Sirviendolecon"));%></p>
                </section>                    
                <!-- Main -->
                <section id="main" class="container">
                    <section class="box special">
                        <header class="major">
                            <h2><% out.write(idioma.getProperty("INGRESOALSISTEMA"));%></h2>
                        </header>   
                        <div class="row">
                            <div class="12u">
                                <!-- Form -->
                                <section class="box">
                                    <h2><p><% out.write(idioma.getProperty("Ingresesusdatos"));%></p></h2>
                                    <form method="post" action="login"  >
                                        <div class="row uniform">
                                            <div class="12u">
                                                <input type="text" name="user" value="" id="myname" autocomplete='off' placeholder=<% out.write(idioma.getProperty("Usuario"));%>  />
                                            </div>
                                            <div class="12u">
                                                <input type="password" name="password" value="" placeholder=<% out.write(idioma.getProperty("Contraseña"));%>  />
                                            </div>
                                        </div>
                                        <div class="row uniform">
                                            <div class="12u">
                                                <ul class="actions">
                                                    <li> <input type="submit" value="<% out.write(idioma.getProperty("Enviar"));%>" class="fit" name = "Enviar"/></li>
                                                </ul>
                                            </div>
                                            <%
                                                if (nivel.equals("3") || nivel.equals("4")) {
                                                    if (nivel.equals("3")) {
                                                        out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Usuario ha sido detectado como Inactivo, contacte  a itMueblesLosAlpes@gmail.com </p></h5>");
                                                    }
                                                    if (nivel.equals("4")) {
                                                        out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Login fallido, intente nuevamente</p></h5>");
                                                    }

//                                                    request.getSession().removeAttribute("user");
//                                                    request.getSession().removeAttribute("nivel");
                                                    // sesion.invalidate();
                                                }
                                            %>
                                        </div>
                                    </form>
                                    <hr />
                                </section>
                            </div>
                        </div>  
                    </section>  
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
                        <li>&copy; <% out.write(idioma.getProperty("TodoslosDerechosReservados"));%></li><li><% out.write(idioma.getProperty("Diseñadopor"));%> <a href="https://www.facebook.com/panta.medrano">Panta Medrano</a></li>
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