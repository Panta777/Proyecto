<%-- 
    Document   : nuevoCliente
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="ClasesGenericas.Cliente"%>
<%@page import="modelo.Idioma"%>
<%@page import="modelo.OperacionesCliente"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Actualización de mis Datos</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico "/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <script languaje="javascript">
            function AutenticaSiEsHumano(form)
            {
                if (form.human.checked === true)
                {
                    form.modificaCliente.disabled = false;
                } else
                {
                    form.modificaCliente.disabled = true;
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
    </head>
    <body class="landing" oncontextmenu='return false'>
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
            if (nivel.equals("3") || nivel.equals("4") || nivel == "") {
                response.sendRedirect("nuevoCliente.jsp");
            }
            if (sesion.getAttribute("resOper") != null) {
                resOper = sesion.getAttribute("resOper").toString();
            }

            OperacionesCliente oper = new OperacionesCliente();
            Cliente clMostrar = oper.mostrarDatosCliente(usuario);
            //   new Cliente();clMostrar = 
//            if(oper.mostrarDatosCliente(usuario) != null)
//            {

//            };
%>
        <section id="container"> 
            <div id="page-wrapper">
                <!-- Header -->
                <header id="header">
                    <h1><a href="#main"><% out.write(idioma.getProperty("mueblierialosalpes"));%></a></h1>
                    <nav id="nav">
                        <ul>
                            <li><a href="index.jsp">Inicio</a></li>
                            <li>
                                <a href="#" class="icon fa-angle-down">Menu</a>
                                <ul>
                                    <li><a href="catalogo.jsp">Catálogo Productos</a></li>
                                    <li><a href="contact.jsp">Contacto</a></li>
                                    <li><a href="#">Ver Pedido</a></li> 
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
                            <%if (nivel.equals("2") || nivel.equals("1")) {%>
                            <li>
                                <a  class= "button special">Usuario:  <%=usuario%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
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
                <section id="banner" class ="box special">
                    <span class="image featured"><img src="images/logo.png" alt="log" /></span>
                    <p>Sirviendole con total amabilidad desde 1985.</p>
                </section>
                <!-- Main -->
                <section id="main" class="container">
                    <section class="box special">
                        <header class="major">
                            <h2>ACTUALIZACIÓN DE MIS DATOS</h2>
                            <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                        </header>                
                    </section>
                    <div class="row">
                        <div class="12u">
                            <!-- Form -->
                            <section class="box">
                                <h3><p>Modifique los datos deseados:</p></h3>
                                <form method="post" action="controladorCliente">
                                    <div class="row uniform 50%">
                                        <div class="6u 12u(mobilep)">
                                            <h1>No Documento: </h1>
                                            <input type="text" name="NoDoc" id="NoDoc" value="<%out.write(clMostrar.getNUMERO_DOC());%>"/>
                                        </div>
                                        <div class="6u 12u(mobilep)">
                                            <h1>Tipo Documento: </h1>
                                            <div class="select-wrapper">
                                                <select  name="TipoDoc" id="TipoDoc" >
                                                    <option value="">-TipoDoc- <%out.write(idioma.getProperty("nombre"));%></option>
                                                    <option value="DPI">DPI <%out.write(idioma.getProperty("nombre"));%></option>
                                                    <option value="Pasaporte">Pasaporte <%out.write(idioma.getProperty("nombre"));%></option>
                                                    <option value="Otro(Licencia Conducir...etc)">Otro(Licencia Conducir...etc) <%out.write(idioma.getProperty("nombre"));%></option>
                                                </select>
                                            </div>
                                        </div>                                
                                        <div class="6u 12u(narrower)">
                                            <h1>Nombres: </h1>
                                            <input type="text" name="FName" id="FName" value="<%out.write(clMostrar.getNOMBRE());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1>Apellidos:</h1>
                                            <input type="text" name="LName" id="LName" value="<%out.write(clMostrar.getAPELLIDO());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1>Teléfono Residencia:</h1>
                                            <input type="text" name="TelRes" id="TelRes" value="<%out.write(clMostrar.getTEL_RESIDENCIA());%>"   />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1>Teléfono Celular:</h1>
                                            <input type="text" name="TelCel" id="TelCel" value="<%out.write(clMostrar.getTEL_CEL());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1>NIT:</h1>
                                            <input type="text" name="Nit" id="Nit" value="<%out.write(clMostrar.getNIT());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1>Dirección:</h1>
                                            <input type="text" name="Direccion" id="Direccion" value="<%out.write(clMostrar.getDIRECCION());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1>Ciudad:</h1>
                                            <input type="text" name="Ciudad" id="Ciudad" value="<%out.write(clMostrar.getCIUDAD());%>" />
                                        </div>
                                        <!--                                        <div class="6u 12u(narrower)">
                                                                                    <h1>Departamento: </h1>
                                                                                    <input type="text" name="Departamento" id="Departamento" value="<%out.write(clMostrar.getDEPARTAMENTO());%>"   />
                                                                                </div>
                                                                                <div class="6u 12u(narrower)">
                                                                                    <h1>País: </h1>
                                                                                    <input type="text" name="Pais" id="Pais" value="<%out.write(clMostrar.getPAIS());%>"  />
                                                                                </div>-->
                                        <div class="6u 12u(narrower)">
                                            <h1>Profesion: </h1>
                                            <input type="text" name="Profesion" id="Profesion" value="<%out.write(clMostrar.getPROFESION());%>"   />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1>Correo Electrónico: </h1>
                                            <input type="text" name="email" id="email" value="<%out.write(clMostrar.getEMAIL());%>"  />
                                        </div>
                                        <div class="12u">
                                            <h3>Datos para Ingreso al Sistema</h3> 
                                        </div>
                                        <div class="12u">
                                            <h1>Usuario: </h1>
                                            <input type="text" name="usuario" id="usuario" value="<%out.write(clMostrar.getUSUARIO());%>"/>
                                        </div>
                                        <div class="12u">
                                            <h1>Contraseña: </h1>
                                            <input type="Password" name="pass" id="pass" value="<%//out.write(clMostrar.getCONTRASENA());%>"   />
                                        </div>
                                        <div class="12u">
                                            <h1>Confirme Contraseña: </h1>
                                            <input type="Password" name="pass2" id="pass2" value="<%//out.write(clMostrar.getCONTRASENA());%>"   />
                                        </div>
                                        <div class="12u">
                                            <input type="checkbox" id="human" name="human"  onClick="AutenticaSiEsHumano(this.form)">
                                            <label for="human">I am a human and not a robot</label>
                                        </div>
                                    </div>
                                    <div class="row uniform ">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li><input type="submit" name ="modificaCliente" value="Send" disabled = true /></li>
                                            </ul>
                                        </div>
                                        <%
//                                            if (!resOper.equals("1") && !resOper.equals("")) {
//                                                out.write("<h5 style=\" color:red; font-weight:bold;\"><p> FALLO AL MODIFICAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>");
//                                            } else if (resOper.equals("1")) {
//                                                out.write("<h5 style=\" color:blue; font-weight:bold;\"><p> DATOS MODIFICADOS EXITOSAMENTE</p></h5>");
//                                            }

                                            if (sesion.getAttribute("resOper") != null) {
                                                out.write((String) sesion.getAttribute("resOper"));
                                            }
                                        %>
                                    </div>
                                </form>
                                <hr />              
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
