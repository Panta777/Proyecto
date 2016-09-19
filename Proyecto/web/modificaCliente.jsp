<%-- 
    Document   : login
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="modelo.Idioma"%>
<%@page import="modelo.Operaciones"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Actualización de mis Datos</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    </head>
    <body>
        <%
            Idioma idioma = new Idioma("Español");
            String nivel = "", usuario = "";
            if (session.getAttribute("nivel") != null) {
                nivel = session.getAttribute("nivel").toString();
                usuario = session.getAttribute("user").toString();
                System.out.println("///// Usuario: " + usuario);
                System.out.println("///// Tiempo:" + session.getMaxInactiveInterval());
            } 
            else 
            {
                response.sendRedirect("index.jsp");
            }

        %>
        <div id="page-wrapper">
            <!-- Header -->
            <header id="header" >
                <nav id="nav">
                    <ul>
                        <li><a href="index.jsp">Inicio</a></li>
                        <li>
                            <a href="#" class="icon fa-angle-down">Menu</a>
                            <ul>
                                <% if (session.getAttribute("user") == null) {%>
                                <li><a href="nuevoCliente.jsp">Registro Nuevo Cliente</a></li>
                                <%} else {%>
                                <li> <a href="modificaCliente.jsp" class ="actions">Modificar mis Datos</a> </li>
                                <%}%> 
                                <li><a href="catalogo.jsp">Catálogo Productos</a></li>
                                <li><a href="contact.jsp">Contactos</a></li>
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
                        <li><a href="#" class="icon fa-angle-down"><% out.write(idioma.getProperty("cambioIdioma"));%></a>
                            <ul>
                                <li><a href="#"><% out.write(idioma.getProperty("espanol"));%></a></li>
                                <li><a href="#"><% out.write(idioma.getProperty("ingles"));%></a></li>
                            </ul>
                        </li>
                        <%if (usuario != "") {%>
                        <li>
                            <a  class= "button">Usuario:  <%=session.getAttribute("user").toString()%><img src="images/vercarrito.gif" width="25" height="21" border="0"> </a>
                            <ul>
                                <% if (session.getAttribute("user") != null) {%>
                                <li> <a href="logout.jsp" class ="actions">Salir</a> </li>
                            </ul>
                            <%}%>
                        </li>
                        <%}%>
                    </ul>     
                </nav>
            </header>
            <!-- Main -->
            <section id="main" class="container">
                <!--  <header>
                      <h2>Formulario Cliente Nuevo</h2>
                      <p>Ingrese sus Datos</p>
                  </header>-->
                <header>
                    <h2>Actualizar mis Datos</h2>
                </header>
            </section>
            <div class="row">
                <div class="12u">
                    <!-- Form -->
                    <section class="box">
                        <h3><p>Modifique los Datos Deseados:</p></h3>
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
                                    <div class="select-wrapper">
                                        <select name="category" id="category">
                                            <option value="">- Category -</option>
                                            <option value="1">Manufacturing</option>
                                            <option value="1">Shipping</option>
                                            <option value="1">Administration</option>
                                            <option value="1">Human Resources</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row uniform 50%">
                                <div class="4u 12u(narrower)">
                                    <input type="radio" id="priority-low" name="priority" checked>
                                    <label for="priority-low">Low Priority</label>
                                </div>
                                <div class="4u 12u(narrower)">
                                    <input type="radio" id="priority-normal" name="priority">
                                    <label for="priority-normal">Normal Priority</label>
                                </div>
                                <div class="4u 12u(narrower)">
                                    <input type="radio" id="priority-high" name="priority">
                                    <label for="priority-high">High Priority</label>
                                </div>
                            </div>
                            <div class="row uniform 50%">
                                <div class="6u 12u(narrower)">
                                    <input type="checkbox" id="copy" name="copy">
                                    <label for="copy">Email me a copy of this message</label>
                                </div>
                                <div class="6u 12u(narrower)">
                                    <input type="checkbox" id="human" name="human" checked>
                                    <label for="human">I am a human and not a robot</label>
                                </div>
                            </div>
                            <div class="row uniform 50%">
                                <div class="12u">
                                    <textarea name="message" id="message" placeholder="Enter your message" rows="6"></textarea>
                                </div>
                            </div>
                            <div class="row uniform ">
                                <div class="12u">
                                    <ul class="actions">
                                        <li><input type="submit" value="Send Message" /></li>
                                        <li><input type="reset" value="Reset" class="alt" /></li>
                                    </ul>
                                </div>
                            </div>
                        </form>
                        <hr />

                        <%
                            Operaciones op = new Operaciones();

                            if (request.getParameter("Enviar") != null) {
                                String usu = request.getParameter("");
                                String contra = request.getParameter("");
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
                                        response.sendRedirect("generic.jsp");

                                        break;

                                    default:
                                        out.write("Usuario no existe, o contraseña invalida");
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
