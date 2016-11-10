<%-- 
    Document   : productosCarrito
    Created on : 9/10/2016, 08:45:11 PM
    Author     : panle
--%>
<%@page import="java.util.Calendar"%>
<%@page import="modelo.Utileria"%>
<%@page import="modelo.Idioma"%>
<%@page import="ClasesGenericas.Producto"%>
<%@page import="ClasesGenericas.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Controlador.controladorProducto"%>
<%@page import="Controlador.EliminarProductoCarrito"%>
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

    Calendar now = Calendar.getInstance();
    String tmpTxt = "";

    String noVenta = "";
    if (sesion.getAttribute("NoInventario") != null) {
        noVenta = sesion.getAttribute("NoInventario").toString();
    }
    // controladorProducto cp = new controladorProducto();
%>
<!DOCTYPE html>
<html>
    <head>
        <title><% out.write(idioma.getProperty("mueblierialosalpes"));%></title>
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

            function Error_Cargar() {
                window.event.srcElement.style.display = "None";
            }
        </script>
    </head>
    <body class="landing" oncontextmenu='return false'>
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
                            <a  class= "button special" ><% out.write(idioma.getProperty("usuario"));%><%=usuario%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito" OnError="Error_Cargar()"> </a>
                            <ul> 
                                <li> <a href="modificaCliente.jsp#main" class ="actions"><% out.write(idioma.getProperty("ModificarmisDatos"));%></a> </li>
                                <li> <a href="logout.jsp" class ="actions"><% out.write(idioma.getProperty("CerrarSesión"));%></a> </li>
                            </ul>
                        </li>
                        <%} else {%>
                        <li>
                            <a href="#" class= "icon fa-angle-down"><% out.write(idioma.getProperty("IngresaroRegistrarse"));%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito" OnError="Error_Cargar()"> </a>
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
            </section>
            <!-- Main -->
            <section class="container" id="main">
                <section class="box special">
                    <header class="major">
                        <h2><% out.write(idioma.getProperty("ORDENyPAGODECOMPRA"));%></h2>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" onerror="Error_Cargar()"/></span>
                    </header>                
                </section>
                <!-- Tabla Productos del Carrito -->
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
                                            <th><h4><% out.write(idioma.getProperty("Cantidad"));%></h4></th>
                                            <th><% out.write(idioma.getProperty("Foto"));%></th>
                                            <th><% out.write(idioma.getProperty("Descripcion"));%></th>
                                            <th><% out.write(idioma.getProperty("PrecioU"));%></th>
                                            <th><% out.write(idioma.getProperty("Subtotal"));%></th>
                                            <th><% out.write(idioma.getProperty("Eliminar"));%></th>
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
                                                    <img src="<%= producto.getFOTO()%>" alt="foto" width="80" height="80" onerror="Error_Cargar()"> 
                                                </div>
                                            </td>
                                            <td><%= producto.getNOMBRE()%></td>
                                            <td><% out.write(idioma.getProperty("VALORMONEDA"));%> <%= algo.convertirCantidad(producto.getPRECIOVENTA())%></td>
                                            <td class="cart_total">
                                                <p class="cart_total_price"><% out.write(idioma.getProperty("VALORMONEDA"));%> <%= algo.convertirCantidad(Math.round(producto.getPRECIOVENTA() * a.getCantidad() * 100.0) / 100.0)%></p>
                                            </td>
                                            <td class="cart_delete">
                                                <form method="post" action="EliminarProductoCarrito">
                                                    <input type="hidden" value="<%= producto.getID_PRODUCTO()%>" name="idproducto">
                                                    <input type="hidden" value="<%= a.getCantidad()%>" name="cantidad">
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
                                            <td><h3><% out.write(idioma.getProperty("VALORMONEDA"));%> <%=algo.convertirCantidad(total)%></h3></td>
                                        </tr>
                                    </tfoot>
                                </table>
                                <% } else {%>
                                <h4><% out.write(idioma.getProperty("NohayArticulos"));%> &nbsp;
                                    <img  src="images/404.png" alt=" Sin Muebles"  width="25" height="21" OnError="Error_Cargar()" /></h4> 
                                    <%}%>
                                &nbsp;
                            </div>
                            <div class="row" >  
                                <div class="4u 12u(narrow)">
                                    <a class ="button" href="index.jsp#catalogo">
                                        <!--                                <a class ="button special" href="#pagotarjeta" onclick="mostrar()">-->
                                        <% out.write(idioma.getProperty("SeguirComprando"));%> &nbsp; <img src="images/ICONOS BLANCOS/FACTURA.png" width="25" height="21" alt ="FAC" onerror="Error_Cargar()" > 
                                    </a>
                                </div>
                                <div class="4u 12u(narrow)">
                                    <p></p>
                                </div> 
                                <%if (articulos != null && articulos.size() > 0 && (nivel.equals("2") || nivel.equals("1"))) {
                                        //if (articulos != null && articulos.size() > 0) {%>
                                <div class="4u 12u(mobile2p)">
                                    <a class ="button special" href="#pagotarjeta" onclick="mostrar()">
                                        <% out.write(idioma.getProperty("TerminarCompra"));%>  &nbsp; <img src="images/ICONOS/TARJETA.png" width="25" height="21" alt ="TAR" OnError="Error_Cargar()">  
                                    </a>
                                </div>
                                <%} else if (articulos != null && articulos.size() > 0) {%>
                                <div class="4u 12u(mobilep)">
                                    <a class ="button special" href="#OrdenCompra" onclick="mostrarNoLogueado()">
                                        <% out.write(idioma.getProperty("TerminarCompra"));%> &nbsp; <img src="images/ICONOS/TARJETA.png" width="25" height="21" alt ="TAR" OnError="Error_Cargar()"> 
                                    </a>
                                    <div class="row" style ='display:none' id ="NoLogueado">
                                        <a href="login.jsp#main">  <h5 style ='color:red; font-weight:bold;' ><% out.write(idioma.getProperty("Debeestarlogueado"));%> &nbsp; </h5></a>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                            <%if (!noVenta.contains("PRODUCTO") && !noVenta.equals("")) {
                                sesion.setAttribute("NoInventario", null);%>
                            <div  id="noAlcanzaInventario">
                                <a href="#main">  <h3 style ='color:red;' ><% out.write(noVenta);//out.write(idioma.getProperty("NoInventario"));%> &nbsp; </h3></a>
                            </div>
                            <%}%>
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
                                    <h2 style ='font-weight:bold;' ><% out.write(idioma.getProperty("PagoconTarjeta"));%></h2>
                                    <a class ="actions">
                                        <img src="images/ICONOS/formas.png" alt = "Formas de Pago" OnError="Error_Cargar()"/>
                                    </a>
                                </header>
                                <form  id="formularioPago" method="post" action="pagarCompra" autocomplete="off">
                                    <h4 class="actions"><% out.write(idioma.getProperty("Completesutransacción"));%></h4>
                                    <h4 style ='color:blue; font-weight:bold;' >(<% out.write(idioma.getProperty("VerifiquesusDatos"));%>)</h4>
                                    <a class ="actions">
                                        <img src="images/ICONOS/lap.png" alt = "lap" width="25" height ="25" OnError="Error_Cargar()"/>
                                    </a>
                                    <p></br></p>
                                    <div class="12u(mobilep)">
                                        <h1><% out.write(idioma.getProperty("Nombredeltitulardelatarjeta"));%>:</h1>
                                        <input  type="text"  name="name_titular" value="" autocomplete="off">
                                    </div>
                                    <hr />
                                    <div class="12u(mobilep)">
                                        <h1><% out.write(idioma.getProperty("Númerotarjetabancaria"));%>:</h1>
                                        <input name="card-number"   placeholder="---- ---- ---- ----" type="text" value =" " maxlength="16" onkeypress="return valida(event)"  autocomplete="off">
                                    </div>
                                    <div class="12u(mobilep)">
                                        <h1><% out.write(idioma.getProperty("Banco"));%>:</h1>
                                        <div class="select-wrapper">
                                            <select  id="Banco"  >
                                                <option value="" disabled selected hidden><% out.write(idioma.getProperty("Bancos"));%></option>
                                                <option value="1"><% out.write(idioma.getProperty("Banrural"));%></option>
                                                <option value="2"><% out.write(idioma.getProperty("BancoIndustrial"));%></option>
                                                <option value="3"><% out.write(idioma.getProperty("BancoGTContinental"));%></option>
                                                <option value="4"><% out.write(idioma.getProperty("Otros"));%></option>
                                            </select>
                                        </div>
                                    </div>
                                    <hr />
                                    <h1><% out.write(idioma.getProperty("FechaCaducidad"));%>: </h1>
                                    <div class="row uniform 50%">
                                        <div class="6u 12u(mobilep)">
                                            <div class="select-wrapper">
                                                <select  id="cb-card-expiration-month"  >
                                                    <option value="" disabled selected hidden><% out.write(idioma.getProperty("Mes"));%></option>
                                                    <option value="01"><% out.write(idioma.getProperty("Enero"));%></option>
                                                    <option value="02"><% out.write(idioma.getProperty("Febrero"));%></option>
                                                    <option value="03"><% out.write(idioma.getProperty("Marzo"));%></option>
                                                    <option value="04"><% out.write(idioma.getProperty("Abril"));%></option>
                                                    <option value="05"><% out.write(idioma.getProperty("Mayo"));%></option>
                                                    <option value="06"><% out.write(idioma.getProperty("Junio"));%></option>
                                                    <option value="07"><% out.write(idioma.getProperty("Julio"));%></option>
                                                    <option value="08"><% out.write(idioma.getProperty("Agosto"));%></option>
                                                    <option value="09"><% out.write(idioma.getProperty("Septiembre"));%></option>
                                                    <option value="10"><% out.write(idioma.getProperty("Octubre"));%></option>
                                                    <option value="11"><% out.write(idioma.getProperty("Noviembre"));%></option>
                                                    <option value="12"><% out.write(idioma.getProperty("Diciembre"));%></option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="6u 12u(mobilep)">
                                            <div class="select-wrapper">
                                                <select id="cb-card-expiration-year" >
                                                    <option value="" disabled selected hidden><% out.write(idioma.getProperty("anio"));%></option>
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
                                    <h1><% out.write(idioma.getProperty("Codigo"));%></h1>
                                    <div class="row uniform 50%">
                                        <div class="6u 12u(mobilep)">
                                            <input name="pas-card" type ="password" placeholder="••••" maxlength="4" onkeypress="return valida(event)" autocomplete="off"  >
                                            <div class="form-tipsy tipsy-trigger">
                                                <div class="popover popover-right">
                                                    <div  class="popover-body">
                                                        <% out.write(idioma.getProperty("Tucódigodeseguridad"));%>
                                                    </div>
                                                </div> 
                                            </div>
                                        </div>
                                        <div class="6u 12u(mobilep)">
                                            <div class="select-wrapper">
                                                <select  id="Tarjeta"  >
                                                    <option value="" disabled selected hidden><% out.write(idioma.getProperty("TipoTarjeta"));%></option>
                                                    <option value="1">Visa</option>
                                                    <option value="2">MasterCard</option>
                                                    <option value="3"><% out.write(idioma.getProperty("Otros"));%></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="12u(mobilep)">
                                        <div class="row" style ='display:none'  id ="mensajeError">
                                            <h3 style='color:red; font-weight:bold;' > ----> <% out.write(idioma.getProperty("ErrorTransaccion"));%> <-----</h3>
                                        </div>
                                        <h4 style='color:blue; font-weight:bold;'><% out.write(idioma.getProperty("TotalCompra"));%> <% out.write(idioma.getProperty("VALORMONEDA"));%><%=algo.convertirCantidad(total)%></h4>
                                        <h4 style='color:blue; font-weight:bold;'><% out.write(idioma.getProperty("Envio"));%> <% out.write(idioma.getProperty("VALORMONEDA"));%> 50.00</h4>
                                        <h4 style='color:red; font-weight:bold;' >Total: <% out.write(idioma.getProperty("VALORMONEDA"));%><%=algo.convertirCantidad(total + 50)%></h4>
                                    </div>
                                    <button class="button" id="EnviarPago" type="submit">
                                        <span class="label"><% out.write(idioma.getProperty("EFECTUARPAGO"));%></span>
                                    </button>
                                    <%
                                        int dia_i = now.get(Calendar.DATE);
                                        String dia = "" + dia_i;
                                        if (dia.length() == 1) {
                                            dia = "0" + dia;
                                        }
                                        tmpTxt += dia + "/";
                                        int mes_i = now.get(Calendar.MONTH) + 1;

                                        String mes = "" + mes_i;
                                        if (mes.length() == 1) {
                                            mes = "0" + mes;
                                        }
                                        tmpTxt += mes + "/";
                                        tmpTxt = tmpTxt + now.get(Calendar.YEAR) + " ";

                                        tmpTxt = tmpTxt + now.get(Calendar.HOUR_OF_DAY) + ":";
                                        tmpTxt = tmpTxt + now.get(Calendar.MINUTE) + ":";
                                        tmpTxt = tmpTxt + now.get(Calendar.SECOND);
                                        // System.out.println("Dia, hora : " + tmpTxt);
                                    %>
                                    <input type="hidden" id="FechahoraTransaction"  value=<%=tmpTxt%>/>
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
                    <li>&copy; <% out.write(idioma.getProperty("TodoslosDerechosReservados"));%></li><li><% out.write(idioma.getProperty("Diseñadopor"));%> <a href="#">Panta Medrano</a></li>
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