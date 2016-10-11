<%-- 
    Document   : index
    Created on : 8/09/2016, 11:50:17 PM
    Author     : panle
--%>
<%@page import="ClasesGenericas.Compra"%>
<%@page import="modelo.Idioma"%>
<%@page import="java.util.ArrayList"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
-->
<html >
    <head>
        <title>Muebles Los Alpes</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico"/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/main.css" />
    </head>
    <body class="landing">
        <%
            HttpSession sesion = request.getSession(true);
            Idioma idioma = null;

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
                System.out.println("///// Usuario: " + usuario);
                System.out.println("///// Nivel: " + nivel);
            }

            ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");

        %>
        <section id="container" > 
            <div id="page-wrapper">
                <!-- Header -->
                <header id="header" >
                    <h1><a href="#main"><% out.write(idioma.getProperty("mueblierialosalpes"));%></a></h1>
                    <nav id="nav">
                        <ul>
                            <li>
                                <a href="#" class="icon fa-angle-down">Menu</a>
                                <ul>
                                    <li><a href="#catalogo">Catálogo Productos</a></li>
                                    <li><a href="contact.jsp">Contacto</a></li>
                                    <li><a href="productosCarrito.jsp#">Ver Pedido</a></li> 
                                </ul>
                            </li>
                            <%if (nivel.equals("1")) {%>
                            <li>
                                <a href="#" class="icon fa-angle-down">Administracion</a>
                                <ul>
                                    <li><a href="#">Reporteria</a></li>
                                    <li><a href="#">Mantenimientos</a></li>
                                </ul>
                            </li>
                            <%}%>
                            <li><a href="#" class="icon fa-angle-down"><% out.write(idioma.getProperty("cambioIdioma"));%></a>
                                <ul>
                                    <li>
                                        <a href="cambioEspanol.jsp" class ="actions" >
                                            <% out.write(idioma.getProperty("espanol"));%>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="cambioIngles.jsp" class ="actions"> 
                                            <% out.write(idioma.getProperty("ingles"));%>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <%if (nivel.equals("2") || nivel.equals("1")) {%>
                            <li>
                                <a  class= "button special">Usuario:  <%=usuario%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                                <ul>
                                    <li> <a href="modificaCliente.jsp" class ="actions">Modificar mis Datos</a> </li>
                                    <li> <a href="logout.jsp" class ="actions">Cerrar Sesión</a> </li>
                                </ul>
                            </li>
                            <%} else {%>
                            <li>
                                <a href="login.jsp#main" class= "button special"> Entrar <img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                                <ul>
                                    <li> <a href="nuevoCliente.jsp" class ="actions">Registrate</a> </li>
                                </ul>
                            </li>             
                            <%}%>
                        </ul>     
                    </nav>
                </header>
                <!-- Banner -->
                <section id="banner" class ="box">
                    <!--                    <span class="image featured"><img src="images/logo.png" alt="log" /></span>-->
                    <img class="image featured" src="images/logo.png" alt="log" />

                    <h2>Sirviendole con total amabilidad desde 1985.</h2>
                    <%if (nivel.equals("4") || nivel.equals("3") || nivel.equals("")) {%>
                    <ul class="actions" id = "botonesEntrada">
                        <li><a href="login.jsp#main" class="button special">Entrar</a></li>
                        <li><a href="nuevoCliente.jsp" class="button">Registrarse</a></li>
                    </ul>
                    <%}%>
                </section>
                <!-- Main -->
                <section id="main" class="container">
                    <section class="box special">
                        <header class="major">
                            <h2>Pagina Oficial de Muebleria Los Alpes<br /></h2>
                            <blockquote><h3>En nuestro catálogo de productos podrá encontrar una gran variedad de muebles para su hogar</h3></blockquote>
                        </header>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                    </section>
                    <%if (nivel.equals("1")) {%>
                    <div class="12u 20u(narrower)">
                        <section class="box special">
                            <span class="icon major fa-area-chart accent3"></span>
                            <!-- <span class="image featured"><img src="images/pic03.jpg" alt="" /></span> -->
                            <h3>REPORTERIA</h3>
                            <p>VEA LOS REPORTES DE VENTAS, CLIENTES ACTIVOS  Y PRODUCTOS EN EL INVENTARIO</p>
                            <ul class="actions">
                                <li><a href="#" class="button alt">Más Información</a></li>
                            </ul>
                        </section>
                    </div>
                    <div class="12u 20u(narrower)">
                        <section class="box special">
                            <span class="icon major fa-bolt accent2"></span>
                            <!-- <span class="image featured"><img src="images/pic03.jpg" alt="" /></span> -->
                            <h3>ADMINISTRACIÓN</h3>
                            <p>ACTUALIZACIÓN DE ESTADO DE CLIENTES, ESTADO DE PEDIOS, ETC. </p>
                            <ul class="actions">
                                <li><a href="#" class="button alt">Más Información</a></li>
                            </ul>
                        </section>
                    </div>
                    <%}%>
                    <section class="box special features" id = "catalogo">
                        <h3>CATALOGO DE PRODUCTOS</h3>
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <span class="image featured"><img src="images/TRADICIONALES/MTradicionales.png" alt = "Muebles Tradicionales"/></span>
                                    <h4><a href="catalogo.jsp?tipo=1#muebles" class= "button" >Muebles Tradicionales</a></h4>
                                    <p>Este tipo de muebles se caracterizan por contar con una estética conservadora y  detalles muy elegantes, como maderas brillantes y oscuras, diseño simétrico, tapicería delicada y curvas bien detalladas.</p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-area-chart accent3"></span> -->
                                    <span class="image featured"><img src="images/MODERNOS/MModernos.png" alt = "Muebles Modernos"/></span>
                                    <h4><a href="catalogo.jsp?tipo=2#muebles" class= "button" >Muebles Modernos</a></h4>
                                    <p>Los muebles de este estilo presentan líneas ligeras y son asociados con el minimalismo posmoderno. Son producidos para ser funcionales y prácticos,ajustandose a las necesidades de la actualidad.</p>
                                </section>
                            </div>
                        </div>
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-cloud accent4"></span>-->
                                    <span class="image featured"><img src="images/COLONIALES/MColoniales.png" alt = "Muebles Coloniales"/></span>
                                    <h4><a href="catalogo.jsp?tipo=3#muebles" class= "button" >Muebles Coloniales</a></h4>
                                    <p>Son propios de las fincas y haciendas previas al siglo XX. Para su fabricación se recurre a materiales autóctonos, detalles artesanales, maderas macizas y toques exóticos que aún perduran en el tiempo.</p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--   <span class="icon major fa-lock accent5"></span>-->
                                    <span class="image featured"><img src="images/RUSTICOS/MRusticos.png" alt = "Muebles Rusticos"/></span>
                                    <h4><a href="catalogo.jsp?tipo=4#muebles" class= "button" >Muebles Rústicos</a></h4>
                                    <p>Los muebles que cuentan con este estilo tienen una apariencia folklórica. Transmiten la sensación de ser muebles usados, sencillos o rudimentarios, además de dar una sensación hogareña.</p>
                                </section>
                            </div>
                        </div>
                    </section>
                    <section class="box special features">
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <span class="image featured"><img src="images/ICONOS/formas-de-pago.png" alt = "Formas de Pago"/></span>
                                    <h3>Formas de Pago</h3>
                                    <p>En Muebleria Los Alpes, contamos con varias facilidades de Pago, como lo son  Tarjetas de Crédito, Débito y Depósitos a nuestra cuenta. </p>
                                    <ul class="actions">
                                        <li><a href="#" class="button alt">Más Información</a></li>
                                    </ul>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <span class="image featured"><img src="images/ICONOS/ENTREGA A DOMICILIO.png" alt="Entregas a Domicilio" /></span>
                                    <h3>Entregas a Domicilio</h3>
                                    <p>Para facilitarle la entrega de su pedido, contamos también con el servicio de entrega a cualquier parte de Centroamerica.</p>
                                    <ul class="actions">
                                        <li><a href="#" class="button alt">Más Información</a></li>
                                    </ul>
                                </section>
                            </div>
                        </div>
                    </section>
                    <!-- CTA 
                            <section id="cta">
        
                                    <h2>Sign up for beta access</h2>
                                    <p>Blandit varius ut praesent nascetur eu penatibus nisi risus faucibus nunc.</p>
        
                                    <form>
                                            <div class="row uniform 50%">
                                                    <div class="8u 12u(mobilep)">
                                                            <input type="email" name="email" id="email" placeholder="Email Address" />
                                                    </div>
                                                    <div class="4u 12u(mobilep)">
                                                            <input type="submit" value="Sign Up" class="fit" />
                                                    </div>
                                            </div>
                                    </form>
        
                            </section>
        
                    <!-- Footer -->
                </section>
                <footer id="footer">
                    <ul class="icons">
                        <li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
                        <li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
                        <li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
                        <li><a href="#" class="icon fa-google-plus"><span class="label">Google+</span></a></li>
                    </ul>
                    <ul class="copyright">
                        <li>&copy; Todos los Derechos Reservados</li><li>Diseñado por: <a href="https://www.facebook.com/panta.medrano">Panta Medrano</a></li>
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
