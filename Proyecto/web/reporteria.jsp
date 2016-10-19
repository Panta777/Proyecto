<%-- 
    Document   : productosCarrito
    Created on : 9/10/2016, 08:45:11 PM
    Author     : panle
--%>
<%@page import="modelo.Utileria"%>
<%@page import="modelo.Idioma"%>
<%@page import="ClasesGenericas.Producto"%>
<%@page import="ClasesGenericas.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Controlador.controladorProducto"%>
<%@page import="Controlador.EliminarProducto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(true);
    ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
    Utileria algo = new Utileria();

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
    }
    int opera = 0;
    if (request.getAttribute("Operacion") != null) {
        opera = Integer.parseInt(request.getParameter("Operacion"));
    }
    // controladorProducto cp = new controladorProducto();
    //   ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Muebles Los Alpes</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico"/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <meta http-equiv="cache-control" content="max-age=0" />
        <meta http-equiv="cache-control" content="no-cache" />
        <meta http-equiv="expires" content="0" />
        <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
        <meta http-equiv="pragma" content="no-cache" />
        <!--        <link rel="stylesheet" href="assets/css/otros.css" />
                <link rel="stylesheet" href="assets/css/otros2.css" />-->
        <script type ="text/javascript">
            previene = function () {
                window.stop;
                history.go(1);
            };
            window.back = previene();
        </script>
        <script type="text/javascript">
            function mostrar() {
                document.getElementById('pagotarjeta').style.display = 'block';
            }

            function mostrarNoLogueado() {
                document.getElementById('NoLogueado').style.display = 'block';
            }
        </script>
        <script>
            function valida(e) {
                tecla = (document.all) ? e.keyCode : e.which;

                //Tecla de retroceso para borrar, siempre la permite
                if (tecla == 8) {
                    return true;
                }

                // Patron de entrada, en este caso solo acepta numeros
                patron = /[0-9]/;
                tecla_final = String.fromCharCode(tecla);
                return patron.test(tecla_final);
            }
        </script>
    </head>
    <body  class="landing">
        <!--        <section id="container" > -->
        <div id="page-wrapper">
            <!-- Header -->
            <header id="header" >
                <h1><a href="#main"><% out.write(idioma.getProperty("mueblierialosalpes"));%></a></h1>
                <nav id="nav">
                    <ul>
                        <li>
                            <a href="index.jsp">Inicio</a>
                        </li>
                        <li>
                            <a href="#" class="icon fa-angle-down">Menu</a>
                            <ul>
                                <li><a href="catalogo.jsp#main">Catálogo Productos</a></li>
                                <li><a href="contact.jsp#main">Contacto</a></li>
                                <li><a href="productosCarrito.jsp#main">Ver Pedido</a></li> 
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
            <section id="banner" class ="box">
                <img class="image featured" src="images/logo.png" alt="log" />
                <p>Sirviendole con total amabilidad desde 1985.</p>
            </section>
            <!-- Main -->
            <section class="container" id="main">
                <section class="box special">
                    <header class="major">
                        <h2>REPORTERIA</h2>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                    </header>                
                </section>
                <!-- Tabla Productos del Carrito -->
                <div class="12u 20u(narrower)" id ="OrdenCompra">
                    <!--<div class="20u "> -->
                    <!-- Table -->
                    <section class="box" >
                        <div class="table-wrapper">
                            <%
                                controladorProducto cp = new controladorProducto();
                                double total = 0;
                                if (articulos != null && articulos.size() > 0) {%>
                            <table>
                                <thead>
                                    <tr>
                                        <th><h4>Cantidad</h4></th>
                                <th>Foto</th>
                                <th>Descripcion</th>
                                <th>Precio U</th>
                                <th>Subtotal</th>
                                <th>Eliminar</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (Compra a : articulos) {
                                            Producto producto = cp.getProducto(a.getIdProducto());
                                            total += a.getCantidad() * producto.getPRECIOVENTA();
                                    %>
                                    <tr>
                                        <td>
                                            <div class="4u">
                                                <h4><%= a.getCantidad()%> </h4>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="4u">
                                                <img src="<%= producto.getFOTO()%>" alt="foto" width="80" height="80"> 
                                            </div>
                                        </td>
                                        <td><%= producto.getNOMBRE()%></td>
                                        <td>Q. <%= algo.convertirCantidad(producto.getPRECIOVENTA())%></td>
                                        <td class="cart_total">
                                            <p class="cart_total_price">Q. <%= algo.convertirCantidad(Math.round(producto.getPRECIOVENTA() * a.getCantidad() * 100.0) / 100.0)%></p>
                                        </td>
                                        <td class="cart_delete">
                                            <form method="post" action="EliminarProducto">
                                                <span id="idarticulo" style="display:none;"><%=producto.getID_PRODUCTO()%></span>
                                                <input type="hidden" value="<%= producto.getID_PRODUCTO()%>" name="idproducto">
                                                <button type="submit" >
                                                    <i class="fa fa-times"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="3"></td>
                                        <td><h3>Total</h3></td>
                                        <td><h3>Q. <%=algo.convertirCantidad(total)%></h3></td>
                                    </tr>
                                </tfoot>
                            </table>
                            <% } else {%>
                            <h4>No hay Articulos en el carrito &nbsp;
                                <img  src="images/404.png" alt=" Sin Muebles"  width="25" height="21" /></h4> 
                                <%}%>
                            &nbsp;
                        </div>
                        <div class="row" >  
                            <div class="4u 12u(narrow)">
                                <a class ="button" href="catalogo.jsp?tipo=1#muebles">
                                    <!--                                <a class ="button special" href="#pagotarjeta" onclick="mostrar()">-->
                                    Seguir Comprando &nbsp; <img src="images/ICONOS BLANCOS/FACTURA.png" width="25" height="21" alt ="FAC"> 
                                </a>
                            </div>
                            <div class="4u 12u(narrow)">
                                <p></p>
                            </div> 
                            <%if (articulos != null && articulos.size() > 0 && (nivel.equals("2") || nivel.equals("1"))) {%>
                            <div class="4u 12u(mobilep)">
                                <a class ="button special" href="#pagotarjeta" onclick="mostrar()">
                                    Terminar Compra  &nbsp; <img src="images/ICONOS/TARJETA.png" width="25" height="21" alt ="TAR"> 
                                </a>
                            </div>
                            <%} else if (articulos != null && articulos.size() > 0) {%>
                            <div class="4u 12u(mobilep)">
                                <a class ="button special" href="#OrdenCompra" onclick="mostrarNoLogueado()">
                                    Terminar Compra  &nbsp; <img src="images/ICONOS/TARJETA.png" width="25" height="21" alt ="TAR"> 
                                </a>
                                <div class="row" style ='display:none' id ="NoLogueado">
                                    <h5 style ='color:red; font-weight:bold;' >(Debe estar logueado para completar la transacción)</h5>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </section>
                    <!-- </div> -->
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
                    <li>&copy; Todos los Derechos Reservados</li><li>Diseñado por: <a href="https://www.facebook.com/panta.medrano">Panta Medrano</a></li>
                </ul>
            </footer>
        </div> 
        <!--</section>-->
        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/jquery.dropotron.min.js"></script>
        <script src="assets/js/jquery.scrollgress.min.js"></script>
        <script src="assets/js/skel.min.js"></script>
        <script src="assets/js/util.js"></script>
        <script src="assets/js/main.js"></script>
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
        <script src="js/carrito.js"></script>
    </body>
</html>
