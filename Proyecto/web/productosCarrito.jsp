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
        <link rel="stylesheet" href="assets/css/main.css" />
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
            $('input,form').attr('autocomplete', 'off');
        </script>
    </head>
    <body class="landing" oncontextmenu='return false'>
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
                        <h2>ORDEN   Y PAGO DE COMPRA</h2>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                    </header>                
                </section>
                <!-- Tabla Productos del Carrito -->
                <!--<div class="12u 20u(narrower)" id ="OrdenCompra">-->
                <div class="row" id ="OrdenCompra">
                    <div class="12u">
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
                                    <a class ="button" href="index.jsp#catalogo">
                                        <!--                                <a class ="button special" href="#pagotarjeta" onclick="mostrar()">-->
                                        Seguir Comprando &nbsp; <img src="images/ICONOS BLANCOS/FACTURA.png" width="25" height="21" alt ="FAC"> 
                                    </a>
                                </div>
                                <div class="4u 12u(narrow)">
                                    <p></p>
                                </div> 
                                <%if (articulos != null && articulos.size() > 0 && (nivel.equals("2") || nivel.equals("1"))) {%>
                                <div class="4u 12u(mobile2p)">
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
                                        <a href="login.jsp#main">  <h5 style ='color:red; font-weight:bold;' > Debe estar logueado para completar la transacción)</h5></a>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </section>
                    </div>
                </div>
                <!-- Formulario de Pago -->
                <div class="12u 20u(narrower)" id="pagotarjeta" style='display:none'>
                    <!-- Form -->
                    <div class="row">
                        <div class="12u">
                            <section class="box">
                                <header class="major">
                                    <h2 style ='font-weight:bold;' >Pago con Tarjeta de Débito o Crédito</h2>
                                    <a class ="actions">
                                        <img src="images/ICONOS/formas-de-pago.png" alt = "Formas de Pago"/>
                                    </a>
                                </header>
                                <form  id="formularioPago" method="post" action="pagarform" autocomplete="off">
                                    <h4 class="actions">Complete su transacción, llenando los datos de su tarjeta.</h4>
                                    <h4 style ='color:blue; font-weight:bold;' >(Verifique sus datos, antes de pagar)</h4>
                                    <p></br></p>
                                    <div class="12u(mobilep)">
                                        <h1>Nombre del titular de la tarjeta</h1>
                                        <input  type="text"  name="name_titular" value="" autocomplete="off">
                                    </div>
                                    <hr />
                                    <div class="12u(mobilep)">
                                        <h1>Número tarjeta bancaria</h1>
                                        <input name="card-number"   placeholder="---- ---- ---- ----" type="text" value =" " maxlength="16" onkeypress="return valida(event)"  autocomplete="off">
                                    </div>
                                    <hr />
                                    <h1>Fecha de caducidad</h1>
                                    <div class="row uniform 50%">
                                        <div class="6u 12u(mobilep)">
                                            <div class="select-wrapper">
                                                <select  id="cb-card-expiration-month"  >
                                                    <option value="" disabled selected hidden>Mes</option>
                                                    <option value="01">01 - Enero</option>
                                                    <option value="02">02 - Febrero</option>
                                                    <option value="03">03 - Marzo</option>
                                                    <option value="04">04 - Abril</option>
                                                    <option value="05">05 - Mayo</option>
                                                    <option value="06">06 - Junio</option>
                                                    <option value="07">07 - Julio</option>
                                                    <option value="08">08 - Agosto</option>
                                                    <option value="09">09 - Septiembre</option>
                                                    <option value="10">10 - Octubre</option>
                                                    <option value="11">11 - Noviembre</option>
                                                    <option value="12">12 - Diciembre</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="6u 12u(mobilep)">
                                            <div class="select-wrapper">
                                                <select id="cb-card-expiration-year" >
                                                    <option value="" disabled selected hidden>Año</option>
                                                    <option value="2016">2016</option>
                                                    <option value="2017">2017</option>
                                                    <option value="2018">2018</option>
                                                    <option value="2019">2019</option>
                                                    <option value="2020">2020</option>
                                                    <option value="2021">2021</option>
                                                    <option value="2022">2022</option>
                                                    <option value="2023">2023</option>
                                                    <option value="2024">2024</option>
                                                    <option value="2025">2025</option>
                                                    <option value="2026">2026</option>
                                                    <option value="2027">2027</option>
                                                    <option value="2028">2028</option>
                                                    <option value="2029">2029</option>
                                                    <option value="2030">2030</option>
                                                    <option value="2031">2031</option>
                                                    <option value="2032">2032</option>
                                                    <option value="2033">2033</option>
                                                    <option value="2034">2034</option>
                                                    <option value="2035">2035</option>
                                                    <option value="2036">2036</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <h1>Código de seguridad</h1>
                                    <div class="row uniform 50%">
                                        <div class="6u 12u(mobilep)">
                                            <input name="pas-card" type ="password" placeholder="••••" maxlength="4" onkeypress="return valida(event)" autocomplete="off"  >
                                            <div class="form-tipsy tipsy-trigger">
                                                <div class="popover popover-right">
                                                    <div  class="popover-body">
                                                        Tu código de seguridad de 4 dígitos está situado en la parte de arriba de tu tarjeta.
                                                    </div>
                                                </div> 
                                            </div>
                                        </div>
                                        <div class="6u 12u(mobilep)">
                                            <div class="select-wrapper">
                                                <select  id="Tarjeta"  >
                                                    <option value="" disabled selected hidden>Tipo Tarjeta</option>
                                                    <option value="1">Visa</option>
                                                    <option value="2">MasterCard</option>
                                                    <option value="3">Otros</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="12u(mobilep)">
                                        <div class="row" style ='display:none'  id ="mensajeError">
                                            <h3 style='color:red; font-weight:bold;' > ----> Error, al efectuar transaccion <-----</h3>
                                        </div>
                                        <h4 style='color:blue; font-weight:bold;'>Total Compra: Q.<%=algo.convertirCantidad(total)%></h4>
                                        <h4 style='color:blue; font-weight:bold;'>Envio: Q.50.00</h4>
                                        <h4 style='color:red; font-weight:bold;' >Total: Q.<%=algo.convertirCantidad(total + 50)%></h4>
                                    </div>
                                    <button class="button" id="EnviarPago" type="submit">
                                        <span class="label">EFECTUAR PAGO</span>
                                    </button>	
                                    <input type="hidden" id="horaTransaction"  value="2016-10-17T04:37:32+02:00"/>
                                </form>
                            </section>
                        </div>
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