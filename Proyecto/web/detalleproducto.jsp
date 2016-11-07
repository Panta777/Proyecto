<%@page import="modelo.Utileria"%>
<%@page import="Controlador.agregarproducto"%>
<%@page import="ClasesGenericas.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Idioma"%>
<%@page import="Controlador.controladorProducto"%>
<%@page import="ClasesGenericas.Producto"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Producto producto = new controladorProducto().getProducto(id);

    Utileria algo = new Utileria();

    System.out.println(algo.getLocalIpAddress());
    //System.out.println("prod:" + producto.getNOMBRE());
    Idioma idioma = null;
    HttpSession sesion = request.getSession(true);
    if (sesion.getAttribute("Idioma") == null || sesion.getAttribute("Idioma").equals("Espa�ol")) {
        sesion.setAttribute("Idioma", "Espa�ol");
        idioma = new Idioma("Espa�ol");
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
                                    <li><a href="#catalogo"><% out.write(idioma.getProperty("Cat�logoProductos"));%></a></li>
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
                                    <li> <a href="logout.jsp" class ="actions"><% out.write(idioma.getProperty("CerrarSesi�n"));%></a> </li>
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
                <section id="banner" class ="box">
                    <img class="image featured" src="images/logo.png" alt="log" />
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
                                <center><h2><%=producto.getNOMBRE()%></h2></center>
                                <div class="row" >
                                    <div class="6u 12u(mobilep)">
                                        <section class="box special">
                                            <div class="image featured"><img src="<%=producto.getFOTO()%>" alt="Muebles Tradicionales" /></div>
                                        </section>
                                    </div>
                                    <div class="6u 12u(mobilep)">
                                        <section class="box" >
                                            <h2><% out.write(idioma.getProperty("Detalles"));%></h2>
                                            <h3><%=producto.getDESCRIPCION()%></h3>      
                                            <h4><% out.write(idioma.getProperty("TIPO"));%> <%= producto.getTIPO()%></h4>
                                            <h4><% out.write(idioma.getProperty("ALTO:"));%> <%= producto.getALTO()%></h4>
                                            <h4><% out.write(idioma.getProperty("ANCHO"));%> <%= producto.getANCHO()%></h4>
                                            <h4><% out.write(idioma.getProperty("PROFUNDIDAD"));%> <%= producto.getPROFUNDIDAD()%></h4>
                                            <h4><% out.write(idioma.getProperty("COLOR"));%> <%= producto.getCOLOR()%></h4>
                                            <h4><% out.write(idioma.getProperty("CONDICI�N"));%> <%= producto.getESTADO()%></h4>
                                            <form method="post" action="agregarproducto">
                                                <h2><% out.write(idioma.getProperty("VALORMONEDA"));%> <%= producto.getPRECIOVENTA()%></h2>
                                                <h4><% out.write(idioma.getProperty("CantidadalCarrito"));%></h4>
                                                <div class="3u">
                                                    <input type="hidden" value="<%= producto.getID_PRODUCTO()%>" name="idproducto">
                                                    <input type="text" value="" id="txt-cantidad" name="cantidad" onkeypress="return valida(event)"/>
                                                </div>
                                                <button type="submit" >
                                                    <i class="fa fa-shopping-cart"></i>
                                                    AGREGAR
                                                </button>
                                            </form>
                                        </section>
                                    </div>                       
                                </div>
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
                            <li>&copy; <% out.write(idioma.getProperty("TodoslosDerechosReservados"));%></li><li><% out.write(idioma.getProperty("Dise�adopor"));%> <a href="https://www.facebook.com/panta.medrano">Panta Medrano</a></li>
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