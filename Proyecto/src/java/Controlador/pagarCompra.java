/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import ClasesGenericas.Compra;
import modelo.OperacionesProducto;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "pagarCompra", urlPatterns = {"/pagarCompra"})
public class pagarCompra extends HttpServlet {

    //agregarproducto
    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        int idproducto = Integer.parseInt(request.getParameter("idproducto"));

        HttpSession sesion = request.getSession(true);
        ArrayList<Compra> articulos = sesion.getAttribute("carrito") == null ? new ArrayList<>() : (ArrayList) sesion.getAttribute("carrito");

        OperacionesProducto opInventario = new OperacionesProducto();


        boolean flag = false;
        if (articulos.size() > 0) {
            for (Compra a : articulos) {
                if (idproducto == a.getIdProducto()) {
                    if (opInventario.validarInventario(idproducto, cantidad)) {
                        System.out.println("si procede");
                        a.setCantidad(a.getCantidad() + cantidad);
                        flag = true;
                        break;
                    } else {
                        System.out.println("no procede venta");
                        sesion.setAttribute("NoInventario", "NO");
                        response.sendRedirect("detalleproducto.jsp?id=" + idproducto + "#noAlcanzaInventario");
                        break;
                    }
                }
            }
        }

        if (!flag) {
            articulos.add(new Compra(idproducto, cantidad));
        }

        sesion.setAttribute("carrito", articulos);
        response.sendRedirect("productosCarrito.jsp#OrdenCompra");

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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(pagarCompra.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(pagarCompra.class.getName()).log(Level.SEVERE, null, ex);
        }
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
