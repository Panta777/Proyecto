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
public class controladorProducto extends HttpServlet {

    public String getProductos(String tipo) {
        OperacionesProducto mp = new OperacionesProducto();
        String htmlcode = "";
        for (Producto producto : mp.getAllProductos(tipo)) {
            htmlcode += "                                    <div class=\"4u 12u(narrower)\">\n"
                    + "                                <section class=\"box special\">\n"
                    + "                                    <span class=\"image featured\"><img src=\"" + producto.getFOTO() + "\" alt=\"Muebles Tradicionales\" /></span>\n"
                    + "                                    <h3>" + producto.getNOMBRE() + "</h3>                                                <ul class=\"actions\">\n"
                    + "                                        <li><a href=\"detalleproducto.jsp?id=" + producto.getID_PRODUCTO() + "#main\" class= \"button \" >VER DETALLES</a></li>\n"
                    + "                                    </ul>\n"
                    + "                                </section></div>";
        }
        if (htmlcode.equals("")) {
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

                producto.setREFERENCIA(request.getParameter("in_REFERENCIA"));
                producto.setNOMBRE(request.getParameter("in_NOMBRE"));
                producto.setDESCRIPCION(request.getParameter("in_DESCRIPCION"));
                producto.setTIPO(request.getParameter("in_TIPO"));
                producto.setMATERIAL(request.getParameter("in_MATERIAL"));
                producto.setALTO(request.getParameter("in_ALTO"));
                producto.setANCHO(request.getParameter("in_ANCHO"));
                producto.setPROFUNDIDAD(request.getParameter("in_PROFUNDIDAD"));
                producto.setCOLOR(request.getParameter("in_COLOR"));
                producto.setPESO(request.getParameter("in_PESO"));
                producto.setFOTO(request.getParameter("in_FOTO"));
                producto.setESTADO(request.getParameter("ESTADO"));
                producto.setPRECIOVENTA(Double.valueOf(request.getParameter("PRECIOVENTA")));

                HttpSession sesion = request.getSession();
                String respuesta = opproducto.insertarProducto(producto);
                if (respuesta.equals("")) {
                    sesion.setAttribute("resOper", "out.write(\"<h5 style=\\\" color:red; font-weight:bold;\\\"><p> FALLO AL INSERTAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>\");\n");
                } else {

                    sesion.setAttribute("resOper", "<h5 style=' color:blue; font-weight:bold;' ><p>" + respuesta + "</p></h5>");
                    response.sendRedirect("nuevoProducto.jsp#ResultadoNuevoProducto");
                }
                //}
            } else if (request.getParameter("EnviarMP") != null) {
//                if (request.getParameter("pass") == null ? request.getParameter("pass2") != null : !request.getParameter("pass").equals(request.getParameter("pass2"))) {
//                    response.sendRedirect("modificarProducto.jsp");
//                } else {
                    producto.setREFERENCIA(request.getParameter("in_REFERENCIA"));
                    producto.setNOMBRE(request.getParameter("in_NOMBRE"));
                    producto.setDESCRIPCION(request.getParameter("in_DESCRIPCION"));
                    producto.setTIPO(request.getParameter("in_TIPO"));
                    producto.setMATERIAL(request.getParameter("in_MATERIAL"));
                    producto.setALTO(request.getParameter("in_ALTO"));
                    producto.setANCHO(request.getParameter("in_ANCHO"));
                    producto.setPROFUNDIDAD(request.getParameter("in_PROFUNDIDAD"));
                    producto.setCOLOR(request.getParameter("in_COLOR"));
                    producto.setPESO(request.getParameter("in_PESO"));
                    producto.setFOTO(request.getParameter("in_FOTO"));
                    producto.setESTADO(request.getParameter("ESTADO"));
                    producto.setPRECIOVENTA(Double.valueOf(request.getParameter("PRECIOVENTA")));


                  HttpSession sesion = request.getSession();
                String respuesta = opproducto.insertarProducto(producto);
                if (respuesta.equals("")) {
                    sesion.setAttribute("resOper", "out.write(\"<h5 style=\\\" color:red; font-weight:bold;\\\"><p> FALLO AL INSERTAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>\");\n");
                } else {

                    sesion.setAttribute("resOper", "<h5 style=' color:blue; font-weight:bold;' ><p>" + respuesta + "</p></h5>");
                    response.sendRedirect("nuevoProducto.jsp#ResultadoNuevoProducto");
                }
                    response.sendRedirect("modificaProducto.jsp");
                }
            //}
        } catch (SQLException e) {
            out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Error desde Base de Datos</p></h5>");
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
     * Handles the HTTP
     * <code>GET</code> method.
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
     * Handles the HTTP
     * <code>POST</code> method.
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
