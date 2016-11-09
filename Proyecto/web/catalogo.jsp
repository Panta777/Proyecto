<%-- 
    Document   : index
    Created on : 8/09/2016, 11:50:17 PM
    Author     : panle
--%>
<%@page import="Controlador.controladorProducto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ClasesGenericas.Compra"%>
<%@page import="modelo.Idioma"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
-->
<html >
    <head>
        <%
            String tipo = "";
            if (request.getParameter("tipo") != null) {
                tipo = request.getParameter("tipo").toString();
            }

            Idioma idioma = null;
            HttpSession sesion = request.getSession(true);
            if (sesion.getAttribute("Idioma") == null || sesion.getAttribute("Idioma").equals("Español")) {
                sesion.setAttribute("Idioma", "Español");
                idioma = new Idioma("Español");
            } else {
                idioma = new Idioma("Ingles");
            }

            String nivel = "", usuario = "", rol = null, foto = null;
            if (sesion.getAttribute("user") != null && sesion.getAttribute("nivel") != null) {
                nivel = sesion.getAttribute("nivel").toString();
                usuario = sesion.getAttribute("user").toString();
            }
            controladorProducto cp = new controladorProducto();
            // ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
        %>
        <title><% out.write(idioma.getProperty("mueblierialosalpes"));%></title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico"/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/main.css" />
    </head>
    <body class="landing">
        <section id="container" > 
            <div id="page-wrapper">
                <!-- Header -->
                <header id="header" >
                    <h1><a href="#main"><% out.write(idioma.getProperty("mueblierialosalpes"));%></a></h1>
                    <nav id="nav">
                        <ul>
                            <li>
                                <a href="index.jsp#main"><% out.write(idioma.getProperty("inicio"));%></a>
                            </li>
                            <li>
                                <a href="#" class="icon fa-angle-down">Menu</a>
                                <ul>
                                    <li><a href="index.jsp#catalogo"><% out.write(idioma.getProperty("CatálogoProductos"));%></a></li>
                                    <li><a href="contact.jsp#main"><% out.write(idioma.getProperty("Contacto"));%></a></li>
                                    <li><a href="productosCarrito.jsp#OrdenCompra"><% out.write(idioma.getProperty("VerPedido"));%></a></li> 
                                </ul>
                            </li>
                            <%if (nivel.equals("1")) {%>
                            <li>
                                <a href="#" class="icon fa-angle-down"><% out.write(idioma.getProperty("Administracion"));%></a>
                                <ul>
                                    <li><a href="index.jsp#reporteria"><% out.write(idioma.getProperty("Reporteria"));%></a></li>
                                    <li><a href="index.jsp#mantenimiento"><% out.write(idioma.getProperty("Mantenimientos"));%></a></li>
                                </ul>
                            </li>
                            <%}%>
                            <li>
                                <a href="#" class="icon fa-angle-down"><% out.write(idioma.getProperty("cambioIdioma"));%></a>
                                <ul>
                                    <li>
                                        <a href="cambioEspanol.jsp" class ="actions" >
                                            <img class = "image featured" src="images/ICONOS/ESPANOL.png" width="25" height="25" alt ="<% out.write(idioma.getProperty("espanol"));%>">
                                            <% out.write(idioma.getProperty("espanol"));%>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="cambioIngles.jsp" class ="actions"> 
                                            <img  class = "image featured" src="images/ICONOS/INGLES.png" width="25" height="25" alt ="<% out.write(idioma.getProperty("ingles"));%>">
                                            <% out.write(idioma.getProperty("ingles"));%>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <%if (nivel.equals("2") || nivel.equals("1")) {%>
                            <li>
                                <a  class= "button special" ><% out.write(idioma.getProperty("usuario"));%><%=usuario%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                                <ul> 
                                    <li> <a href="modificaCliente.jsp#main" class ="actions"><% out.write(idioma.getProperty("ModificarmisDatos"));%></a> </li>
                                    <li> <a href="logout.jsp" class ="actions"><% out.write(idioma.getProperty("CerrarSesión"));%></a> </li>
                                </ul>
                            </li>
                            <%} else {%>
                            <li>
                                <a href="#" class= "icon fa-angle-down"><% out.write(idioma.getProperty("IngresaroRegistrarse"));%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                                <ul>
                                    <li>
                                        <a href="login.jsp#main" class= "actions"> <% out.write(idioma.getProperty("Entrar"));%></a>

                                    </li>
                                    <li> <a href="nuevoCliente.jsp#main" class ="actions"><% out.write(idioma.getProperty("Registrate"));%></a> </li>
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
                    <section class="box special features" id = "catalogo">
                        <header class="major">
                            <!--<h2>CATÁLOGO DE PRODUCTOS</h2>-->
                            <h2> <% out.write(idioma.getProperty("CatálogoProductos"));%></h2>
                            <p><% out.write(idioma.getProperty("NuestrosProductosestan"));%></p>
                        </header>
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <span class="image featured"><img src="images/TRADICIONALES/MTradicionales.png" alt = "Muebles Tradicionales"/></span>
                                    <!-- <h4><a href="catalogo.jsp?tipo=TRADICIONALES#muebles" class= "button" >Muebles Tradicionales</a></h4>-->
                                    <h4><a href="catalogo.jsp?tipo=TRADICIONALES#muebles" class= "button" ><% out.write(idioma.getProperty("MueblesTradicionales"));%></a></h4>
                                    <p><% out.write(idioma.getProperty("TradicionalesEsteMueble"));%></p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-area-chart accent3"></span> -->
                                    <span class="image featured"><img src="images/MODERNOS/MModernos.png" alt = "Muebles Modernos"/></span>
                                    <!--    <h4><a href="catalogo.jsp?tipo=MODERNOS#muebles" class= "button" >Muebles Modernos</a></h4>-->
                                    <h4><a href="catalogo.jsp?tipo=MODERNOS#muebles" class= "button" ><% out.write(idioma.getProperty("MueblesModernos"));%></a></h4>
                                    <p><% out.write(idioma.getProperty("ModernosesEsteMueble"));%></p>
                                </section>
                            </div>
                        </div>
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-cloud accent4"></span>-->
                                    <span class="image featured"><img src="images/COLONIALES/MColoniales.png" alt = "Muebles Coloniales"/></span>
                                    <!--   <h4><a href="catalogo.jsp?tipo=COLONIALES#muebles" class= "button" >Muebles Coloniales</a></h4>-->
                                    <h4><a href="catalogo.jsp?tipo=COLONIALES#muebles" class= "button" ><% out.write(idioma.getProperty("MueblesColoniales"));%></a></h4>  
                                    <p><% out.write(idioma.getProperty("ColonialesEsteMueble"));%></p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--   <span class="icon major fa-lock accent5"></span>-->
                                    <span class="image featured"><img src="images/RUSTICOS/MRusticos.png" alt = "Muebles Rusticos"/></span>
                                    <!--  <h4><a href="catalogo.jsp?tipo=RUSTICOS#muebles" class= "button" >Muebles Rústicos</a></h4>-->
                                    <h4><a href="catalogo.jsp?tipo=RUSTICOS#muebles" class= "button" ><% out.write(idioma.getProperty("MueblesRústicos"));%></a></h4>     
                                    <p><% out.write(idioma.getProperty("RusticusEsteMueble"));%></p>
                                </section>
                            </div>
                        </div>
                    </section>
                    <section class="box special features" id = "muebles">
                        <h3>
                            <%
                                if (tipo.toUpperCase().equals("TRADICIONALES")) {
                                    out.write(idioma.getProperty("MueblesTradicionales"));
                                } else if (tipo.toUpperCase().equals("MODERNOS")) {
                                    out.write(idioma.getProperty("MueblesModernos"));
                                } else if (tipo.toUpperCase().equals("COLONIALES")) {
                                    out.write(idioma.getProperty("MueblesColoniales"));
                                } else if (tipo.toUpperCase().equals("RUSTICOS")) {
                                    out.write(idioma.getProperty("MueblesRústicos"));
                                } else {
                                   out.write(idioma.getProperty("MueblesTradicionales"));
                                }

                            %>
                        </h3>
                        <div class="row">
                            <% if (cp.getProductos(tipo, session.getAttribute("Idioma").toString()).equals("")) {%>
                            <h3> <% out.write(idioma.getProperty("NOHAYMUEBLESENESTACATEGORIA"));%> </h3> 
                            <span class="image featured"><img src="images/404.png" alt="Sin Muebles" /></span>
                                <%} else {
                                        out.write(cp.getProductos(tipo, session.getAttribute("Idioma").toString()));
                                    }%>
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
        <!--        </section>-->
    </body>
</html>
