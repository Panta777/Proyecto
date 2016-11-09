<%-- 
    Document   : conctact
    Created on : 12/09/2016, 02:26:32 PM
    Author     : DesarrolloPantaleon
--%>

<%@page import="modelo.Idioma"%>
<%@page session = "true"%>
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
    }

    // ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");

%>
<!DOCTYPE HTML>
<html>
    <head>
        <title><% out.write(idioma.getProperty("Contacto"));%></title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico "/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
        <script>
            (function (i, s, o, g, r, a, m) {
                i['GoogleAnalyticsObject'] = r;
                i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date();
                a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
                a.async = 1;
                a.src = g;
                m.parentNode.insertBefore(a, m)
            })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

            ga('create', 'UA-329936-3', 'auto');
            ga('send', 'pageview');

        </script>
    </head>
    <body class ="landing">
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
            <section id="banner" class ="box special">
                <span class="image featured"><img src="images/logo.png" alt="log" /></span>
                <p><% out.write(idioma.getProperty("Sirviendolecon"));%></p>

            </section>
            <!-- Main -->
            <section class="box special" id="main">
                <div class="box">
                    <h2><% out.write(idioma.getProperty("Ubicación"));%></h2>
                    <p><% out.write(idioma.getProperty("Puedesencontrarnosen"));%></p>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d247063.69281388656!2d-90.5068824!3d14.634914899999991!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x130d2fa32ad2286a!2sColegio+Biling%C3%BCe+IMB-PC!5e0!3m2!1ses-419!2sgt!4v1473730975168" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
                    <h2><% out.write(idioma.getProperty("Contactanos"));%></h2>
                    <p><% out.write(idioma.getProperty("Cuentanos"));%></p>
                    <form method="post" action="#">
                        <div class="row uniform 50%">
                            <div class="6u 12u(mobilep)">
                                <input type="text" name="name" id="name" value="" placeholder=<% out.write(idioma.getProperty("nombre"));%> />
                            </div>
                            <div class="6u 12u(mobilep)">
                                <input type="email" name="email" id="email" value=""placeholder=<% out.write(idioma.getProperty("email"));%>  />
                            </div>
                        </div>
                        <div class="row uniform 50%">
                            <div class="12u">
                                <input type="text" name="subject" id="subject" value="" placeholder=<% out.write(idioma.getProperty("subject"));%> />
                            </div>
                        </div>
                        <div class="row uniform 50%">
                            <div class="12u">
                                <textarea name="message" id="message" rows="6" placeholder=<% out.write(idioma.getProperty("message"));%> ></textarea>
                            </div>
                        </div>
                        <div class="row uniform">
                            <div class="12u">
                                <ul class="actions align-center">
                                    <li><input type="submit" value=<% out.write(idioma.getProperty("Enviar"));%>  /></li>
                                </ul>
                            </div>
                        </div>
                    </form>

                </div>
            </section>
            <section class="box special">
                <div id="fb-root"></div>
                <script>
                    (function (d, s, id) {
                        var js, fjs = d.getElementsByTagName(s)[0];
                        if (d.getElementById(id))
                            return;
                        js = d.createElement(s);
                        js.id = id;
                        js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.7&appId=348569358813605";
                        fjs.parentNode.insertBefore(js, fjs);
                    }(document, 'script', 'facebook-jssdk'));
                </script>
                <br><br>
                <h2><% out.write(idioma.getProperty("CajaComentarios"));%></h2>
                <div class="fb-comments" data-href="https://web.facebook.com/Muebleria-los-Alpes-GT-690252594463736/?fref=nf" data-width="750" data-numposts="2"></div>
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
                    <li>&copy; <% out.write(idioma.getProperty("TodoslosDerechosReservados"));%></li><li><% out.write(idioma.getProperty("Diseñadopor"));%> <a href="#">Panta Medrano</a></li>
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