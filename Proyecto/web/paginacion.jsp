<%-- 
    Document   : paginacion
    Created on : 28/09/2016, 02:39:57 PM
    Author     : DesarrolloPantaleon
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*,java.lang.*,java.util.*, java.text.*,java.io.*" errorPage="" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html> 
<head> 
<title>Documento sin título</title> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
<script language="javascript" type="text/javascript"> 
//CUANDO LE DA CLIC EN SIGUIENTE SE MANDA A LLAMAR ESTA FUNCION 
function otraVez(){ 
document.form1.submit(); 
} 
</script> 
<style type="text/css"> 
BODY { 
scrollbar-face-color: #ADD6FE; 
scrollbar-highlight-color: #FFFFFF; 
scrollbar-shadow-color: #EDEDED; 
scrollbar-3dlight-color: #EEEAEE; 
scrollbar-arrow-color: #446699; 
scrollbar-track-color: #f5f5f5; 
scrollbar-darkshadow-color: #98AAB1; 
margin-left: 0px; 
margin-top: 0px; 
} 
.Estilo7 {color: #990000; font-size: 13px; font-family: Arial, Helvetica, sans-serif; font-weight: bold;} 
.Estilo8 {color:#FFFFFF; font-size: 13px; font-family: Arial, Helvetica, sans-serif; font-weight: bold;} 
.Estilo9 {color:#000000; font-size: 12px; font-family: Arial, Helvetica, sans-serif;} 
.Estilo10 {color:#0066CC; font-size: 12px; font-family: Arial, Helvetica, sans-serif; font-weight: bold;} 

a:link { 
text-decoration: none; 
color: #FFFFFF; 
} 
a:visited { 
text-decoration: none; 
color: #FFFFFF; 
} 
a:hover { 
text-decoration: underline; 
} 
a:active { 
text-decoration: none; 
} 
</style> 
</head> 
<% 
ResultSet rs1= null; 
Statement stmt1 = null; 
Connection con1 = null; 

String user=""; 
String pw=""; 
String url=""; 
String driverSQL=""; 

try{ 
funciones_jsp f = new funciones_jsp();	
int total_reg=0; 

//-------------- CREACION DE ARREGLO DE LISTA -------------------------------------------------- 
ArrayList lista_fol = new ArrayList(); 

//-------------- SI ESTA EL ARREGLO VACIO LO LLENA CON LA INFORMACION SOLICITADA ---------------- 
//-------------- SE REALIZA LA CONSULTA DE SQL -------------------------------------------------- 
if (lista_fol.isEmpty()){ 
url = f.urlMttoSQL(); 
driverSQL = f.driverSQL(); 
user = f.usuarioSQL(); 
pw = f.claveSQL(); 
Class.forName(driverSQL); 
con1 = DriverManager.getConnection(url,user,pw); 
stmt1 = con1.createStatement(); 
rs1=stmt1.executeQuery("SELECT folio FROM t_servicios WHERE tipo='ACLARACION' ORDER BY fecha DESC"); 

//-------------- BORRO EL CONTENIDO DE LA LISTA ------------------------------------------------- 
lista_fol.clear(); 

//-------------- SE LLENA LA LISTA CON EL RESULTSET (rs1) --------------------------------------- 
//-------------- VARIABLE total_reg CONTIENE LA CANTIDAD TOTAL DE REGISTROS --------------------- 
while (rs1.next()){ 
lista_fol.add(new Integer (rs1.getInt("folio"))); 
total_reg=total_reg+1; 
}//while 
}//if 

%> 
<body> 
<form name="form1" method="post" action=""> 
<table width="497" border="0" align="center" cellpadding="2" cellspacing="0" bordercolor="#CCCCCC"> 
<tr bgcolor="#3399FF" class="Estilo8"> 
<td width="104" bgcolor="#0066CC"><div align="center">Folio</div></td> 
<td width="255" bgcolor="#0066CC"><div align="center">Mostrar</div></td> 
<td width="104" bgcolor="#0066CC"><div align="center">Fecha</div></td> 
</tr> 
<%	
//----------- OBTENGO LOS REGISTROS QUE SE HAN MOSTRADO -------------------------------------------------- 
//----------- LA PRIMERA VEZ QUE SE EJECUTA LA PAGINA reg_actual=0 ---------------------------------------	
String reg_actual=request.getParameter("reg_actual");	if (reg_actual==null || reg_actual.equals("")) reg_actual="0"; 
int regActual=Integer.parseInt(reg_actual); 

//----------- CANTIDAD DE REGISTROS A PAGINAR 17 (n-1)----------------------------------------------------- 
int paginacion=16; 

//----------- VARIABLE "HASTA" CONTROLA LA CANTIDAD DE REGISTROS QUE SE MOSTRANRAN EN PANTALLA ------------ 
int hasta=regActual+paginacion; 
if (hasta>=(total_reg-1)){ 
hasta=total_reg-1; 
} 

int fol=0; 

//----------- MUESTRA EL CONTENIDO DEL ARREGLO DE LISTA EN PANTALLA ---------------------------------------- 
if (!lista_fol.isEmpty()){ 
if (hasta<=total_reg){ 
int renglon=1;	//---- VARIABLE PARA DEFINIR EL COLOR DEL RENGLON 
for (int i=regActual; i<=hasta; i++){	//---- VACIO EL ARREGLO DE LISTA 
Integer fl = ((Integer)lista_fol.get(i)); 
fol = fl.intValue(); 
if(renglon % 2 == 0){ // ---- SI ES PAR EL COLOR DEL RENGLON ES BLANCO, SI NO ES AZUL CLARO 
%>	<tr class="Estilo9"> 
<td><%=i+1%>-<%=fol%> </td> 
<td> </td> 
<td> </td> 
</tr> 
<%	} else {	// ---- SI ES IMPAR EL COLOR DEL RENGLON ES AZUL CLARO 
%>	<tr class="Estilo9"> 
<td bgcolor="#EFF3FB"><%=i+1%>-<%=fol%> </td> 
<td bgcolor="#EFF3FB"> </td> 
<td bgcolor="#EFF3FB"> </td> 
</tr> 
<%	} 
renglon=renglon+1;	//---- INCREMENTO LA VARIABLE 
}//for 
regActual=hasta+1;//---- CANTIDAD DE REGISTROS QUE SE MUESTRAN EN CADA CICLO 
}//if 
} 
%>	<tr bgcolor="#3399FF" class="Estilo8"> 
<%	if (regActual<=21){	//---- NO MUESTRA LA LEYENDA ANTERIOR 
%>	<td bgcolor="#0066CC"> </td> 
<%	} else { //---- MUESTRA LA LEYENDA ANTERIOR 
%>	<td bgcolor="#0066CC"><div align="right"><a href="javascript:history.back()" class="Estilo8">Anterior</a></div></td> 
<%	} 
%>	<td bgcolor="#0066CC"><div align="center"><%=regActual%> registros de <%=total_reg%></div></td> 
<%	if (total_reg!=regActual){	//---- MUESTRA LA LEYENDA SIGUIENTE Y LE DA UN SUBMIT A LA PAGINA EJECUTANDO LA FUNCION OTRAVEZ 
%>	<td bgcolor="#0066CC"><a href="javaScript:otraVez()" class="Estilo8">Siguiente</a> </td> 
<%	} else{	//---- NO MUESTRA LA LEYENDA SIGUIENTE 
%>	<td bgcolor="#0066CC"> </td> 
<%	} 
%>	</tr> 
</table> 

<!--CAMPO DE TEXTO REG_ACTUAL CONTIENE LOS REGISTROS QUE SE HAN MOSTRADO --> 
<input name="reg_actual" type="text" id="reg_actual" value="<%=regActual%>"> 
<% } catch (Exception e) { 
%>	<table width="585" border="0" align="center"> 
<tr> 
<td width="240" class="Estilo7"> </td> 
<td width="241" class="Estilo7"> </td> 
</tr> 
<tr> 
<td class="Estilo7"> </td> 
<td class="Estilo7"><div align="right"><a href="javascript:history.back()"><img src="../imagenes/btnregresar.gif" width="81" height="16" border="0"></a></div></td> 
</tr> 
<tr> 
<td class="Estilo7"> </td> 
<td class="Estilo7"> </td> 
</tr> 
<tr> 
<td colspan="2" class="Estilo7"><div align="center">Se genero un error consulte a su Administrador</div></td> 
</tr> 
<tr> 
<td colspan="2" class="Estilo7"><div align="center">Gracias<%=e%></div></td> 
</tr> 
</table> 
<%	} finally { 
if (con1!=null) { 
rs1.close(); 
rs1=null; 
stmt1.close(); 
stmt1=null; 
con1.close(); 
con1=null; 
}//if 
}//finally 
%> 
</form> 
</body> 
</html>