<%-- 
    Document   : nuevoCliente
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="ClasesGenericas.Cliente"%>
<%@page import="ClasesGenericas.Producto"%>
<%@page import="modelo.OperacionesProducto"%>
<%@page import="modelo.Idioma"%>
<%@page import="modelo.OperacionesCliente"%>
<%@page import="ClasesGenericas.Producto"%>
<%@page import="ClasesGenericas.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Controlador.controladorProducto"%>
<%@page import="Controlador.controladorCliente"%>
<%@page import="Controlador.EliminarProductoCarrito"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    if (sesion.getAttribute("resOper") != null) {
        resOper = sesion.getAttribute("resOper").toString();
    }

    int opera = 0;
    if (request.getParameter("Operacion") != null) {
        opera = Integer.parseInt(request.getParameter("Operacion"));
    }

    int idProd = 0;
    if (request.getParameter("idProd") != null) {
        idProd = Integer.parseInt(request.getParameter("idProd"));
    }

    String datoBuscar = "";
    if (request.getParameter("datoBuscar") != null) {
        datoBuscar = request.getParameter("datoBuscar").toString();
    }

    String campoFiltro = "";
    if (request.getParameter("campoFiltro") != null) {
        campoFiltro = request.getParameter("campoFiltro").toString();
    }

    if (nivel.equals("3") || nivel.equals("4") || nivel == "") {
        response.sendRedirect("index.jsp#main");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title><% out.write(idioma.getProperty("Mantenimientos"));%></title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico "/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/main.css" />
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
//            previene = function () {
//                window.stop;
//                history.go(1);
//            };
//            window.back = previene();
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
            <section id="banner" class ="box special">
                <img class="image featured" src="images/logo.png" alt="log" onerror="Error_Cargar()"/>
                <p><% out.write(idioma.getProperty("Sirviendolecon"));%></p>
            </section>
            <!-- Main -->
            <section id="main" class="container">
                <section class="box special">
                    <header class="major">
                        <h2>MANTENIMIENTOS</h2>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" onerror="Error_Cargar()"/></span>
                    </header>                
                </section>
                <div class="row">
                    <div class="12u">
                        <!-- Form Nuevo PRODUCTO -->
                        <%//VER Nuevo PRODUCTO  = 1
                            if (opera == 1) {
                        %>
                        <section class="box" id = "nuevoProducto">
                            <h2>NUEVO PRODUCTO</h2>
                            <h3>Ingrese los siguientes Datos</h3>
                            <form method="post" action="controladorProducto">
                                <div class="row uniform 50%">
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_REFERENCIA" id="in_REFERENCIA" value="" placeholder="Referencia" />
                                    </div>                               
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_NOMBRE" id="in_NOMBRE" value="" placeholder="<%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_DESCRIPCION" id="in_DESCRIPCION" value="" placeholder="Descripcion"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <select  name="in_TIPO" id="in_TIPO" >
                                                <option value="" disabled selected hidden>-Categoria-</option>
                                                <option value="Tradicionales">Tradicionales</option>
                                                <option value="Modernos">Modernos</option>
                                                <option value="Coloniales">Coloniales</option>
                                                <option value="Rusticos">Rusticos</option>
                                            </select>
                                        </div>
                                    </div> 
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_MATERIAL" id="in_MATERIAL" value="" placeholder="MATERIAL" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_ALTO" id="in_ALTO" value="" placeholder="ALTO"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_ANCHO" id="in_ANCHO" value="" placeholder="ANCHO" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_PROFUNDIDAD" id="in_PROFUNDIDAD" value="" placeholder="PROFUNDIDAD"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_COLOR" id="in_COLOR" value="" placeholder="COLOR" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_PESO" id="in_PESO" value="" placeholder="PESO"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="in_FOTO" id="in_FOTO" value="" placeholder="FOTO" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="ESTADO" id="ESTADO" value="" placeholder="ESTADO"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="PRECIOVENTA" id="PRECIOVENTA" value="" placeholder="PRECIOVENTA" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <ul class="actions">
                                            <li> <br></br></li>
                                        </ul>                                    
                                    </div>
                                    <div class="row uniform " id = "ResultadoNuevoProducto">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li><input type="submit" name ="EnviarNP" value="<% out.write(idioma.getProperty("Enviar"));%> " /></li>
                                            </ul>
                                        </div>
                                        <%
                                            if (sesion.getAttribute("resOper") != null) {
                                                out.write((String) sesion.getAttribute("resOper"));
                                                sesion.setAttribute("resOper", null);
                                            }
                                        %>
                                    </div>
                                </div>
                            </form>
                        </section>
                        <%
                            }
                        %>
                        <!-- FIN NUEVO PRODUCTO-->
                        <!-- Form Modificar PRODUCTO -->
                        <%//VER  Modificar PRODUCTO  = 2
                            if (opera == 2) {
                                Producto prodMostrar = null;
                                OperacionesProducto oP = new OperacionesProducto();
                                prodMostrar = oP.getProducto(idProd);
                        %>
                        <section class="box" id = "updateProductos">
                            <h2>MANTENIMIENTO PRODUCTOS</h2>
                            <h3>Modifique los datos que considere:</h3>
                            <form method="post" action="controladorProducto">
                                <div class="row uniform 50%">
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("Referencia"));%>: </h1>
                                        <input type="text" name="in_REFERENCIA" id="in_REFERENCIA"  value="<%out.write(prodMostrar.getREFERENCIA());%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("nombre"));%>: </h1>
                                        <input type="text" name="in_NOMBRE" id="in_NOMBRE" value="<%out.write(prodMostrar.getNOMBRE());%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("Descripcion"));%>: </h1>
                                        <input type="text" name="in_DESCRIPCION" id="in_DESCRIPCION"  value ="<%out.write(prodMostrar.getDESCRIPCION());%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <h1><%out.write(idioma.getProperty("TIPO"));%>: </h1>
                                            <select  name="in_TIPO" id="in_TIPO" >

                                                <%if (prodMostrar.getTIPO() != null) {
                                                        if (prodMostrar.getTIPO().toLowerCase().contains("tradicionales") || prodMostrar.getTIPO().toLowerCase().contains("traditional")) {%>
                                                <option value="<%out.write(prodMostrar.getTIPO());%>" selected ><%out.write(prodMostrar.getTIPO());%></option>
                                                <option value="Modernos"><% out.write(idioma.getProperty("Modernos"));%></option>
                                                <option value="Coloniales"><% out.write(idioma.getProperty("Coloniales"));%></option>
                                                <option value="Rusticos"><% out.write(idioma.getProperty("Rusticos"));%></option>

                                                <%}%>
                                                <%if (prodMostrar.getTIPO().toLowerCase().contains("modernos") || prodMostrar.getTIPO().toLowerCase().contains("modern")) {%>
                                                <option value="<%out.write(prodMostrar.getTIPO());%>" selected ><%out.write(prodMostrar.getTIPO());%></option>
                                                <option value="Tradicionales"><% out.write(idioma.getProperty("Tradicionales"));%></option>
                                                <option value="Coloniales"><% out.write(idioma.getProperty("Coloniales"));%></option>
                                                <option value="Rusticos"><% out.write(idioma.getProperty("Rusticos"));%></option>

                                                <%}%>
                                                <%if (prodMostrar.getTIPO().toLowerCase().contains("coloniales") || prodMostrar.getTIPO().toLowerCase().contains("colonial")) {%>
                                                <option value="<%out.write(prodMostrar.getTIPO());%>" selected ><%out.write(prodMostrar.getTIPO());%></option>
                                                <option value="Tradicionales"><% out.write(idioma.getProperty("Tradicionales"));%></option>
                                                <option value="Modernos"><% out.write(idioma.getProperty("Modernos"));%></option>
                                                <option value="Rusticos"><% out.write(idioma.getProperty("Rusticos"));%></option>

                                                <%}
                                                    if (prodMostrar.getTIPO().toLowerCase().contains("rusticos") || prodMostrar.getTIPO().toLowerCase().contains("rustic")) {%>
                                                <option value="<%out.write(prodMostrar.getTIPO());%>" selected ><%out.write(prodMostrar.getTIPO());%></option>
                                                <option value="Tradicionales"><% out.write(idioma.getProperty("Tradicionales"));%></option>
                                                <option value="Modernos"><% out.write(idioma.getProperty("Modernos"));%></option>
                                                <option value="Coloniales"><% out.write(idioma.getProperty("Coloniales"));%></option>
                                                <%}
                                                } else {%>
                                                <option  disabled  hidden>-<% out.write(idioma.getProperty("Categoria"));%>-</option>
                                                <option value="Tradicionales"><% out.write(idioma.getProperty("Tradicionales"));%></option>
                                                <option value="Modernos"><% out.write(idioma.getProperty("Modernos"));%></option>
                                                <option value="Coloniales"><% out.write(idioma.getProperty("Coloniales"));%></option>
                                                <option value="Rusticos"><% out.write(idioma.getProperty("Rusticos"));%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("Material"));%>: </h1>
                                        <input type="text" name="in_MATERIAL" id="in_MATERIAL"  value ="<%out.write(prodMostrar.getMATERIAL());%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("ALTO"));%>: </h1>
                                        <input type="text" name="in_ALTO" id="in_ALTO"  value ="<%out.write(prodMostrar.getALTO());%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("ANCHO"));%>: </h1>
                                        <input type="text" name="in_ANCHO" id="in_ANCHO"  value ="<%out.write(prodMostrar.getANCHO());%>"/>
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("PROFUNDIDAD"));%>: </h1>
                                        <input type="text" name="in_PROFUNDIDAD" id="in_PROFUNDIDAD" value ="<%out.write(prodMostrar.getPROFUNDIDAD());%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("COLOR"));%>: </h1>
                                        <input type="text" name="in_COLOR" id="in_COLOR"  value ="<%out.write(prodMostrar.getCOLOR());%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("PESO"));%>: </h1>
                                        <input type="text" name="in_PESO" id="in_PESO"  value ="<%out.write(prodMostrar.getPESO());%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("Foto"));%>: </h1>
                                        <input type="text" name="in_FOTO" id="in_FOTO"  value ="<%out.write(prodMostrar.getFOTO());%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("ESTADO"));%>: </h1>
                                        <input type="text" name="ESTADO" id="ESTADO"  value ="<%out.write(prodMostrar.getESTADO());%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <h1><%out.write(idioma.getProperty("PrecioU"));%>: </h1>
                                        <input type="text" name="PRECIOVENTA" id="PRECIOVENTA"  value ="<%out.write(Double.toString(prodMostrar.getPRECIOVENTA()));%>"/>
                                    </div>
                                    <div class="12u">
                                        <ul class="actions">
                                            <li></li>
                                        </ul>                                    
                                    </div>
                                    <div class="row uniform " id = "ResultadoUpdateProducto">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li>
                                                    <input type="hidden" name="idprod" id="idprod" value=<%=prodMostrar.getID_PRODUCTO()%> />
                                                    <input type="submit" name ="EnviarMP" value="<% out.write(idioma.getProperty("Enviar"));%> "  />
                                                </li>
                                            </ul>
                                        </div>
                                        <%
                                            if (sesion.getAttribute("resOper") != null) {
                                                out.write((String) sesion.getAttribute("resOper"));
                                                sesion.setAttribute("resOper", null);
                                            }
                                        %>
                                    </div>
                                </div>
                            </form>
                        </section>
                        <%
                            }
                        %>
                        <!-- Form ELIMINAR PRODUCTO -->
                        <%//VER  ELIMINAR PRODUCTO  = 3
                            if (opera == 3) {
                        %>
                        <div class="12u" id ="eliminaProductos">
                            <section class="box" >
                                <header class="major">
                                    <h2>ELIMINACION PRODUCTOS</h2>
                                    <h3>BUSQUE EL PRODUCTO QUE DESEA DAR DE BAJA</h3>
                                </header>
                                <form method="POST" action="mantenimientosInterfaz.jsp?Operacion=3#eliminaProductos">
                                    <div class="row uniform 50%">
                                        <div class="6u 12u(narrower)">
                                            <div class="select-wrapper">
                                                <select  id="CampoFiltro" name="campoFiltro" >
                                                    <option value="" disabled selected hidden>Buscar Producto por:</option>
                                                    <option value="NOMBRE">Nombre</option>
                                                    <option value="REFERENCIA">Referencia</option>
                                                    <option value="TIPO">Categoria</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <input type="text" name="datoBuscar" id="datoBuscar" value="" placeholder="Que coincida con..." />
                                        </div>
                                        <ul class="actions">
                                            <li><input type="submit" name ="Buscar" value="Buscar"  /></li>
                                        </ul>
                                    </div>
                                </form>
                                <%
                                    ArrayList<Producto> productos = null;
                                    OperacionesProducto oP = new OperacionesProducto();
                                    int conta = 0;
                                    if (!campoFiltro.equals("") && !datoBuscar.equals("")) {
                                        productos = oP.mostrarDatosProductoReporte(campoFiltro, datoBuscar);

                                        if (productos != null && productos.size() != 0) {
                                %>
                                <div class="table-wrapper">
                                    <table class="actions" id="TablaProductos">
                                        <thead>
                                            <tr>
                                                <th>DESCRIPCIÓN PRODUCTO </th>
                                                <th>REFERENCIA </th>
                                                <th>TIPO</th>
                                                <th>ELIMINACION</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%      while (conta < productos.size()) {

                                                    int idProd2 = productos.get(conta).getID_PRODUCTO();
                                                    oP.eliminarProducto(idProd2);
                                            %>                               
                                            <tr>
                                                <td><%out.write(productos.get(conta).getDESCRIPCION());%></td>
                                                <td><%out.write(productos.get(conta).getREFERENCIA());%></td>
                                                <td><%out.write(productos.get(conta).getTIPO());%></td>
                                                <td>
                                                    <form method="POST" action="EliminarProductoCarrito">
                                                        <input type="hidden" name ="prodEli" value="<%= (productos.get(conta).getID_PRODUCTO())%>"  />
                                                        <input type="submit" name ="ELIMINAR" value="ELIMINAR"  />
                                                    </form>
                                                </td>
                                            </tr>
                                            <%
                                                    conta++;
                                                };
                                            %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3">
                                                    <p>&nbsp;</p>
                                                    <%
                                                                out.write("<h3>Se encontraron: " + conta + " coincidencias</h3>");

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
                        <%
                            }
                        %>
                        <!-- FIN ELIMINAR PRODUCTO -->
                        <!-- Form ELIMINAR CLIENTE -->
                        <%//VER  ELIMINAR CLIENTE  = 4
                            if (opera == 4) {
                        %>
                        <div class="12u" id ="eliminaClientes">
                            <section class="box" >
                                <header class="major">
                                    <h2>ELIMINACION CLIENTES</h2>
                                    <h3>BUSQUE EL CLIENTE QUE DESEA DAR DE BAJA</h3>
                                </header>
                                <form method="POST" action="mantenimientosInterfaz.jsp?Operacion=4#eliminaClientes">
                                    <div class="row uniform 50%">
                                        <div class="6u 12u(narrower)">
                                            <div class="select-wrapper">
                                                <select  id="CampoFiltro" name="campoFiltro" >
                                                    <option value="" disabled selected hidden>Buscar Cliente por:</option>
                                                    <option value="NOMBRE">Nombre</option>
                                                    <option value="APELLIDO">Apellido</option>
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
                                    OperacionesCliente oC = new OperacionesCliente();
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
                                                <th>TELÉFONO CELULAR</th>
                                                <th>ELIMINACION</th>
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
                                                <td><%out.write(clientes.get(conta).getTEL_CEL());%></td>
                                                <td>
                                                    <form method="POST" action="controladorCliente">
                                                        <input type="hidden" name ="prodEli" value="<%= (clientes.get(conta).getID_CLIENTE())%>"  />
                                                        <input type="submit" name ="ELIMINAR" value="ELIMINAR"  />
                                                    </form>
                                                </td>
                                            </tr>
                                            <%
                                                    conta++;
                                                };
                                            %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3"> 
                                                    <p>&nbsp;</p>
                                                    <%
                                                                out.write("<h3>Se encontraron: " + conta + " coincidencias</h3>");

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
                        <%
                        } else {
                        %>
                        <%
                            out.write(idioma.getProperty("Mantenimientos"));
                            }
                        %>
                        <!-- FIN ELIMINAR CLIENTE -->
                    </div>
                    <hr />
                </div>
            </section>
        </div>
        <!--    </div>
        </section>-->
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
        <!--</div>-->
        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/jquery.dropotron.min.js"></script>
        <script src="assets/js/jquery.scrollgress.min.js"></script>
        <script src="assets/js/skel.min.js"></script>
        <script src="assets/js/util.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>
