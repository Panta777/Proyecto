/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import ClasesGenericas.Producto;
import ClasesGenericas.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.OperacionesProducto;
import modelo.OperacionesProducto;


/**
 *
 * @author DesarrolloPantaleon
 */
@WebServlet(name = "controladorProducto", urlPatterns = {"/controladorProducto"})
public class controladorProducto extends HttpServlet{ 

    public String getProductos(String tipo) {
        OperacionesProducto mp = new OperacionesProducto();
        String htmlcode = "";
        for (Producto producto : mp.getAllProductos(tipo)) {
            htmlcode += "                                    <div class=\"4u 12u(narrower)\">\n"
                    + "                                <section class=\"box special\">\n"
                    + "                                    <span class=\"image featured\"><img src=\"" + producto.getFOTO() + "\" alt=\"Muebles Tradicionales\" /></span>\n"
                    + "                                    <h3>" + producto.getNOMBRE()+ "</h3>                                                <ul class=\"actions\">\n"
                    + "                                        <li><a href=\"detalleproducto.jsp?id=" + producto.getID_PRODUCTO() + "#main\" class= \"button \" >VER DETALLES</a></li>\n"
                    + "                                    </ul>\n"
                    + "                                </section></div>";
        }
        if(htmlcode.equals(""))
        {
            htmlcode = "<h3>NO HAY MUEBLES EN ESTA CATEGORIA</h3> ";
            htmlcode += "<span class=\"image featured\"><img src=\"images/404.png\" alt=\"Sin Muebles\" /></span>\n ";
        }
        //System.out.println("Resultado:" + htmlcode);
        return htmlcode;

    }

    public Producto getProducto(int id) {
        return new OperacionesProducto().getProducto(id);
    }
    
        //metodo encargado de la gestión del método POST
    //Recibe los parametros de la paginas para el mantenimiento del Producto
    protected void processRequestPOST(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            OperacionesProducto opproducto = new OperacionesProducto();
            Producto producto = new Producto();

            if (request.getParameter("EnviarNP") != null) {
//                if (request.getParameter("pass") == null ? request.getParameter("pass2") != null : !request.getParameter("pass").equals(request.getParameter("pass2"))) {
//                    response.sendRedirect("nuevoProducto.jsp");
//                } else {

                    producto.setREFERENCIA(request.getParameter("FName"));
                    producto.setNOMBRE(request.getParameter("FName"));
                    producto.setDESCRIPCION(request.getParameter("FName"));
                   producto.setTIPO(request.getParameter("FName"));
                    producto.setMATERIAL(request.getParameter("FName"));
                     producto.setALTO(request.getParameter("FName"));
                    producto.setANCHO(request.getParameter("FName"));
                     producto.setPROFUNDIDAD(request.getParameter("FName"));
                    producto.setCOLOR(request.getParameter("FName"));
                     producto.setPESO(request.getParameter("FName"));
                     producto.setFOTO(request.getParameter("FName"));
                     producto.setESTADO(request.getParameter("FName"));
                     producto.setPRECIOVENTA(Double.valueOf(request.getParameter("FName")));
                
                    HttpSession sesion = request.getSession();
                    String respuesta = opproducto.insertarProducto(producto);
                    if(respuesta.equals(""))
                    {
                        sesion.setAttribute("resOper", "out.write(\"<h5 style=\\\" color:red; font-weight:bold;\\\"><p> FALLO AL INSERTAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>\");\n" );
                    }
                    else
                    {
                        
                    }
                    sesion.setAttribute("resOper", "<h5 style=' color:blue; font-weight:bold;' ><p>" +respuesta+ "</p></h5>");
                    response.sendRedirect("nuevoProducto.jsp#ResultadoNuevoProducto");
                //}
            } else if (request.getParameter("modificaProducto") != null) {
                if (request.getParameter("pass") == null ? request.getParameter("pass2") != null : !request.getParameter("pass").equals(request.getParameter("pass2"))) {
                    response.sendRedirect("modificarProducto.jsp");
                } else {
                    producto.setREFERENCIA(request.getParameter("FName"));
                    producto.setNOMBRE(request.getParameter("FName"));
                    producto.setDESCRIPCION(request.getParameter("FName"));
                   producto.setTIPO(request.getParameter("FName"));
                    producto.setMATERIAL(request.getParameter("FName"));
                     producto.setALTO(request.getParameter("FName"));
                    producto.setANCHO(request.getParameter("FName"));
                     producto.setPROFUNDIDAD(request.getParameter("FName"));
                    producto.setCOLOR(request.getParameter("FName"));
                     producto.setPESO(request.getParameter("FName"));
                     producto.setFOTO(request.getParameter("FName"));
                     producto.setESTADO(request.getParameter("FName"));
                     producto.setPRECIOVENTA(Double.valueOf(request.getParameter("FName")));
                

                    HttpSession sesion = request.getSession();
                    switch (opproducto.insertarProducto(producto)) {
                        case "":
//                            sesion.setAttribute("user", usu);//                            sesion.setAttribute("nivel", "1");
                            System.out.println("Prueba Modificacion");
                            System.out.println("Exito");
                            sesion.setAttribute("resOper", "1");
                            break;
                        default:
                            sesion.setAttribute("resOper", "2");
                            break;
                    }
                    response.sendRedirect("modificaProducto.jsp");
                }
            }
        } catch (SQLException e) {
            out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Error login desde Base de Datos</p></h5>");
        } finally {
            out.close();
        }
    }
    //método encargado de la gestión del método GET

    protected void processRequestGET(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //me llega la url "proyecto/login/out"
//        String action = (request.getPathInfo() != null ? request.getPathInfo() : "");
//        HttpSession sesion = request.getSession();
//        if (action.equals("/out")) {
//            sesion.invalidate();
//            response.sendRedirect("/index.jsp");
//        } else {
//        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequestGET(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequestPOST(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
