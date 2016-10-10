<%-- 
    Document   : productosCarrito
    Created on : 9/10/2016, 08:45:11 PM
    Author     : panle
--%>

<%@page import="modelo.Idioma"%>
<%@page import="ClasesGenericas.Producto"%>
<%@page import="ClasesGenericas.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Controlador.controladorProducto"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(true);
    ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
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
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
        <!--        <script type ="text/javascript">
                    previene = function () {
                        window.stop;
                        history.go(1);
                    };
                    window.back = previene();
                </script>-->
    </head>
    <body  class="landing">
        <%
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
            // controladorProducto cp = new controladorProducto();
            //   ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
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
                                <a  class= "button special" >Usuario:  <%=usuario%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                                <ul>
                                    <li> <a href="modificaCliente.jsp" class ="actions">Modificar mis Datos</a> </li>
                                    <li> <a href="logout.jsp" class ="actions">Cerrar Sesión</a> </li>
                                </ul>
                            </li>
                            <%} else {%>
                            <li>
                                <a href="login.jsp" class= "button special"> Entrar <img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
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
                    <img class="image featured" src="images/logo.png" alt="log" />
                    <p>Sirviendole con total amabilidad desde 1985.</p>
                </section>
                <!-- Main -->
                <section class="container" id="main">
                    <div class="container">
                        <div class="row">
                            <div class="12u">
                                <!-- Table -->
                                <section class="box">
                                    <h3>Lista Productos</h3>
                                    <h4>Orden de Compra</h4>
                                    <div class="table-wrapper">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Cantidad</th>
                                                    <th>Foto</th>
                                                    <th>Descripcion</th>
                                                    <th>Precio U</th>
                                                    <th>Subtotal</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    controladorProducto cp = new controladorProducto();
                                                    double total = 0;
                                                    if (articulos != null) {
                                                        for (Compra a : articulos) {
                                                            Producto producto = cp.getProducto(a.getIdProducto());
                                                            total += a.getCantidad() * producto.getPRECIOVENTA();
                                                %>
                                                <tr>
                                                    <td class="cart_quantity">
                                                        <div class="cart_quantity_button">
                                                            <a class="cart_quantity_up" href=""> + </a>
                                                            <input class="cart_quantity_input" type="text" name="quantity" value="<%= a.getCantidad()%>" autocomplete="off" size="2">
                                                            <a class="cart_quantity_down" href=""> - </a>
                                                        </div>
                                                    </td>
                                                    <td >
                                                        <img src="<%= producto.getFOTO()%>" alt="" width="100">
                                                    </td>
                                                    <td><%= producto.getNOMBRE()%></td>
                                                    <td><%= producto.getPRECIOVENTA()%></td>
                                                    <td class="cart_total">
                                                        <p class="cart_total_price">$<%= Math.round(producto.getPRECIOVENTA() * a.getCantidad() * 100.0) / 100.0%></p>
                                                    </td>
                                                    <td class="cart_delete">
                                                        <span id="idarticulo" style="display:none;"><%=producto.getID_PRODUCTO()%></span>
                                                        <a class="cart_quantity_delete" href="" id="deleteitem"><i class="fa fa-times"></i></a>
                                                    </td>
                                                </tr>
                                                <% }
                                                                                            } else {%>
                                            <h4>No hay Articulos en el carro</h4>
                                            <%}%>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="3"></td>
                                                    <td>Total</td>
                                                    <td>100.00</td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                        <a href="javascript:window.history.go(-2);">Seguir Comprando</a>
                                    </div>
                                </section>>
                            </div>
                        </div>

                    </div>
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
                </section>                                 
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
