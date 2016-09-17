<%-- 
    Document   : index
    Created on : 8/09/2016, 11:50:17 PM
    Author     : panle
--%>
<%@page import="modelo.Idioma"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
-->
<html >
    <head>
        <title>Muebles de los Alpes</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    </head>
    <body class="landing">


        <%
//           if(request.getAttribute("Idioma").equals("Español") || request.getAttribute("Idioma") == null)
//           {
//               request.setAttribute("Idioma", "Español");
//           }
//           else 
//           {
//                request.setAttribute("Idioma", "Ingles");
//           }
            Idioma idioma = new Idioma("Ingles");
            String nivel = "", usuario = "", rol = null, foto = null;
            System.out.println("///// Usuario: " + usuario);
            if (session.getAttribute("nivel") != null) {
                nivel = session.getAttribute("nivel").toString();
                usuario = session.getAttribute("user").toString();
                System.out.println("///// Usuario:2 " + usuario);
                //  if (session.getAttribute("nivel").equals("1")) {
                //response.sendRedirect("index.jsp");
                //      out.write("Admin");
                //  } else if (session.getAttribute("nivel").equals("2")) {
                //   out.write("Cliente");
                //  } //else {
                // response.sendRedirect("index.jsp");
                //   out.write("Ingrese al sistema para realizar su pedido");
                // }
            }
            //      else
            //      {
            // response.sendRedirect("index.jsp");
            //       out.write("Ingrese al sistema para realizar su pedido");
            //      }

        %>
        <section id="container" > 
            <div id="page-wrapper">
                <!-- Header -->
                <header id="header" class="alt">
                    <%if (usuario != "") {%>
                    <h5 class="button">Usuario En el Sistema: <%=session.getAttribute("user").toString()%> </h5>
                    <%}%>
                    <nav id="nav">
                        <ul>
                            <li><a href="index.jsp">Inicio</a></li>
                            <li>
                                <a href="#" class="icon fa-angle-down">Menu</a>
                                <ul>
                                    <li><a href="generic.jsp">Catálogo</a></li>
                                    <li><a href="contact.jsp">Contacto</a></li>
                                    <li><a href="elements.jsp">Elementos</a></li>
                                    <li><a href="nuevoCliente.jsp">Registro</a></li>
                                    <li>
                                        <a href="#">Opciones</a>
                                        <ul>
                                            <li><a href="#">Productos</a></li>
                                            <li><a href="#">Hacer Pedido</a></li>
                                            <li><a href="#">Reporteria</a></li>
                                            <li><a href="#">Comentarios</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li><a href="#" class="button"><% out.write(idioma.getProperty("cambioIdioma"));%></a>
                                <ul>
                                    <li><a href="#"><% out.write(idioma.getProperty("espanol")); %></a></li>
                                    <li><a href="#"><% out.write(idioma.getProperty("ingles"));%></a></li>
                                </ul>
                            </li>
                            <% if (session.getAttribute("user") == null) {%>
                            <li><a href="login.jsp" class="button">Entrar</a></li>
                                <%} else {%>
                            <li> <a href="#" class ="button"><%session.invalidate();%>Salir</a> </li>
                                <%}%>
                        </ul>
                    </nav>
                </header>
                <!-- Banner -->
                <section id="banner">
                    <h2>Muebles De Los Alpes</h2>
                    <p>Sirviendole con total amabilidad desde 2016.</p>
                    <%if (usuario.equals("")) {%>
                    <ul class="actions" id = "botonesEntrada">
                        <li><a href="login.jsp" class="button special">Entrar</a></li>
                        <li><a href="nuevoCliente.jsp" class="button">Registrarse</a></li>
                    </ul>
                    <%}%>
                </section>
                <!-- Main -->
                <section id="main" class="container">

                    <section class="box special">
                        <header class="major">
                            <h2>Pagina Oficial de Muebleria Los Alpes
                                <br />
                            </h2>
                            <p>En nuestro catálogo de productos podrá encontrar una gran variedad de muebles para su hogar</p>
                        </header>
                        <span class="image featured"><img src="images/ImagenPrueba.jpg" alt="" /></span>
                    </section>

                    <section class="box special features">
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-bolt accent2"></span>-->
                                    <span class="image featured"><img src="images/pic02.jpg" alt="" /></span>
                                    <h3>Muebles Tradicionales</h3>
                                    <p>Este tipo de muebles se caracterizan por contar con una estética conservadora y  detalles muy elegantes, como maderas brillantes y oscuras, un diseño simétrico, tapicería delicada y curvas bien detalladas, entre otros.</p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-area-chart accent3"></span> -->
                                    <span class="image featured"><img src="images/pic02.jpg" alt="" /></span>
                                    <h3>Muebles Modernos </h3>
                                    <p>Los muebles de este estilo presentan líneas ligeras y son asociados con el minimalismo posmoderno. Son producidos para ser funcionales y prácticos,ajustandose a las necesidades de la actualidad.</p>
                                </section>
                            </div>
                        </div>
                        <div class="row">
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--  <span class="icon major fa-cloud accent4"></span>-->
                                    <span class="image featured"><img src="images/ImagenPrueba2.jpg" alt="" /></span>
                                    <h3>Muebles Coloniales</h3>
                                    <p>Son propios de las fincas y haciendas previas al siglo XX. Para su fabricación se recurre a materiales autóctonos, detalles artesanales, maderas macizas y toques exóticos.</p>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <!--   <span class="icon major fa-lock accent5"></span>-->
                                    <span class="image featured"><img src="images/ImagenPrueba.jpg" alt="" /></span>
                                    <h3>Muebles Rústicos</h3>
                                    <p> Los muebles que cuentan con este estilo tienen una apariencia folklórica. Transmiten la sensación de ser muebles usados, sencillos o rudimentarios.</p>
                                </section>
                            </div>
                        </div>
                    </section>

                    <div class="row">
                        <div class="6u 12u(narrower)">
                            <section class="box special">
                                <span class="image featured"><img src="images/VisaMCAmex.jpg" alt="" /></span>
                                <h3>Formas de Pago</h3>
                                <p>En Muebleria Los Alpes, contamos con varias facilidades de Pago, como lo son  Tarjetas de Crédito, Débito y Depósitos a nuestra cuenta. </p>
                                <ul class="actions">
                                    <li><a href="#" class="button alt">Más Información</a></li>
                                </ul>
                            </section>
                        </div>
                        <div class="6u 12u(narrower)">

                            <section class="box special">
                                <span class="image featured"><img src="images/pic03.jpg" alt="" /></span>
                                <h3>Entregas a Domicilio</h3>
                                <p>Para facilitarle la entrega de su pedido, contamos también con el servicio de entrega a cualquier parte de Centroamerica.</p>
                                <ul class="actions">
                                    <li><a href="#" class="button alt">Más Información</a></li>
                                </ul>
                            </section>

                        </div>
                        <%if (nivel.equals("1")) {%>
                        <div class="12u 20u(narrower)">

                            <section class="box special">
                                <span class="image featured"><img src="images/pic03.jpg" alt="" /></span>
                                <h3>REPORTERIA</h3>
                                <p>Para facilitarle la entrega de su pedido, contamos también con el servicio de entrega a cualquier parte de Centroamerica.</p>
                                <ul class="actions">
                                    <li><a href="#" class="button alt">Más Información</a></li>
                                </ul>
                            </section>

                        </div>
                        <%}%>
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

            <!-- Scripts -->
            <script src="assets/js/jquery.min.js"></script>
            <script src="assets/js/jquery.dropotron.min.js"></script>
            <script src="assets/js/jquery.scrollgress.min.js"></script>
            <script src="assets/js/skel.min.js"></script>
            <script src="assets/js/util.js"></script>
            <!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
            <script src="assets/js/main.js"></script>
        </section>
    </body>
</html>
