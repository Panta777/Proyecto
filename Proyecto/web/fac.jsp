<%-- 
    Document   : fac
    Created on : 7/11/2016, 03:52:05 PM
    Author     : DesarrolloPantaleon
--%>
<%@page import="java.util.Calendar"%>
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

    Calendar now = Calendar.getInstance();
    String tmpTxt = "";
    // controladorProducto cp = new controladorProducto();
    //   ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
%>
<!DOCTYPE html>
<html>
    <body>
        <div style='width:6.6cm; height:100%; font-size: 10px; font-family: monospace; line-height: 1em; color:black; font-weight:bold;'>
            <center><img src="images/logo-mini.png" /></center>
            <p style='padding: 1px;text-align: center; text-transform: uppercase; margin:0px; line-height: 1em;'>MUEBLERIA LOS ALPES S.A. <br/>Zona 12, Villa Nueva, Guatemala<br/>NIT: 555555-5</p>
            <p>
            <table>
                <tr>
                    <td>
                        <div style='width:100%; float:left; line-height: 1em;'>Tarjeta de Crédito NO..: XXXX-XXXX-XXXX-0572</div>
                    </td>
                    <td >
                        <div style='width:100%; float:left; line-height: 1em;'>COD. AGENCIA : 915 </div>
                    </td>
                </tr>
                <tr>
                    <td >
                        <div style='width:100%; float:left; line-height: 1em;'>Nombre del Cliente.: </div>
                    </td>
                    <td>
                        <div style='width:100%; float:left; line-height: 1em;'>RECIBO NO.: 201607000031 </div>
                    </td>
                </tr>
            </table>
            <div style='padding: 2px;width:100%;  float:left; line-height: 1em;'>
                JORGE VIDAL GIRON ZAMORA
                <div style='padding: 2px;width:100%;  float:left; line-height: 1em;'>&nbsp</div>
                <div style='padding: 2px;width:100%; float:left; line-height: 1em;'>Cantidad ...........: &nbsp;</div>
                <div style='padding: 2px;width:100%; float:left; line-height: 1em;'>DOSCIENTOS TREINTA Y TRES QUETZALES CON 96/100</div>
                <div style='padding: 2px;width:100%; float:left; line-height: 1em;'>USUARIO...: DESAWSPMEDRANO</div>
                <div style='padding: 2px;width:100%; float:left; line-height: 1em;'>Fecha Y Hora .......: 20/07/2016 15:53:33</div>
<!--                <table width="750px" border="0px">
                    <tr>
                        <td width="250px"></td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>Liquidacion</div>
                        </td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>Monto</div>
                        </td>
                    </tr>
                    <tr>
                        <td width="250px"> </td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>Saldo al Corte</div>
                        </td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>Q. 5,615.90 </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="250px"> </td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>Saldo Actual</div>
                        </td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>Q. 1,586.00</div>
                        </td>
                    </tr>
                    <tr>
                        <td width="250px"></td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>Pago Minimo</div>
                        </td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>Q. 233.96</div>
                        </td>
                    </tr>
                    <tr>
                        <td width="250px"> </td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>MONTO PAGADO</div>
                        </td>
                        <td width="250px">
                            <div style='width:100%; float:left; line-height: 1em;'>Q. 233.96</div>
                        </td>
                    </tr>
                </table>-->
<!--                <table>
                    <tr>
                        <td >
                            <div style='width:100%; float:left; line-height: 1em;'>Fecha Vencimiento de la Couta: 15/04/2016</div>
                        </td>
                        <td >
                            <div style='width:100%; float:left; line-height: 1em;'></div>
                        </td>
                    </tr>
                </table>-->
                <br />
            </div>
    </body>
</html>

<!--* //                    strImagen[ContadorImg - 1] 
//                    = "<html>"
//                    + "<body>"
//                    + "<table border=\"0\">\n"
//                    + "<tr>\n"
//                    + "<td width=\"0px\"> &nbsp; </td>\n"
//                    + "<td width=\"300px\">"
//                    + "<div style='width:10cm; height:100%; font-size: 10px; font-family: monospace; line-height: 1em; color:black; font-weight:bold;'>"
//                    + "<p style='text-align: center; text-transform: uppercase; margin:0px; line-height: 1em;'>PRONET, S.A.</p>"
//                    + "<p style='text-align: center; margin:0px; line-height: 1em;'>Tus pagos en un solo lugar!</p>"
//                    + "<p style='text-align: center; text-transform: uppercase; line-height: 1em;'><br/>"
//                    + "COMPROBANTE UNICO DE PAGO</p>"
//                    + "<p>"
//                    + "<div style='width:100%;  float:left; line-height: 1em;'>REF: " + rsRecords.getString("ReferenciaPronet") + "</div>"
//                    + "<div style='width:100%;  float:left; line-height: 1em;'>FECHA: " + fechaI.format(fechaD) + "</div>"
//                    + "<div style='width:100%;  float:left; line-height: 1em;'>HORA: " + horaI.format(fechaD) + "</div>"
//                    + "<div style='width:100%;  float:left; line-height: 1em;'>CAJERO: " + rsRecords.getString("Usuario") + "</div>"
//                    + "</p><br/>"
//                    + "<p style='text-align: center; text-transform: uppercase; line-height: 1em;'>RECIBO PAGO " + rsRecords.getString("NombreAfiliado") + ":<br/> " + PAGO + "</p>"
//                    + "<br />";
//                    
//                    if (rsRecords.getString("IdCliente") != null && !rsRecords.getString("IdCliente").isEmpty()) 
//                    {
//                        strImagen[ContadorImg - 1] += "<div style='width:100%; float:left; line-height: 1em;'>" + ID1 + ":  " + rsRecords.getString("IdCliente") + " &nbsp;</div>";
//                    }
//
//                    if (rsRecords.getString("Documento") != null && !rsRecords.getString("Documento").isEmpty()) 
//                    {
//                        strImagen[ContadorImg - 1] += "<div style='width:100%; float:left; line-height: 1em;'>" + ID2 + ":  " + rsRecords.getString("Documento") + " &nbsp;</div>";
//                    }
//
//                    strImagen[ContadorImg - 1] += "<br /><br /><br />";
//                    if (rsRecords.getString("NombreCapturado") != null && !rsRecords.getString("NombreCapturado").equals("'          '") && !rsRecords.getString("NombreCapturado").isEmpty())
//                    {
//                        strImagen[ContadorImg - 1] += "<div style='width:40%; float:left; line-height: 1em;'>NOMBRE:</div><div style='width:60%; float:left; line-height: 1em;'>" + rsRecords.getString("NombreCapturado") + "</div>";
//                    }
//
//                    if (rsRecords.getString("Nit") != null && !rsRecords.getString("Nit").isEmpty()) 
//                    {
//                        strImagen[ContadorImg - 1] += "<div style='width:40%; float:left; line-height: 1em;'>NIT: </div><div style='width:60%; float:left; line-height: 1em;'>" + rsRecords.getString("Nit") + "&nbsp;</div>";
//                    }
//
//                    if (!rsRecords.getString("MontoEfectivo").equals("0.00")) 
//                    {
//                        strImagen[ContadorImg - 1] += "<p style='text-align: center; text-transform: uppercase; line-height: 1em;'>EFECTIVO:&nbsp; " + rsRecords.getString("MonedaSimbolo") + tempEfectivo + "<br/> </p>";
//                    }
//
//                    if (!rsRecords.getString("MontoOtro").equals("0.00")) 
//                    {
//                        strImagen[ContadorImg - 1] += "<p style='text-align: center; text-transform: uppercase; line-height: 1em;'>EXENCION:&nbsp; " + rsRecords.getString("MonedaSimbolo") + tempExencion + "<br/> </p>";
//                    }
//
//                    if (!rsRecords.getString("MontoCheque").equals("0.00")) 
//                    {
//                        strImagen[ContadorImg - 1] += "<p style='text-align: center; text-transform: uppercase; line-height: 1em;'>CHEQUES:&nbsp; " + rsRecords.getString("MonedaSimbolo") + tempCheques + "<br/> </p>";
//                    }
//
//                    strImagen[ContadorImg - 1] 
//                    += "<p style='text-align: center; text-transform: uppercase; line-height: 1em;'>TOTAL:&nbsp; " + rsRecords.getString("MonedaSimbolo") + tempMonto + "<br/> </p>"
//                    + "<br />"
//                    + "<br /> <br />"
//                    + "<div style='text-align: center; margin:0px; line-height: 1em;'>** certificación valida con <br /> firma y sello del cajero  **</div>"
//                    + "<br /><br /><br />"
//                    + "</div>" + "</td>"
//                    + "</tr> </table> "
//                    + "</body>"
//                    + "</html>";-->
