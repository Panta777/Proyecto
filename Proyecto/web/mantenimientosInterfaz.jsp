<%-- 
    Document   : nuevoCliente
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="ClasesGenericas.Producto"%>
<%@page import="modelo.OperacionesProducto"%>
<%@page import="modelo.Idioma"%>
<%@page import="modelo.OperacionesCliente"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mantenimiento Productos</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico "/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--        <meta http-equiv="Cache-Control" content="no-cache">
                <meta HTTP-EQUIV="Expires" CONTENT="Tue, 01 Jan 1980 1:00:00 GMT">
                <meta HTTP-EQUIV="Pragma" CONTENT="no-cache">-->
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
//            if (!nivel.equals("2") && !nivel.equals("1")) {
//                response.sendRedirect("index.jsp#main");
//            }

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
        %>
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
                                <li><a href="#catalogo"><% out.write(idioma.getProperty("CatálogoProductos"));%></a></li>
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
                                <li> <a href="logout.jsp" class ="actions"><% out.write(idioma.getProperty("CerrarSesión"));%></a> </li>
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
            <section id="banner" class ="box special">
                <img class="image featured" src="images/logo.png" alt="log" />
                <p><% out.write(idioma.getProperty("Sirviendolecon"));%></p>
            </section>
            <!-- Main -->
            <section id="main" class="container">
                <section class="box special">
                    <header class="major">
                        <h2>MANTENIMIENTOS</h2>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
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
                                        <input type="text" name="" id="in_REFERENCIA" value="" placeholder="Referencia" />
                                    </div>                               
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="FName" id="in_NOMBRE" value="" placeholder="<%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="LName" id="in_DESCRIPCION" value="" placeholder="Descripcion"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <select  name="in_TIPO" id="TipoProd" >
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
                                        <input type="text" name="FECHA_ALTA" id="FECHA_ALTA" value="" placeholder="FECHA ALTA"  />
                                    </div>

                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="ESTADO" id="ESTADO" value="" placeholder="ESTADO"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="PRECIOVENTA" id="PRECIOVENTA" value="" placeholder="PRECIOVENTA" />
                                    </div>
                                    <div class="row uniform " id = "ResultadoNuevoCliente">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li><input type="submit" name ="EnviarNP" value="<% out.write(idioma.getProperty("Enviar"));%> " /></li>
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
                                        <input type="text" name="" id="in_REFERENCIA" value="" placeholder="<%out.write(prodMostrar.getREFERENCIA());%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="FName" id="in_NOMBRE" value="" placeholder="<%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="LName" id="in_DESCRIPCION" value="" placeholder="Descripcion"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <select  name="in_TIPO" id="TipoProd" >
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
                                        <input type="text" name="FECHA_ALTA" id="FECHA_ALTA" value="" placeholder="FECHA ALTA"  />
                                    </div>

                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="ESTADO" id="ESTADO" value="" placeholder="ESTADO"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="PRECIOVENTA" id="PRECIOVENTA" value="" placeholder="PRECIOVENTA" />
                                    </div>
                                    <div class="row uniform " id = "ResultadoNuevoProducto">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li><input type="submit" name ="EnviarMP" value="Enviar" /></li>
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
                        <%
                            }
                        %>
                        <!-- Form Modificar PRODUCTO -->
                        <%//VER  ELIMINAR PRODUCTO  = 3
                            if (opera == 3) {
                        %>
                        <section class="box">
                            <h2>MANTENIMIENTO PRODUCTOS</h2>
                            <h3>BUSQUE EL PRODUCTO QUE DESEA DAR DE BAJA</h3>
                            <form method="post" action="controladorProducto">
                                <div class="row uniform 50%">
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="" id="in_REFERENCIA" value="" placeholder="Referencia" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="FName" id="in_NOMBRE" value="" placeholder="<%out.write(idioma.getProperty("nombre"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="LName" id="in_DESCRIPCION" value="" placeholder="Descripcion"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <select  name="in_TIPO" id="TipoProd" >
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
                                        <input type="text" name="FECHA_ALTA" id="FECHA_ALTA" value="" placeholder="FECHA ALTA"  />
                                    </div>

                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="ESTADO" id="ESTADO" value="" placeholder="ESTADO"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="PRECIOVENTA" id="PRECIOVENTA" value="" placeholder="PRECIOVENTA" />
                                    </div>
                                    <div class="row uniform " id = "ResultadoNuevoProducto">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li><input type="submit" name ="EnviarNP" value="Enviar" /></li>
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
                        <%
                            }
                        %>
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
