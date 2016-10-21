<%-- 
    Document   : productosCarrito
    Created on : 9/10/2016, 08:45:11 PM
    Author     : panle
--%>
<%@page import="ClasesGenericas.Cliente"%>
<%@page import="modelo.OperacionesCliente"%>
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
    //ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
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
    if (request.getParameter("Operacion") != null) {
        opera = Integer.parseInt(request.getParameter("Operacion"));
    }

    String datoBuscar = "";
    if (request.getParameter("datoBuscar") != null) {
        datoBuscar = request.getParameter("datoBuscar").toString();
    }

    String campoFiltro = "";
    if (request.getParameter("campoFiltro") != null) {
        campoFiltro = request.getParameter("campoFiltro").toString();
    }
    // controladorProducto cp = new controladorProducto();
    OperacionesCliente oC = new OperacionesCliente();
    System.out.println("Operacion: " + opera);
    System.out.println("datoBuscar: " + datoBuscar);
    System.out.println("campoFiltro: " + campoFiltro);
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
    <body >
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
            <section id="main" class="container">
                <section class="box special">
                    <header class="major">
                        <h2>REPORTERIA</h2>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                    </header>                
                </section>

                <div class="row">
                    <%//VER CLIENTES = 1
                        if (opera == 1) {
                    %>
                    <!-- **** REPORTE 1, CLIENTES POR CIUDAD, NOMBRE, NIT **** -->
                    <div class="12u" id ="verClientes">
                        <section class="box" >
                            <header class="major">
                                <h2>REPORTE CLIENTES</h2>
                            </header>
                            <form method="POST" action="reporteria.jsp?Operacion=1#verClientes">
                                <div class="row uniform 50%">
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <select  id="CampoFiltro" name="campoFiltro" >
                                                <option value="" disabled selected hidden>Buscar Cliente por:</option>
                                                <option value="NOMBRE">Nombre</option>
                                                <option value="APELLIDO">Apellido</option>
                                                <option value="CIUDAD">Ciudad</option>
                                                <option value="NIT">Nit</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="datoBuscar" id="datoBuscar" value="" placeholder="Que coincida con..." />
                                    </div>
                                    <ul class="actions">
                                        <li><input type="submit" name ="Buscar" value="Buscar" /></li>
                                    </ul>
                                </div>
                            </form>
                            <%
                                ArrayList<Cliente> clientes = null;
                                int conta = 0;
                                if (!campoFiltro.equals("") && !datoBuscar.equals("")) {
                                    clientes = oC.mostrarDatosClienteReporte(campoFiltro, datoBuscar);
                                    if (clientes != null && clientes.size() != 0) {
                            %>
                            <div class="table-wrapper">
                                <table class="actions">
                                    <thead>
                                        <tr>
                                            <th>NOMBRE COMPLETO</th>
                                            <th>USUARIO</th>
                                            <th>NIT</th>
                                            <th>NO DOCUMENTO</th>
                                            <th>PROFESION</th>
                                            <th>TELÉFONO CELULAR</th>
                                            <th>TELÉFONO RESIDENCIA</th>
                                            <th>DIRECCIÓN</th>
                                            <th>CIUDAD</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            while (conta < clientes.size()) {
                                        %>                               
                                        <tr>
                                            <td><%out.write(clientes.get(conta).getNOMBRE() + " " + clientes.get(conta).getAPELLIDO());%></td>
                                            <td><%out.write(clientes.get(conta).getUSUARIO());%></td>
                                            <td><%out.write(clientes.get(conta).getNIT());%></td>
                                            <td><%out.write(clientes.get(conta).getNUMERO_DOC());%></td>
                                            <td><%out.write(clientes.get(conta).getPROFESION());%></td>
                                            <td><%out.write(clientes.get(conta).getTEL_CEL());%></td>
                                            <td><%out.write(clientes.get(conta).getTEL_RESIDENCIA());%></td>
                                            <td><%out.write(clientes.get(conta).getDIRECCION());%></td>
                                            <td><%out.write(clientes.get(conta).getCIUDAD());%></td>
                                        </tr>
                                        <%
                                                conta++;
                                            };
                                        %>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="3"> 
                                                <%out.write("Se encontraron: " + conta + " coincidencias");
                                                        } else {
                                                            out.write(" <p> &nbsp</p> <h3>No se encontraron resultados</h3>");

                                                        }
                                                    }%>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table> 
                            </div>
                            &nbsp;
                        </section>
                    </div>
                    <!-- FIN REPORTE 1 -->
                    <% } else if(opera ==2) {%>
                   <!-- **** REPORTE 2, PRODUCTOS**** -->
                    <div class="12u" id ="verClientes">
                        <section class="box" >
                            <header class="major">
                                <h2>REPORTE CLIENTES</h2>
                            </header>
                            <form method="POST" action="reporteria.jsp?Operacion=1#verClientes">
                                <div class="row uniform 50%">
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <select  id="CampoFiltro" name="campoFiltro" >
                                                <option value="" disabled selected hidden>Buscar Cliente por:</option>
                                                <option value="NOMBRE">Nombre</option>
                                                <option value="APELLIDO">Apellido</option>
                                                <option value="CIUDAD">Ciudad</option>
                                                <option value="NIT">Nit</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="datoBuscar" id="datoBuscar" value="" placeholder="Que coincida con..." />
                                    </div>
                                    <ul class="actions">
                                        <li><input type="submit" name ="Buscar" value="Buscar" /></li>
                                    </ul>
                                </div>
                            </form>
                            <%
                                ArrayList<Cliente> clientes = null;
                                int conta = 0;
                                if (!campoFiltro.equals("") && !datoBuscar.equals("")) {
                                    clientes = oC.mostrarDatosClienteReporte(campoFiltro, datoBuscar);
                                    if (clientes != null && clientes.size() != 0) {
                            %>
                            <div class="table-wrapper">
                                <table class="actions">
                                    <thead>
                                        <tr>
                                            <th>NOMBRE COMPLETO</th>
                                            <th>USUARIO</th>
                                            <th>NIT</th>
                                            <th>NO DOCUMENTO</th>
                                            <th>PROFESION</th>
                                            <th>TELÉFONO CELULAR</th>
                                            <th>TELÉFONO RESIDENCIA</th>
                                            <th>DIRECCIÓN</th>
                                            <th>CIUDAD</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            while (conta < clientes.size()) {
                                        %>                               
                                        <tr>
                                            <td><%out.write(clientes.get(conta).getNOMBRE() + " " + clientes.get(conta).getAPELLIDO());%></td>
                                            <td><%out.write(clientes.get(conta).getUSUARIO());%></td>
                                            <td><%out.write(clientes.get(conta).getNIT());%></td>
                                            <td><%out.write(clientes.get(conta).getNUMERO_DOC());%></td>
                                            <td><%out.write(clientes.get(conta).getPROFESION());%></td>
                                            <td><%out.write(clientes.get(conta).getTEL_CEL());%></td>
                                            <td><%out.write(clientes.get(conta).getTEL_RESIDENCIA());%></td>
                                            <td><%out.write(clientes.get(conta).getDIRECCION());%></td>
                                            <td><%out.write(clientes.get(conta).getCIUDAD());%></td>
                                        </tr>
                                        <%
                                                conta++;
                                            };
                                        %>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="3"> 
                                                <%out.write("Se encontraron: " + conta + " coincidencias");
                                                        } else {
                                                            out.write(" <p> &nbsp</p> <h3>No se encontraron resultados</h3>");

                                                        }
                                                    }%>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table> 
                            </div>
                            &nbsp;
                        </section>
                    </div>
                    <!-- FIN REPORTE 2 -->
                     <%}else {%>
                    <div class="12u">  
                        <section class="box" >
                            <h4>No hay Articulos en el carrito &nbsp;
                                <img  src="images/404.png" alt=" Sin Muebles"  width="25" height="21" />
                            </h4>
                        </section> 
                    </div>
                    <%}%>
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
