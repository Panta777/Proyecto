<%@page import="modelo.Utileria"%>
<%@page import="Controlador.agregarproducto"%>
<%@page import="ClasesGenericas.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Idioma"%>
<%@page import="Controlador.controladorProducto"%>
<%@page import="ClasesGenericas.Producto"%>
<%
    int id = 0;
    Producto producto = null;
    if (request.getParameter("id") != null) {
        id = Integer.parseInt(request.getParameter("id"));
        producto = new controladorProducto().getProducto(id);
    }

    Utileria algo = new Utileria();

    System.out.println(algo.getLocalIpAddress());

    Idioma idioma = null;
    HttpSession sesion = request.getSession(true);
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

    String noVenta = "";
    if (sesion.getAttribute("NoInventario") != null) {
        noVenta = sesion.getAttribute("NoInventario").toString();
    }

    // System.out.println("No venta:" + noVenta);
    // controladorProducto cp = new controladorProducto();
    //ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
%>
<!DOCTYPE html>
<html >
    <head>
        <title><% out.write(idioma.getProperty("mueblierialosalpes"));%></title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico"/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/main.css" />
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
            function Error_Cargar() {
                window.event.srcElement.style.display = "None";
            }
        </script>
    </head>
    <body class="landing" oncontextmenu='return false'>
        <section id="container" > 
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
                            <%if (nivel.equals("2") || nivel.equals("1")) {%>
                            <li>
                                <a  class= "button special" ><% out.write(idioma.getProperty("usuario"));%><%=usuario%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito" onerror="Error_Cargar()"> </a>
                                <ul> 
                                    <li> <a href="modificaCliente.jsp#main" class ="actions"><% out.write(idioma.getProperty("ModificarmisDatos"));%></a> </li>
                                    <li> <a href="logout.jsp" class ="actions"><% out.write(idioma.getProperty("CerrarSesión"));%></a> </li>
                                </ul>
                            </li>
                            <%} else {%>
                            <li>
                                <a href="#" class= "icon fa-angle-down"><% out.write(idioma.getProperty("IngresaroRegistrarse"));%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito" onerror="Error_Cargar()"> </a>
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
                <section id="banner" class ="box">
                    <img class="image featured" src="images/logo.png" alt="log" onerror="Error_Cargar()" />
                    <p><% out.write(idioma.getProperty("Sirviendolecon"));%></p>
                    <%if (nivel.equals("4") || nivel.equals("3") || nivel.equals("")) {%>
                    <ul class="actions" id = "botonesEntrada">
                        <li><a href="login.jsp#main" class="button special"><% out.write(idioma.getProperty("Entrar"));%></a></li>
                        <li><a href="nuevoCliente.jsp#main" class="button"><% out.write(idioma.getProperty("Registrate"));%></a></li>
                    </ul>
                    <%}%>
                </section>
                <!-- Main -->
                <section id="main" class="container" >
                    <div class="row">
                        <div class="12u">
                            <section class="box">
                                <%if (producto != null) {%>
                                <center><h2><%=producto.getNOMBRE()%></h2></center>
                                <div class="row" >
                                    <div class="4u 8u(mobilep)">
                                        <section class="box ">
                                            <div class="image featured"><img src="<%=producto.getFOTO()%>" alt="=<%=producto.getFOTO()%>" onerror="Error_Cargar()"/></div>
                                        </section>
                                    </div>
                                    <div class="8u 12u(mobilep)">
                                        <section class="box " >
                                            <h2><% out.write(idioma.getProperty("Detalles"));%></h2>
                                            <h3><%=producto.getDESCRIPCION()%></h3>      
                                            <h4><% out.write(idioma.getProperty("TIPO"));%>: <%= producto.getTIPO()%></h4>
                                            <h4><% out.write(idioma.getProperty("ALTO"));%>: <%= producto.getALTO()%></h4>
                                            <h4><% out.write(idioma.getProperty("ANCHO"));%>: <%= producto.getANCHO()%></h4>
                                            <h4><% out.write(idioma.getProperty("PROFUNDIDAD"));%>: <%= producto.getPROFUNDIDAD()%></h4>
                                            <h4><% out.write(idioma.getProperty("COLOR"));%>: <%= producto.getCOLOR()%></h4>
                                            <h4><% out.write(idioma.getProperty("CONDICIÓN"));%>: <%= producto.getESTADO()%></h4>
                                        </section>
                                    </div>
                                </div>

                                <center>
                                    <form method="post" action="agregarproducto">
                                        <h2><% out.write(idioma.getProperty("VALORMONEDA"));%> <%=algo.convertirCantidad(producto.getPRECIOVENTA())%></h2>
                                        <h4><% out.write(idioma.getProperty("CantidadalCarrito"));%></h4>
                                        <div class="6u" >
                                            <input type="hidden" value="<%= producto.getID_PRODUCTO()%>" name="idproducto">
                                            <input type="text" style = 'font-size: 20px; font-weight: bold; color: ' value="" id="txt-cantidad" name="cantidad" onkeypress="return valida(event)"/>
                                        </div>
                                        <button type="submit" style = 'font-size: 18px; '>
                                            <i class="fa fa-shopping-cart"></i>
                                            <% out.write(idioma.getProperty("AGREGAR"));%>
                                        </button>
                                    </form>
                                </center>

                                <%if (!noVenta.contains("PRODUCTO") && !noVenta.equals("")) {
                                        sesion.setAttribute("NoInventario", null);%>
                                <div  id="noAlcanzaInventario">
                                    <a href="#main">  <h3 style ='color:red;' ><% out.write(noVenta);%> &nbsp; </h3></a>
                                </div>
                                <%}%>

                                <%}%>
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
                            <li>&copy; <% out.write(idioma.getProperty("TodoslosDerechosReservados"));%></li><li><% out.write(idioma.getProperty("Diseï¿½adopor"));%> <a href="https://www.facebook.com/panta.medrano">Panta Medrano</a></li>
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
        <script src="assets/js/main.js"></script>
    </body>
</html>