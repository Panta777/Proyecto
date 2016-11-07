<%-- 
    Document   : nuevoCliente
    Created on : 12/09/2016, 08:15:25 PM
    Author     : panle
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Idioma"%>
<%@page import="modelo.OperacionesCliente"%>
<%@page session = "true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registro de Nuevo Cliente</title>
        <link rel="shortcut icon" href="images/ICONOS/ICO.ico "/>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <meta http-equiv="Cache-Control" content="no-cache">
        <meta HTTP-EQUIV="Expires" CONTENT="Tue, 01 Jan 1980 1:00:00 GMT">
        <meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
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

            String nivel = "", resOper = "";
            if (sesion.getAttribute("nivel") != null && sesion.getAttribute("user") != null) {
                nivel = sesion.getAttribute("nivel").toString();
            }
            if (nivel.equals("2") || nivel.equals("1")) {
                response.sendRedirect("modificaCliente.jsp");
            }

            if (sesion.getAttribute("resOper") != null) {
                resOper = sesion.getAttribute("resOper").toString();
            }
        %>
    </head>
    <body class="landing">
        <div id="page-wrapper">
            <!-- Header -->
            <header id="header" >
                <h1><a href="#main"><% out.write(idioma.getProperty("mueblierialosalpes"));%></a></h1>
                <nav id="nav">
                    <ul>
                        <li><a href="index.jsp"><% out.write(idioma.getProperty("inicio"));%></a></li>
                        <li>
                            <a href="#" class="icon fa-angle-down">Menu</a>
                            <ul>
                                <li><a href="catalogo.jsp"><% out.write(idioma.getProperty("CatálogoProductos"));%></a></li>
                                <li><a href="contact.jsp"><% out.write(idioma.getProperty("Contacto"));%></a></li>
                                <li>
                                    <a href="#">Opciones</a>
                                    <ul>
                                        <li><a href="catalogo.jsp"><% out.write(idioma.getProperty("BuscarProductos"));%></a></li>
                                        <li><a href="#"><% out.write(idioma.getProperty("VerPedido"));%></a></li>  
                                        <li><a href="#"><% out.write(idioma.getProperty("Comentarios"));%></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <% if (nivel.equals("3") || nivel.equals("4") || nivel.equals("")) {%>
                        <li>
                            <a href="login.jsp" class= "button special"> <% out.write(idioma.getProperty("Entrar"));%>  <img src="images/ICONOS BLANCOS/CARRITO.png" width="25" height="21" alt ="carrito"> </a>
                            <ul>
                                <li> <a href="nuevoCliente.jsp" class ="actions"><% out.write(idioma.getProperty("Registrate"));%></a> </li>
                            </ul>
                        </li>             
                        <%}%>
                    </ul>     
                </nav>
            </header>
            <!-- Banner -->
            <section id="banner" class ="box special">
                <span class="image featured"><img src="images/logo.png" alt="log" /></span>
                <p><% out.write(idioma.getProperty("Sirviendolecon"));%></p>
            </section>
            <!-- Main -->
            <section id="main" class="container">
                <section class="box special">
                    <header class="major">
                        <h2><% out.write(idioma.getProperty("REGISTRONUEVOCLIENTE"));%></h2>
                        <span class="image featured"><img src="images/ICONOS/MUEBLES.png" alt="" /></span>
                    </header>                
                </section>
                <div class="row">
                    <div class="12u">
                        <!-- Form -->
                        <section class="box">
                            <h3><p><%out.write(idioma.getProperty("Ingresesusdatos"));%></p></h3>    
                            <form method="post" action="controladorCliente">
                                <div class="row uniform 50%">
                                    <div class="6u 12u(mobilep)">
                                        <input type="text" name="NoDoc" id="NoDoc" value="" placeholder="<%out.write(idioma.getProperty("NoDocumento"));%>" />
                                    </div>
                                    <div class="6u 12u(mobilep)">
                                        <div class="select-wrapper">
                                            <select  name="TipoDoc" id="TipoDoc" >
                                                <option value=""><% out.write(idioma.getProperty("TipoDocumento"));%></option>
                                                <option value="DPI"><% out.write(idioma.getProperty("DPI"));%></option>
                                                <option value="Pasaporte"><% out.write(idioma.getProperty("Pasaporte"));%></option>
                                                <option value="Otros"><% out.write(idioma.getProperty("Otrosdoc"));%></option>
                                            </select>
                                        </div>
                                    </div>                                
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="FName" id="FName" value="" placeholder=" <%out.write(idioma.getProperty("Nombres"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="LName" id="LName" value="" placeholder="<% out.write(idioma.getProperty("Apellidos"));%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="TelRes" id="TelRes" value="" placeholder="<%out.write(idioma.getProperty("TeléfonoResidencia"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="TelCel" id="TelCel" value="" placeholder=" <% out.write(idioma.getProperty("TeléfonoCelular"));%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Nit" id="Nit" value="" placeholder="<%out.write(idioma.getProperty("NIT"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Direccion" id="Direccion" value="" placeholder="<% out.write(idioma.getProperty("Dirección"));%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <!--                                        <form name="form1" action="SERVLET" method="POST">-->
                                            <!--                                            <select  name="Pais" id="Pais" onChange ="countryChange(this)" onChange ="location.href='nuevoCliente.jsp?#formularioNuevo'">-->
                                            <select  name="Pais" id="Pais" >
                                                <option value="-Pais-" ><%out.write(idioma.getProperty("Pais"));%></option>
                                                <%
                                                    OperacionesCliente oc = new OperacionesCliente();
                                                    ArrayList<String> paises = oc.mostrarPais();
                                                    int conta = 0;
                                                    String pas[] = {"", ""};
                                                    if (paises != null && paises.size() > 0) {
                                                        while (conta < paises.size()) {

                                                            pas = paises.get(conta).split(";");
                                                %>
                                                countryLists[<%= conta%>] = "<%= pas[0]%>"; 
                                                <%
                                                    conta++;
                                                %>
                                                <option value="<%=Integer.valueOf(pas[0].replaceAll(" ", ""))%>" id ="pais<%out.write(pas[0]);%>"> <%out.write(pas[1]);%></option>
                                                <%
                                                        }
                                                    }
                                                    sesion.setAttribute("Pais", Integer.valueOf(pas[0].replaceAll(" ", "")));
                                                %>
                                            </select>
                                            <!--                                            </form>-->
                                        </div>
                                    </div>                                    
                                    <div class="6u 12u(narrower)">
                                        <div class="select-wrapper">
                                            <select  name="Departamento" id="Departamento"  >
                                                <option value=""><% out.write(idioma.getProperty("Departamento"));%></option>
                                                <%
                                                    int idpais = 0;
                                                    System.out.println("id: " + sesion.getAttribute("Pais"));

                                                    if (sesion.getAttribute("Pais") != null) {
                                                        idpais = Integer.parseInt(sesion.getAttribute("Pais").toString());
                                                    }

                                                    OperacionesCliente oc2 = new OperacionesCliente();
                                                    ArrayList<String> depas = oc2.mostrarDepartamento(1);
                                                    int conta2 = 0;
                                                    String pas2[] = {"", ""};
                                                    if (depas != null && depas.size() > 0) {
                                                        while (conta2 < depas.size()) {
                                                            System.out.println("id: " + depas.get(conta2));
                                                            pas2 = depas.get(conta2).split(";");
                                                            conta2++;
                                                %>

                                                <option value="<%out.write(pas2[0]);%>"> <%out.write(pas2[1]);%></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Ciudad" id="Ciudad" value="" placeholder="<%out.write(idioma.getProperty("Ciudad"));%>" />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="Profesion" id="Profesion" value="" placeholder="<% out.write(idioma.getProperty("Profesion"));%>"  />
                                    </div>
                                    <div class="6u 12u(narrower)">
                                        <input type="text" name="email" id="email" value="" placeholder="<%out.write(idioma.getProperty("email"));%>" />
                                    </div>
                                    <div class="12u">
                                        <h3><% out.write(idioma.getProperty("DatosparaIngresoalSistema"));%></h3> 
                                    </div>
                                    <div class="12u">
                                        <input type="text" name="usuario" id="usuario" value="" placeholder="<% out.write(idioma.getProperty("Usuario"));%>"  />
                                    </div>
                                    <div class="12u">
                                        <input type="Password" name="pass" id="pass" value="" placeholder="<% out.write(idioma.getProperty("Contraseña"));%>"  />
                                    </div>
                                    <div class="12u">
                                        <input type="Password" name="pass2" id="pass2" value="" placeholder="<% out.write(idioma.getProperty("ConfirmeContraseña"));%> " onBlur ="CompruebaContras(this.form)" />
                                    </div>
                                    <div class="12u">
                                        <input type="checkbox" id="human" name="human"  onClick="AutenticaSiEsHumano(this.form)">
                                        <label for="human"><% out.write(idioma.getProperty("soyhumanonorobot"));%> </label>
                                    </div>
                                    <div class="row uniform " id = "ResultadoNuevoCliente">
                                        <div class="12u">
                                            <ul class="actions">
                                                <li><input type="submit" name ="EnviaCliente" disabled = true value="<% out.write(idioma.getProperty("Enviar"));%> "  /></li>
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
        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/jquery.dropotron.min.js"></script>
        <script src="assets/js/jquery.scrollgress.min.js"></script>
        <script src="assets/js/skel.min.js"></script>
        <script src="assets/js/util.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>
