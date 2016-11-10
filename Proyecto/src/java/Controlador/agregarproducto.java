/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import ClasesGenericas.Compra;
import modelo.OperacionesProducto;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author panle
 */
@WebServlet(name = "agregarproducto", urlPatterns = {"/agregarproducto"})
public class agregarproducto extends HttpServlet {

    //agregarproducto
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

        int cantidad = 0;
        int idproducto = idproducto = Integer.parseInt(request.getParameter("idproducto"));;

        HttpSession sesion = request.getSession(true);
        ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? new ArrayList<>() : (ArrayList) sesion.getAttribute("carrito");
        String r, r2 = "";
        try {
            cantidad = Integer.parseInt(request.getParameter("cantidad"));

        } catch (Exception e) {
            System.out.println("Error al dar formato: " + e);
            sesion.setAttribute("NoInventario", "INGRESE UNA CANTIDAD PARA AGREGAR EN EL CARRITO");
            response.sendRedirect("detalleproducto.jsp?id=" + idproducto + "#noAlcanzaInventario");
            return;
        }

        OperacionesProducto opInventario = new OperacionesProducto();

        try {
            boolean flag = false;
            r = opInventario.validarInventario(idproducto, cantidad);
            if (r.contains("PRODUCTO DISPONIBLE EN STOCK")) {

                if (articulos.size() > 0) {
                    for (Compra a : articulos) {
                        if (idproducto == a.getIdProducto()) {
                            a.setCantidad(a.getCantidad() + cantidad);
                            flag = true;
                            break;
                        }
                    }
                }
                if (!flag) {
                    articulos.add(new Compra(idproducto, cantidad));
                }

                if (!opInventario.actualizarInventario(idproducto, cantidad, "AGREGAR")) {
                    sesion.setAttribute("NoInventario", "Error al procesar transaccion, intente nuevamente");
                    response.sendRedirect("detalleproducto.jsp?id=" + idproducto + "#noAlcanzaInventario");
                    return;
                }

            } else {
                sesion.setAttribute("NoInventario", r);
                response.sendRedirect("detalleproducto.jsp?id=" + idproducto + "#noAlcanzaInventario");
                return;
            }

            sesion.setAttribute("carrito", articulos);
            response.sendRedirect("productosCarrito.jsp#OrdenCompra");

        } catch (SQLException e) {
            System.out.println("Error:" + e);
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
        //     try {
        processRequest(request, response);
        //     } catch (SQLException ex) {
        //   Logger.getLogger(agregarproducto.class.getName()).log(Level.SEVERE, null, ex);
        //  }
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
        // try {
        processRequest(request, response);
        //} catch (SQLException ex) {
        //  Logger.getLogger(agregarproducto.class.getName()).log(Level.SEVERE, null, ex);
        //}
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Agregando Producto";
    }// </editor-fold>
}
