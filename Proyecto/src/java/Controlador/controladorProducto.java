/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

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
import modelo.Idioma;

/**
 *
 * @author DesarrolloPantaleon
 */
@WebServlet(name = "controladorProducto", urlPatterns = {"/controladorProducto"})
public class controladorProducto extends HttpServlet {

    public String getProductos(String tipo, String idi) {
        OperacionesProducto mp = new OperacionesProducto();
        Idioma idioma = new Idioma(idi);
        String htmlcode = "";
        try {
            for (Producto producto : mp.getAllProductos(tipo)) {
                htmlcode += "                                    <div class=\"4u 12u(narrower)\">\n"
                        + "                                <section class=\"box special\">\n";
                if (producto.getFOTO() != null || producto.getFOTO().length() == 0) {
                    htmlcode += "                                    <span class=\"image featured\"><img src=\"" + producto.getFOTO() + "\" alt=\"" + producto.getTIPO() + " onerror=\"Error_Cargar()/></span>\n";
                } else {
                    htmlcode += "                                    <span class=\"image featured\"><img src=\"images/404.png\" alt=\"Sin Muebles\" onerror=\"Error_Cargar() /></span>\n";
                }
                htmlcode += "                                    <h3>" + producto.getNOMBRE() + "</h3>                                                <ul class=\"actions\">\n"
                        + "                                        <a href=\"detalleproducto.jsp?id=" + producto.getID_PRODUCTO() + "#main\" class= \"button\" >" + idioma.getProperty("VERDETALLES") + "</a>\n"
                        + "                                    </ul>\n"
                        + "                                </section></div>";
            }
        } catch (SQLException e) {
            System.out.println("Error :" + e);
        }
        //System.out.println("h: " + htmlcode);
        return htmlcode;

    }

    public Producto getProducto(int id) {

        Producto p = new Producto();
        OperacionesProducto op = new OperacionesProducto();

        try {
            p = op.getProducto(id);
        } catch (SQLException e) {
            System.out.println("Error :" + e);
        }
        return p;
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
                HttpSession sesion = request.getSession();
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
                try {
                    producto.setPRECIOVENTA(Double.valueOf((request.getParameter("PRECIOVENTA")).replaceAll(",", "")));
                } catch (Exception e) {
                    sesion.setAttribute("resOper", "<h5 style=' color:red; font-weight:bold;' ><p>" + "FORMATO INCORRECTO EN EL PRECIO DE VENTA" + "</p></h5>");
                    response.sendRedirect("mantenimientosInterfaz.jsp?Operacion=1#ResultadoNuevoProducto");
                }

                String respuesta = opproducto.insertarProducto(producto);
                if (respuesta.equals("")) {
                    sesion.setAttribute("resOper", "out.write(\"<h5 style=\\\" color:red; font-weight:bold;\\\"><p> FALLO AL INSERTAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>\");\n");
                } else {

                    sesion.setAttribute("resOper", "<h5 style=' color:blue; font-weight:bold;' ><p>" + respuesta + "</p></h5>");
                    response.sendRedirect("mantenimientosInterfaz.jsp?Operacion=1#ResultadoNuevoProducto");
                }
                //}
            } else if (request.getParameter("EnviarMP") != null) {
                HttpSession sesion = request.getSession();
                producto.setID_PRODUCTO(Integer.valueOf(request.getParameter("idprod")));
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
                try {
                    producto.setPRECIOVENTA(Double.valueOf((request.getParameter("PRECIOVENTA")).replaceAll(",", "")));
                } catch (Exception e) {
                    sesion.setAttribute("resOper", "<h5 style=' color:red; font-weight:bold;' ><p>" + "FORMATO INCORRECTO EN EL PRECIO DE VENTA" + "</p></h5>");
                    response.sendRedirect("mantenimientosInterfaz.jsp?Operacion=2&idProd=" + producto.getID_PRODUCTO() + "#ResultadoUpdateProducto");
                }

                String respuesta = opproducto.modificarProducto(producto);
                if (respuesta.equals("")) {
                    sesion.setAttribute("resOper", "out.write(\"<h5 style=\\\" color:red; font-weight:bold;\\\"><p> FALLO AL INSERTAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>\");\n");
                } else {
                    sesion.setAttribute("resOper", "<h5 style=' color:blue; font-weight:bold;' ><p>" + respuesta + "</p></h5>");
                    response.sendRedirect("mantenimientosInterfaz.jsp?Operacion=2&idProd=" + producto.getID_PRODUCTO() + "#ResultadoUpdateProducto");
                }
            }
        } catch (Exception e) {
            out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Error desde Base de Datos</p></h5>");
            e.printStackTrace();
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
