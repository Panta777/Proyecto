<%@page import="ClasesGenericas.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Idioma"%>
<%@page import="Controlador.controladorProducto"%>
<%@page import="ClasesGenericas.Producto"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Producto producto = new controladorProducto().getProducto(id);
    System.out.println("prod:" + producto.getNOMBRE());
%>

<!DOCTYPE html>
<html >
    <head>
        <title>Muebles Los Alpes</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico"/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
        <script type ="text/javascript">
            previene = function () {
                window.stop;
                history.go(1);
            };
            window.back = previene();
        </script>
    </head>
    <body class="landing">
        <%
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
            // controladorProducto cp = new controladorProducto();
            ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
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
                <section id="main" class="container">
                    <!--                    <section class="box special">
                                            <header class="major">
                                                <h2>CATÁLOGO DE PRODUCTOS</h2>
                                                <p>Nuestros productos están divididos en diferentes categorias para su mayor comodidad.</p>
                                            </header>
                                            <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                                        </section>-->
                    <section class="box special features" id = "tradcionales" ><h2><%=producto.getNOMBRE()%></h2>
                        <div class="row" >
                            <div class="6u 12u(narrower)">
                                <section class="box special">
                                    <div class="image featured"><img src="<%=producto.getFOTO()%>" alt="Muebles Tradicionales" /></div>
                                </section>
                            </div>
                            <div class="6u 12u(narrower)">
                                <section class="box" >
                                    <h2><%=producto.getDESCRIPCION()%></h2>      
                                    <h3>Detalles</h3>
                                    <h5>Tipo Mueble: <%= producto.getTIPO()%></h5>
                                    <h5>Precio Venta: Q. <%= producto.getPRECIOVENTA()%></h5>
                                    <h5>ALTO: <%= producto.getALTO()%></h5>
                                    <h5>ANCHO: <%= producto.getANCHO()%></h5>
                                    <h5>PROFUNDIDAD: <%= producto.getPROFUNDIDAD()%></h5>
                                    <h5>COLOR: <%= producto.getCOLOR()%></h5>
                                    <h5>ESTADO: <%= producto.getESTADO()%></h5>
                                    <form action="agregarproducto" method="post"><h2>Q. <%= producto.getPRECIOVENTA()%></h2>
                                        <span>
                                            <label>Cantidad al Carrito:</label>
                                            <input type="hidden" value="<%= producto.getID_PRODUCTO()%>" name="idproducto">
                                            <input type="text" value="" id="txt-cantidad" name="cantidad"/>
                                            <button type="submit" class="btn btn-fefault cart">
                                                <i class="fa fa-shopping-cart"></i>
                                                Agregar al Carrito
                                            </button>
                                        </span>
                                    </form>
<!--                                    <ul class="actions">
                                        <li><input type="submit" name ="AgregarProducto" value="AGREGAR"  /></li>
                                    </ul>-->
                                </section>
                            </div>
                        </div>
                        <div class="row">
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