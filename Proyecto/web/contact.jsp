<%-- 
    Document   : conctact
    Created on : 12/09/2016, 02:26:32 PM
    Author     : DesarrolloPantaleon
--%>

<%@page import="modelo.Idioma"%>
<%@page session = "true"%>
<!DOCTYPE HTML>
<!--
        Alpha by HTML5 UP
        html5up.net | @ajlkn
        Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
    <head>
        <title>Contacto</title>
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
            if (sesion.getAttribute("nivel") != null) {
                nivel = sesion.getAttribute("nivel").toString();
            }
        %>
        <div id="page-wrapper">
            <!-- Header -->
            <header id="header">
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
                            <a  class= "button">Usuario:  <%=usuario%><img src="images/vercarrito.gif" width="25" height="21" border="0"> </a>
                            <ul>
                                <li> <a href="modificaCliente.jsp" class ="actions">Modificar mis Datos</a> </li>
                                <li> <a href="logout.jsp" class ="actions">Cerrar Sesión</a> </li>
                            </ul>
                        </li>
                        <%}%>
                    </ul>     
                </nav>
            </header>
            <!-- Banner -->
            <section id="banner" class ="box special">
                <span class="image featured"><img src="images/logo.png" alt="log" /></span>
                <p>Sirviendole con total amabilidad desde 1985.</p>
            </section>
            <!-- Main -->
            <section class="box special">
                <div class="box">
                    <h2>Ubicación</h2>
                    <p>Puedes encontrarnos en la siguiente dirección</p>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d247063.69281388656!2d-90.5068824!3d14.634914899999991!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x130d2fa32ad2286a!2sColegio+Biling%C3%BCe+IMB-PC!5e0!3m2!1ses-419!2sgt!4v1473730975168" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
                </div>
            </section>
            <section class="box special">
                <h2>Contact Us</h2>
                <p>Tell us what you think about our little operation.</p>
                <div class="box">
                    <form method="post" action="#">
                        <div class="row uniform 50%">
                            <div class="6u 12u(mobilep)">
                                <input type="text" name="name" id="name" value="" placeholder="Name" />
                            </div>
                            <div class="6u 12u(mobilep)">
                                <input type="email" name="email" id="email" value="" placeholder="Email" />
                            </div>
                        </div>
                        <div class="row uniform 50%">
                            <div class="12u">
                                <input type="text" name="subject" id="subject" value="" placeholder="Subject" />
                            </div>
                        </div>
                        <div class="row uniform 50%">
                            <div class="12u">
                                <textarea name="message" id="message" placeholder="Enter your message" rows="6"></textarea>
                            </div>
                        </div>
                        <div class="row uniform">
                            <div class="12u">
                                <ul class="actions align-center">
                                    <li><input type="submit" value="Send Message" /></li>
                                </ul>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
            <section class="box special">
                <div id="fb-root"></div>
                <script>(function (d, s, id) {
                        var js, fjs = d.getElementsByTagName(s)[0];
                        if (d.getElementById(id))
                            return;
                        js = d.createElement(s);
                        js.id = id;
                        js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.7&appId=348569358813605";
                        fjs.parentNode.insertBefore(js, fjs);
                    }(document, 'script', 'facebook-jssdk'));</script>
                <br><br>
                <h2>CAJA COMENTARIOS</h2>
                <div class="fb-comments" data-href="https://web.facebook.com/Muebleria-los-Alpes-GT-690252594463736/?fref=nf" data-width="750" data-numposts="2"></div>            </section>
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