/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import ClasesGenericas.Compra;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.OperacionesProducto;

/**
 *
 * @author panle
 */
@WebServlet(name = "EliminarProductoCarrito", urlPatterns = {"/EliminarProductoCarrito"})
public class EliminarProductoCarrito extends HttpServlet {

    //borraritem
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesion = request.getSession(true);
        if (request.getParameter("addprodcart") != null) {

            int idproducto = Integer.parseInt(request.getParameter("idproducto"));
            // int cant = Integer.parseInt(request.getParameter("cantidad"));
            //System.out.println("Id: " + idproducto);

            ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
            //OperacionesProducto opInventario = new OperacionesProducto();
            try {
                if (articulos != null) {
                    for (Compra a : articulos) {
                        if (a.getIdProducto() == idproducto) {
                            articulos.remove(a);
                            break;
                        }
                    }

                }
                sesion.setAttribute("carrito", articulos);
                response.sendRedirect("productosCarrito.jsp#OrdenCompra");
            } catch (Exception e) {
                System.out.println("Error:" + e);
            }

        } else if (request.getParameter("ELIMINAR") != null) {
            int idproducto = 0;
            if (request.getParameter("prodEli") != null) {
                idproducto = Integer.parseInt(request.getParameter("prodEli"));
            }

            OperacionesProducto opInventario = new OperacionesProducto();

            try {
                boolean flag = false;
                String r = opInventario.eliminarProducto(idproducto);
                if (r.toUpperCase().contains("EXITO")) {

                } else {
                    sesion.setAttribute("NoInventario", r);
                    response.sendRedirect("detalleproducto.jsp?id=" + idproducto + "#noAlcanzaInventario");
                    return;
                }

//                sesion.setAttribute("carrito", articulos);
//                response.sendRedirect("productosCarrito.jsp#OrdenCompra");

            } catch (SQLException e) {
                System.out.println("Error:" + e);
            }
            //System.out.println("Id: " + idproducto);
//
//            ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? null : (ArrayList) sesion.getAttribute("carrito");
//            //OperacionesProducto opInventario = new OperacionesProducto();
//            try {
//                if (articulos != null) {
//                    for (Compra a : articulos) {
//                        if (a.getIdProducto() == idproducto) {
//                            articulos.remove(a);
//                            break;
//                        }
//                    }
//
//                }
//                sesion.setAttribute("carrito", articulos);
//                response.sendRedirect("productosCarrito.jsp#OrdenCompra");
//            } catch (Exception e) {
//                System.out.println("Error:" + e);
//            }
        }
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
        processRequest(request, response);
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
        processRequest(request, response);
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
