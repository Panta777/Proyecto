<%-- 
    Document   : nuevoCliente
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="modelo.Idioma"%>
<%@page import="modelo.OperacionesCliente"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registro de Nuevo Cliente</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico "/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <meta http-equiv="Cache-Control" content="no-cache">
        <meta HTTP-EQUIV="Expires" CONTENT="Tue, 01 Jan 1980 1:00:00 GMT">
        <meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <script type="text/javascript">
            function AutenticaSiEsHumano(form)
            {
                if (form.human.checked === true)
                {
                    form.EnviaCliente.disabled = false;
                } else
                {
                    form.EnviaCliente.disabled = true;
                }
            }

            function CompruebaContras() {
                var texto = document.getElementById("pass");
                var texto2 = document.getElementById("pass2");
                if (texto.value === texto2.value) {
                    return true;
                } else
                {
                    alert("Contraseñas no coinciden");
                    return false;
                }
            }
            previene = function () {
                window.stop;
                history.go(1);
            };
            window.back = previene();
        </script>        
        <%
            Idioma idioma = null;
            HttpSession sesion = request.getSession(true);
            if (sesion.getAttribute("Idioma") == null || sesion.getAttribute("Idioma").equals("Español")) {
                sesion.setAttribute("Idioma", "Español");
                idioma = new Idioma("Español");
            } else {
                idioma = new Idioma("Ingles");
            }

            String nivel = "", usuario = "", resOper = "";
            if (sesion.getAttribute("nivel") != null && sesion.getAttribute("user") != null) {
                nivel = sesion.getAttribute("nivel").toString();
                usuario = sesion.getAttribute("user").toString();
            }
            if (!nivel.equals("2") && !nivel.equals("1")) {
                response.sendRedirect("index.jsp#main");
            }

            if (sesion.getAttribute("resOper") != null) {
                resOper = sesion.getAttribute("resOper").toString();
            }
        %>
    </head>
    <body class="landing">
        <div id="page-wrapper">
            <!-- Header -->
            <header id="header" >
                <h1><a href="#main"><% out.write(idioma.getProperty("mueblierialosalpes"));%></a></h1>
                <nav id="nav">
                    <ul>
                        <li>
                            <a href="index.jsp#main">Inicio</a>
                        </li>
                        <li>
                            <a href="#" class="icon fa-angle-down">Menu</a>
                            <ul>
                                <li><a href="#catalogo">Catálogo Productos</a></li>
                                <li><a href="contact.jsp#main">Contacto</a></li>
                                <li><a href="productosCarrito.jsp#OrdenCompra">Ver Pedido</a></li> 
                            </ul>
                        </li>
                        <%if (nivel.equals("1")) {%>
                        <li>
                            <a href="#" class="icon fa-angle-down">Administracion</a>
                            <ul>
                                <li><a href="index.jsp#reporteria">Reporteria</a></li>
                                <li><a href="index.jspa#mantenimiento">Mantenimientos</a></li>
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
                            <a  class= "button special" >Usuario:  <%=usuario%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                            <ul>

                                <li> <a href="modificaCliente.jsp#main" class ="actions">Modificar mis Datos</a> </li>
                                <li> <a href="logout.jsp" class ="actions">Cerrar Sesión</a> </li>
                            </ul>
                        </li>
                        <%} else {%>
                        <li>
                            <a href="#" class= "icon fa-angle-down">Ingresa o Registrate<img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                            <ul>
                                <li>
                                    <a href="login.jsp#main" class= "actions"> Entrar  </a>
                                </li>
                                <li> <a href="nuevoCliente.jsp#main" class ="actions">Registrate</a> </li>
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
            <section id="main" class="container">
                <section class="box special">
                    <header class="major">
                        <h2>REGISTRO NUEVO PRODUCTO</h2>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                    </header>                
                </section>
                <div class="row">
                    <div class="12u">
                        <!-- Form -->
                        <section class="box">
                            <h3><p>Ingrese los siguientes Datos</p></h3>
                            <form method="post" action="controladorProducto">
                                <div class="row uniform 50%">
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="" id="NoDoc" value="" placeholder="Referencia" />
                                    </div>                               
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="FName" id="FName" value="" placeholder="<%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="LName" id="LName" value="" placeholder="Descripcion"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <select  name="TipoProd" id="TipoProd" >
                                                <option value="" disabled selected hidden>-Categoria-</option>
                                                <option value="Tradicionales">Tradicionales</option>
                                                <option value="Modernos">Modernos</option>
                                                <option value="Coloniales">Coloniales</option>
                                                <option value="Rusticos">Rusticos</option>
                                            </select>
                                        </div>
                                    </div> 
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="TelRes" id="TelRes" value="" placeholder="MATERIAL" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="TelCel" id="TelCel" value="" placeholder="ALTO"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Nit" id="Nit" value="" placeholder="ANCHO" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Direccion" id="Direccion" value="" placeholder="PROFUNDIDAD"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Ciudad" id="Ciudad" value="" placeholder="COLOR" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Departamento" id="Departamento" value="" placeholder="PESO"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Pais" id="Pais" value="" placeholder="FOTO" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Profesion" id="Profesion" value="" placeholder="FECHA_ALTA"  />
                                    </div>

                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Direccion" id="Direccion" value="" placeholder="ESTADO"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Ciudad" id="Ciudad" value="" placeholder="PRECIOVENTA" />
                                    </div>
                                    <div class="row uniform " id = "ResultadoNuevoCliente">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li><input type="submit" name ="Enviar" value="Enviar" /></li>
                                            </ul>
                                        </div>
                                        <%
                                            if (sesion.getAttribute("resOper") != null) {
                                                out.write((String) sesion.getAttribute("resOper"));
                                                // out.write("<h5 style=\" color:red; font-weight:bold;\"><p> FALLO AL INSERTAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>");
                                            }
                                        %>
                                    </div>
                                </div>
                            </form>
                        </section>
                    </div>
                    <hr />
                </div>
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
<script src="assets/js/main.js"></script>
</body>
</html>