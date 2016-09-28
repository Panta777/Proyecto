<%-- 
    Document   : nuevoCliente
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="modelo.Idioma"%>
<%@page import="modelo.OperacionesCliente"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registro de Nuevo Cliente</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico "/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
        <script type="text/javascript">
            function AutenticaSiEsHumano(form)
            {
                if (form.human.checked === true)
                {
                    form.EnviaCliente.disabled = false;
                }
            }

            function CompruebaContras(form)
            {
                if (form.pass.value !== form.pass2.value)
                {
                    return alert("Contraseñas no coinciden");
                    window.onbeforeunload = function exitAlert()
                    {
                        var textillo = "Los datos que no se han guardado se perderan.";
                        return textillo;
                    }
                    // return "¿Seguro que quieres salir?";
                }
            }


        </script>
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
            if (session.getAttribute("nivel") != null && session.getAttribute("user") != null) {
                nivel = session.getAttribute("nivel").toString();
            }
            if (nivel.equals("2") || nivel.equals("1")) {
                response.sendRedirect("modificaCliente.jsp");
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
                                <li><a href="catalogo.jsp">Catálogo Productos</a></li>
                                <li><a href="contact.jsp">Contactos</a></li>
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
            <section id="banner" class ="box special">
                <span class="image featured"><img src="images/logo.png" alt="log" /></span>
                <p>Sirviendole con total amabilidad desde 1985.</p>
            </section>
            <!-- Main -->
            <section id="main" class="container">
                <section class="box special">
                    <header class="major">
                        <h2>REGISTRO NUEVO CLIENTE</h2>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                    </header>                
                </section>
                <div class="row">
                    <div class="12u">
                        <!-- Form -->
                        <section class="box">
                            <h3><p>Ingrese sus Datos</p></h3>
                            <form method="post" action="controladorCliente">
                                <div class="row uniform 50%">
                                    <div class="6u 12u(mobilep)">
                                        <input type="text" name="NoDoc" id="NoDoc" value="" placeholder="Docto <%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(mobilep)">
                                        <div class="select-wrapper">
                                            <select  name="TipoDoc" id="TipoDoc" >
                                                <option value="">-TipoDoc- <%out.write(idioma.getProperty("nombre"));%></option>
                                                <option value="DPI">DPI <%out.write(idioma.getProperty("nombre"));%></option>
                                                <option value="Pasaporte">Pasaporte <%out.write(idioma.getProperty("nombre"));%></option>
                                                <option value="Otros">Otro(Licencia Conducir...etc) <%out.write(idioma.getProperty("nombre"));%></option>
                                            </select>
                                        </div>
                                    </div>                                
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="FName" id="FName" value="" placeholder="<%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="LName" id="LName" value="" placeholder="Lname <% out.write(idioma.getProperty("email"));%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="TelRes" id="TelRes" value="" placeholder="TelRes<%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="TelCel" id="TelCel" value="" placeholder="TelCel <% out.write(idioma.getProperty("email"));%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Nit" id="Nit" value="" placeholder="Nit<%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Direccion" id="Direccion" value="" placeholder="Direccion<% out.write(idioma.getProperty("email"));%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Ciudad" id="Ciudad" value="" placeholder="Ciudad <%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Departamento" id="Departamento" value="" placeholder="Departamento<% out.write(idioma.getProperty("email"));%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Pais" id="Pais" value="" placeholder="Pais<%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Profesion" id="Profesion" value="" placeholder="Profesion<% out.write(idioma.getProperty("email"));%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="email" id="email" value="" placeholder="<%out.write(idioma.getProperty("email"));%>" />
                                    </div>
                                    <div class="12u">
                                        <h3>Datos para Ingreso al Sistema</h3> 
                                    </div>
                                    <div class="12u">
                                        <input type="text" name="usuario" id="usuario" value="" placeholder="usuario <% out.write(idioma.getProperty("email"));%>"  />
                                    </div>
                                    <div class="12u">
                                        <input type="Password" name="pass" id="pass" value="" placeholder="Password <% out.write(idioma.getProperty("email"));%>"  />
                                    </div>
                                    <div class="12u">
                                        <input type="Password" name="pass2" id="pass2" value="" placeholder="Confirme Password <% out.write(idioma.getProperty("email"));%>"  />
                                    </div>
                                    <div class="12u">
                                        <input type="checkbox" id="human" name="human"  onClick="AutenticaSiEsHumano(this.form)">
                                        <label for="human">I am a human and not a robot</label>
                                    </div>
                                </div>
                                <div class="row uniform ">
                                    <div class="12u">
                                        <ul class="actions">
                                            <li><input type="submit" name ="EnviaCliente" value="Send" disabled = true onClick="CompruebaContras(this.form)"/></li>
                                        </ul>
                                    </div>
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
