<%-- 
    Document   : index
    Created on : 8/09/2016, 11:55:17 PM
    Author     : panle
--%>
<%@page import="ClasesGenericas.Compra"%>
<%@page import="modelo.Idioma"%>
<%@page import="java.util.ArrayList"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(true);
    Idioma idioma = null;

    if (sesion.getAttribute("Idioma") == null || sesion.getAttribute("Idioma").equals("Español")) {
        sesion.setAttribute("Idioma", "Español");
        idioma = new Idioma("Español");
    } else {
        idioma = new Idioma("Ingles");
    }

    String nivel = "", usuario = "";
    if (sesion.getAttribute("user") != null && sesion.getAttribute("nivel") != null) {
        nivel = sesion.getAttribute("nivel").toString();
        usuario = sesion.getAttribute("user").toString();
        System.out.println("///// Usuario: " + usuario);
        System.out.println("///// Nivel: " + nivel);
    }

    // ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
%>
<!DOCTYPE HTML>
<html>
    <head>
        <title><% out.write(idioma.getProperty("mueblierialosalpes"));%></title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico"/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/main.css" />
    </head>
    <body class="landing" oncontextmenu='return false'>
        <section id="container"> 
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
                                    <li><a href="#catalogo"><% out.write(idioma.getProperty("CatálogoProductos"));%></a></li>
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
                    <!--                    <span class="image featured"><img src="images/logo.png" alt="log" /></span>-->
                    <img class="image featured" src="images/logo.png" alt="log" />
                    <p><% out.write(idioma.getProperty("Sirviendolecon"));%></p>
                    <%if (nivel.equals("4") || nivel.equals("3") || nivel.equals("")) {%>
                    <ul class="actions" id = "botonesEntrada">
                        <li><a href="login.jsp#main" class="button special"><% out.write(idioma.getProperty("Entrar"));%></a></li>
                        <li><a href="nuevoCliente.jsp#main" class="button"><% out.write(idioma.getProperty("Registrate"));%></a></li>
                    </ul>
                    <%}%>
                </section>
                <!-- Main -->
                <section id="main" class="container">
                    <section class="box special">
                        <header class="major">
                            <h2><% out.write(idioma.getProperty("paginaOficial"));%><br /></h2>
                            <blockquote><h3><% out.write(idioma.getProperty("Ennuestrocatálogodeproductos"));%></h3></blockquote>
                        </header>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                    </section>
                    <%if (nivel.equals("1")) {%>
                    <div class="12u 20u(narrower)" id ="reporteria">
                        <section class="box special">
                            <span class="icon major fa-area-chart accent3"></span>
                            <!-- <span class="image featured"><img src="images/pic03.jpg" alt="" /></span> -->
                            <h2><% out.write(idioma.getProperty("Reporteria"));%></h2>
                            <h4><% out.write(idioma.getProperty("Reportesde"));%></h4>
                            <div class="actions">
                                <ul class="actions vertical">
                                    <li><a href="reporteria.jsp?Operacion=1#verClientes" class="button"><% out.write(idioma.getProperty("VERCLIENTES"));%></a></li>
                                    <li><a href="reporteria.jsp?Operacion=2#verProductos" class="button special"><% out.write(idioma.getProperty("VERPRODUCTOS"));%></a></li>
                                    <li><a href="reporteria.jsp?Operacion=3#ventasFecha" class="button"><% out.write(idioma.getProperty("VENTASPORFECHA"));%></a></li>
                                    <li><a href="reporteria.jsp?Operacion=4#ventasCiudad" class="button special"><% out.write(idioma.getProperty("VENTASPORCIUDAD"));%></a></li>
                                    <li><a href="reporteria.jsp?Operacion=5#ventasMueble" class="button "><% out.write(idioma.getProperty("VENTASPORMUEBLE"));%></a></li>
                                    <li><a href="reporteria.jsp?Operacion=6#productosCliente" class="button special"><% out.write(idioma.getProperty("PRODUCTOSPORCLIENTE"));%></a></li>
                                    <li><a href="reporteria.jsp?Operacion=7#productoMasVendido" class="button alt"><% out.write(idioma.getProperty("PRODUCTOMASVENDIDOPORCIUDAD"));%></a></li>
                                </ul>
                            </div> 
                        </section>
                    </div>
                    <div class="12u 20u(narrower)" id ="mantenimiento">
                        <section class="box special">
                            <span class="icon major fa-bolt accent2"></span>
                            <!-- <span class="image featured"><img src="images/pic03.jpg" alt="" /></span> -->
                            <h3><% out.write(idioma.getProperty("Mantenimientos"));%></h3>
                            <p><% out.write(idioma.getProperty("ACTUALIZACIÓNDEESTADODECLIENTES"));%></p>
                            <div class="actions" >
                                <ul class="actions vertical">
                                    <li><a href="mantenimientosInterfaz.jsp?Operacion=4#main" class="button"><% out.write(idioma.getProperty("ELIMINARCLIENTES"));%></a></li>
                                    <li><a href="mantenimientosInterfaz.jsp?Operacion=3#main" class="button special"><% out.write(idioma.getProperty("ELIMINARPRODUCTO"));%></a></li>
                                    <li><a href="mantenimientosInterfaz.jsp?Operacion=1#main" class="button "><% out.write(idioma.getProperty("AGREGARPRODUCTO"));%></a></li>
                                    <li><a href="mantenimientosInterfaz.jsp?Operacion=2#main" class="button special"><% out.write(idioma.getProperty("ACTUALIZARPRODUCTO"));%></a></li>
                                </ul>
                            </div> 
                        </section>
                    </div>
                    <%}%>
                    <section class="box special features" id = "catalogo">
                        <h3><% out.write(idioma.getProperty("CATDPRODUC"));%></h3>
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <span class="image featured"><img src="images/TRADICIONALES/MTradicionales.png" alt = "Muebles Tradicionales"/></span>
                                    <h4><a href="catalogo.jsp?tipo=TRADICIONALES#muebles" class= "button" ><% out.write(idioma.getProperty("MueblesTradicionales"));%></a></h4>
                                    <p><% out.write(idioma.getProperty("TradicionalesEsteMueble"));%></p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-area-chart accent3"></span> -->
                                    <span class="image featured"><img src="images/MODERNOS/MModernos.png" alt = "Muebles Modernos"/></span>
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
                                    <h4><a href="catalogo.jsp?tipo=COLONIALES#muebles" class= "button" ><% out.write(idioma.getProperty("MueblesColoniales"));%></a></h4>  
                                    <p><% out.write(idioma.getProperty("ColonialesEsteMueble"));%></p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--   <span class="icon major fa-lock accent5"></span>-->
                                    <span class="image featured"><img src="images/RUSTICOS/MRusticos.png" alt = "Muebles Rusticos"/></span>
                                    <h4><a href="catalogo.jsp?tipo=RUSTICOS#muebles" class= "button" ><% out.write(idioma.getProperty("MueblesRústicos"));%></a></h4>     
                                    <p><% out.write(idioma.getProperty("RusticusEsteMueble"));%></p>
                                </section>
                            </div>
                        </div>
                    </section>
                    <section class="box special features">
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <span class="image featured"><img src="images/ICONOS/formas-de-pago.png" alt = "Formas de Pago"/></span>
                                    <h3><% out.write(idioma.getProperty("FormasdePago"));%></h3>
                                    <p><% out.write(idioma.getProperty("LosAlpescontamoscon"));%></p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <span class="image featured"><img src="images/ICONOS/ENTREGA A DOMICILIO.png" alt="Entregas a Domicilio" /></span>
                                    <h3><% out.write(idioma.getProperty("EntregasDomicilio"));%></h3>
                                    <p><% out.write(idioma.getProperty("Parafacilitarlelaentrega"));%></p>
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
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/jquery.dropotron.min.js"></script>
        <script src="assets/js/jquery.scrollgress.min.js"></script>
        <script src="assets/js/skel.min.js"></script>
        <script src="assets/js/util.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>
