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
        <title>Muebles Los Alpes</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico"/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
        <!--        <script type ="text/javascript">
                    previene = function () {
                        window.stop;
                        history.go(1);
                    };
                    window.back = previene();
                </script>-->
    </head>
    <body class="landing" oncontextmenu='return false'>
        <%
            String tipo = "";
            if (request.getParameter("tipo") != null)
            {
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
        <section id="container" > 
            <div id="page-wrapper">
                <!-- Header -->
                <header id="header">
                    <h1><a href="#main">Muebleria Los Alpes</a></h1>
                    <nav id="nav">
                        <ul>
                            <li><a href="index.jsp">Inicio</a></li>
                            <li>
                                <a href="#" class="icon fa-angle-down">Menu</a>
                                <ul>
                                    <% if (!(nivel.equals("2") || nivel.equals("1"))) {%>
                                    <li> <a href="nuevoCliente.jsp" class ="actions"> Nuevo Cliente</a> </li>
                                    <%}%>
                                    <li><a href="#main">Catálogo Productos</a></li>
                                    <li><a href="contact.jsp">Contacto</a></li>
                                    <li>
                                        <a href="#">Opciones</a>
                                        <ul>
                                            <li><a href="#">Buscar Productos</a></li>
                                            <li><a href="productosCarrito.jsp#main">Ver Pedido</a></li>  
                                            <li><a href="#">Comentarios</a></li>
                                            <%if (nivel.equals("1")) {%>
                                            <li><a href="#">Reporteria</a></li>
                                            <li><a href="#">Administracion</a></li>
                                            <%}%>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <%if (nivel.equals("2") || nivel.equals("1")) {%>
                            <li>
                                <a  class= "button special" >Usuario:  <%=usuario%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                                <ul>
                                    <li> <a href="modificaCliente.jsp#main" class ="actions">Modificar mis Datos</a> </li>
                                    <li> <a href="logout.jsp" class ="actions">Cerrar Sesión</a> </li>
                                </ul>
                            </li>
                            <%} else {%>
                            <li>
                                <a href="login.jsp#main" class= "button special"> Entrar <img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                                <ul>
                                    <li> <a href="nuevoCliente.jsp#main" class ="actions">Registrate</a> </li>
                                </ul>
                            </li>             
                            <%}%>
                        </ul>     
                    </nav>
                </header>
                <!-- Banner -->
                <section id="banner" class ="box">
                    <img class="image featured" src="images/logo.png" alt="log" />
                    <h2>Sirviendole con total amabilidad desde 1985.</h2>
                </section>
                <!-- Main -->
                <section id="main" class="container">
                    <section class="box special features" id = "catalogo">
                        <header class="major">
                            <h2>CATÁLOGO DE PRODUCTOS</h2>
                            <p>Nuestros productos están divididos en diferentes categorias para su mayor comodidad.</p>
                        </header>
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <span class="image featured"><img src="images/TRADICIONALES/MTradicionales.png" alt = "Muebles Tradicionales"/></span>
                                    <h4><a href="catalogo.jsp?tipo=TRADICIONALES#muebles" class= "button" >Muebles Tradicionales</a></h4>
                                    <p>Este tipo de muebles se caracterizan por contar con una estética conservadora y  detalles muy elegantes, como maderas brillantes y oscuras, diseño simétrico, tapicería delicada y curvas bien detalladas.</p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-area-chart accent3"></span> -->
                                    <span class="image featured"><img src="images/MODERNOS/MModernos.png" alt = "Muebles Modernos"/></span>
                                    <h4><a href="catalogo.jsp?tipo=MODERNOS#muebles" class= "button" >Muebles Modernos</a></h4>
                                    <p>Los muebles de este estilo presentan líneas ligeras y son asociados con el minimalismo posmoderno. Son producidos para ser funcionales y prácticos,ajustandose a las necesidades de la actualidad.</p>
                                </section>
                            </div>
                        </div>
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-cloud accent4"></span>-->
                                    <span class="image featured"><img src="images/COLONIALES/MColoniales.png" alt = "Muebles Coloniales"/></span>
                                    <h4><a href="catalogo.jsp?tipo=COLONIALES#muebles" class= "button" >Muebles Coloniales</a></h4>
                                    <p>Son propios de las fincas y haciendas previas al siglo XX. Para su fabricación se recurre a materiales autóctonos, detalles artesanales, maderas macizas y toques exóticos que aún perduran en el tiempo.</p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--   <span class="icon major fa-lock accent5"></span>-->
                                    <span class="image featured"><img src="images/RUSTICOS/MRusticos.png" alt = "Muebles Rusticos"/></span>
                                    <h4><a href="catalogo.jsp?tipo=RUSTICOS#muebles" class= "button" >Muebles Rústicos</a></h4>
                                    <p>Los muebles que cuentan con este estilo tienen una apariencia folklórica. Transmiten la sensación de ser muebles usados, sencillos o rudimentarios, además de dar una sensación hogareña.</p>
                                </section>
                            </div>
                        </div>
                    </section>
                    <section class="box special features" id = "muebles">
                            <h3>
                                <%
//                                    switch (tipo) {
//                                        case "TRADICIONALES": case "":
//                                            out.write("MUEBLES TRADICIONALES");
//                                            break;
//                                        case "MODERNOS" :
//                                            out.write("MUEBLES MODERNOS");
//                                            break;
//                                        case "COLONIALES":
//                                            out.write("MUEBLES COLONIALES");
//                                            break;
//                                        case "RUSTICOS":
//                                            out.write("MUEBLES RÚSTICOS");
//                                            break;
//                                        default:
//                                            out.write(idioma.getProperty("nombre"));
//                                    }
                                    
                                  %>
                            </h3>
                        <div class="row">
                            <%= cp.getProductos(tipo)%>
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
