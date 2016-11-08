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
%>
<!DOCTYPE html>
<html>
    <head>
        <title> <% out.write(idioma.getProperty("ActualizacióndemisDatos"));%></title>
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
        <section id="container"> 
            <div id="page-wrapper">
                <!-- Header -->
                <header id="header">
                    <h1><a href="#main"><% out.write(idioma.getProperty("mueblierialosalpes"));%></a></h1>
                    <nav id="nav">
                        <ul>
                            <li><a href="index.jsp#main"><% out.write(idioma.getProperty("inicio"));%></a></li>
                            <li>
                                <a href="#" class="icon fa-angle-down">Menu</a>
                                <ul>
                                    <li><a href="catalogo.jsp#main"><% out.write(idioma.getProperty("CatálogoProductos"));%></a></li>
                                    <li><a href="contact.jsp#main"><% out.write(idioma.getProperty("Contacto"));%></a></li>
                                    <li><a href="#productosCarrito.jsp#main"><% out.write(idioma.getProperty("VerPedido"));%></a></li> 
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
                                <a  class= "button special"><% out.write(idioma.getProperty("usuario"));%><%=usuario%><img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                                <ul>
                                    <li> <a href="modificaCliente.jsp#main" class ="actions"><% out.write(idioma.getProperty("ModificarmisDatos"));%></a> </li>
                                    <li> <a href="logout.jsp" class ="actions"><% out.write(idioma.getProperty("CerrarSesión"));%></a> </li>
                                </ul>
                            </li>
                        </ul>     
                    </nav>
                </header>
                <!-- Banner -->
                <section id="banner" class ="box special">
                    <span class="image featured"><img src="images/logo.png" alt="log" /></span>
                    <p><% out.write(idioma.getProperty("Sirviendolecon"));%></p>
                </section>
                <!-- Main -->
                <section id="main" class="container" id = "main">
                    <section class="box special">
                        <header class="major">
                            <h2><% out.write(idioma.getProperty("ACTUALIZACIÓNDEMISDATOS"));%></h2>
                            <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                        </header>                
                    </section>
                    <div class="row">
                        <div class="12u">
                            <!-- Form -->
                            <section class="box">
                                <h3><p><% out.write(idioma.getProperty("Modifiquelosdatosdeseados"));%></p></h3>
                                <form method="post" action="controladorCliente">
                                    <div class="row uniform 50%">
                                        <div class="6u 12u(mobilep)">
                                            <h1><% out.write(idioma.getProperty("NoDocumento"));%>:</h1>
                                            <input type="text" name="NoDoc" id="NoDoc" value="<%out.write(clMostrar.getNUMERO_DOC());%>"/>
                                        </div>   
                                        <div class="6u 12u(mobilep)">
                                            <div class="select-wrapper">
                                                <h1><% out.write(idioma.getProperty("TipoDocumento"));%>: </h1>
                                                <select  name="TipoDoc" id="TipoDoc" >
                                                    <%if (clMostrar.getTIPODOCUMENTO() != null) {
                                                            if (clMostrar.getTIPODOCUMENTO().contains("DPI") || clMostrar.getTIPODOCUMENTO().contains("DCI")) {%>
                                                    <option value="" selected ><%out.write(clMostrar.getTIPODOCUMENTO());%></option>
                                                    <option value="Pasaporte"><% out.write(idioma.getProperty("Pasaporte"));%></option>
                                                    <option value="Otros"><% out.write(idioma.getProperty("Otrosdoc"));%></option>
                                                    <%}%>
                                                    <%if (clMostrar.getTIPODOCUMENTO().contains("Pasaporte") || clMostrar.getTIPODOCUMENTO().contains("Passport")) {%>
                                                    <option value="" selected ><%out.write(clMostrar.getTIPODOCUMENTO());%></option>
                                                    <option value="DPI"><% out.write(idioma.getProperty("DPI"));%></option>
                                                    <option value="Otros"><% out.write(idioma.getProperty("Otrosdoc"));%></option>
                                                    <%}%>
                                                    <%if (clMostrar.getTIPODOCUMENTO().contains("Others") || clMostrar.getTIPODOCUMENTO().contains("Otros")) {%>
                                                    <option value="" selected ><%out.write(clMostrar.getTIPODOCUMENTO());%></option>
                                                    <option value="Pasaporte"><% out.write(idioma.getProperty("Pasaporte"));%></option>
                                                    <option value="DPI"><% out.write(idioma.getProperty("DPI"));%></option>
                                                    <%}
                                                    } else {%>
                                                    <option value="DPI"><% out.write(idioma.getProperty("DPI"));%></option>
                                                    <option value="Pasaporte"><% out.write(idioma.getProperty("Pasaporte"));%></option>
                                                    <option value="Otros"><% out.write(idioma.getProperty("Otrosdoc"));%></option>
                                                    <%} %>
                                                </select>
                                            </div>
                                        </div>    
                                        <div class="6u 12u(narrower)">
                                            <h1><% out.write(idioma.getProperty("Nombres"));%>:</h1>
                                            <input type="text" name="FName" id="FName" value="<%out.write(clMostrar.getNOMBRE());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1><% out.write(idioma.getProperty("Apellidos"));%>:</h1>
                                            <input type="text" name="LName" id="LName" value="<%out.write(clMostrar.getAPELLIDO());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1><% out.write(idioma.getProperty("TeléfonoResidencia"));%></h1>
                                            <input type="text" name="TelRes" id="TelRes" value="<%out.write(clMostrar.getTEL_RESIDENCIA());%>"   />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1><% out.write(idioma.getProperty("TeléfonoCelular"));%></h1>
                                            <input type="text" name="TelCel" id="TelCel" value="<%out.write(clMostrar.getTEL_CEL());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1><%out.write(idioma.getProperty("NIT"));%></h1>
                                            <input type="text" name="Nit" id="Nit" value="<%out.write(clMostrar.getNIT());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1><% out.write(idioma.getProperty("Dirección"));%></h1>
                                            <input type="text" name="Direccion" id="Direccion" value="<%out.write(clMostrar.getDIRECCION());%>"  />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1><% out.write(idioma.getProperty("Ciudad"));%></h1>
                                            <input type="text" name="Ciudad" id="Ciudad" value="<%out.write(clMostrar.getCIUDAD());%>" />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1><% out.write(idioma.getProperty("Profesion"));%></h1>
                                            <input type="text" name="Profesion" id="Profesion" value="<%out.write(clMostrar.getPROFESION());%>"   />
                                        </div>
                                        <div class="6u 12u(narrower)">
                                            <h1><% out.write(idioma.getProperty("email"));%></h1>
                                            <input type="text" name="email" id="email" value="<%out.write(clMostrar.getEMAIL());%>"  />
                                            <input type="hidden" name="idcliente" id="idcliente" value=<%=clMostrar.getID_CLIENTE()%> />
                                        </div>
                                        <div class="12u">
                                            <input type="checkbox" id="human" name="human"  onClick="AutenticaSiEsHumano(this.form)">
                                            <label for="human"><% out.write(idioma.getProperty("soyhumanonorobot"));%></label>
                                        </div>
                                    </div>
                                    <div class="row uniform ">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li><input type="submit" name ="modificaCliente" disabled = true value="<% out.write(idioma.getProperty("Enviar"));%> "  /></li>
                                            </ul>
                                        </div>
                                        <%
                                            if (resOper != null) {
                                                out.write((String) sesion.getAttribute("resOper"));
                                                sesion.setAttribute("resOper", null);
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
                        <li>&copy; <% out.write(idioma.getProperty("TodoslosDerechosReservados"));%></li><li><% out.write(idioma.getProperty("Diseñadopor"));%> <a href="https://www.facebook.com/panta.medrano">Panta Medrano</a></li>
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
