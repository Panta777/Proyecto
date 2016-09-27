/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import ClasesGenericas.Cliente;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.OperacionesCliente;

/**
 *
 * @author panle
 */
@WebServlet(name = "controladorCliente", urlPatterns = {"/controladorCliente"})
public class controladorCliente extends HttpServlet {

    //metodo encargado de la gestión del método POST
    protected void processRequestPOST(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            /*  
             *     private int ID_CLIENTE;
             private String NUMERO_DOC;
             private String NOMBRE;
             private String APELLIDO;
             private String TEL_RESIDENCIA;
             private String TEL_CEL;
             private String NIT;
             private String DIRECCION;
             private String PAIS;
             private String DEPARTAMENTO;
             private String PROFESION;
             private String EMAIL;
             private String FECHA_ALTA;
             private String FECHA_BAJA;
             private String CUENTA_BANCO;
             private String NUMERO_TARJETA;
             private int ESTADO;
             private int ID_USUARIO;
             private int idbanco;
             private int identidad;
             private int Iddepartamento;
             private String IdTarjeta;
             * @return      * 1 = exitoso
             * 2 = usuario ya existe
             * 3 =  error al procesar datos
             * 4 = ?
             * @throws java.sql.SQLException
             */
            OperacionesCliente opcliente = new OperacionesCliente();
            Cliente cliente = new Cliente();

            if (request.getParameter("Enviar") != null) {
                cliente.setNOMBRE(request.getParameter("FName"));

                HttpSession sesion = request.getSession();
                switch (opcliente.insertarCliente(usu, contra)) {
                    case 1:
                        sesion.setAttribute("user", usu);
                        sesion.setAttribute("nivel", "1");
                        response.sendRedirect("index.jsp");

                        break;

                    case 2:
                        sesion.setAttribute("user", usu);
                        sesion.setAttribute("nivel", "2");
                        response.sendRedirect("generic.jsp");

                        break;

                    default:
                        out.write("Usuario no existe, o contraseña invalida");
                        break;
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
