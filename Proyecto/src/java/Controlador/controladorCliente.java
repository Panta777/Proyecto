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
    //Recibe los parametros de la paginas para el mantenimiento del Cliente
    protected void processRequestPOST(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            OperacionesCliente opcliente = new OperacionesCliente();
            Cliente cliente = new Cliente();
            
            if (request.getParameter("EnviaCliente") != null) {
                if (request.getParameter("pass") == null ? request.getParameter("pass2") != null : !request.getParameter("pass").equals(request.getParameter("pass2"))) {
                    response.sendRedirect("nuevoCliente.jsp");
                } else {
                    cliente.setNOMBRE(request.getParameter("FName"));
                    cliente.setAPELLIDO(request.getParameter("LName"));
                    cliente.setTIPODOCUMENTO(request.getParameter("TipoDoc"));
                    cliente.setNUMERO_DOC(request.getParameter("NoDoc"));
                    cliente.setTEL_RESIDENCIA(request.getParameter("TelRes"));
                    cliente.setTEL_CEL(request.getParameter("TelCel"));
                    cliente.setNIT(request.getParameter("Nit"));
                    cliente.setDIRECCION(request.getParameter("Direccion"));
                    cliente.setCIUDAD(request.getParameter("Ciudad"));
                    cliente.setDEPARTAMENTO(request.getParameter("Departamento"));
                    cliente.setPAIS(request.getParameter("Pais"));
                    cliente.setPROFESION(request.getParameter("Profesion"));
                    cliente.setEMAIL(request.getParameter("email"));
                    cliente.setUSUARIO(request.getParameter("usuario"));
                    cliente.setCONTRASENA(request.getParameter("pass"));
                    
                    HttpSession sesion = request.getSession();
                    switch (opcliente.insertarCliente(cliente)) {
                        case 1:
//                            sesion.setAttribute("user", usu);//                            sesion.setAttribute("nivel", "1");
                            System.out.println("Prueba Inserta");
                            System.out.println("Exito");
                            response.sendRedirect("login.jsp");
                            break;
                        default:
                            sesion.setAttribute("resOper", "2");
                            response.sendRedirect("nuevoCliente.jsp");
                            break;
                    }
                }
            } else if (request.getParameter("modificaCliente") != null) {
                if (request.getParameter("pass") == null ? request.getParameter("pass2") != null : !request.getParameter("pass").equals(request.getParameter("pass2"))) {
                    response.sendRedirect("modificarCliente.jsp");
                } else {
                    cliente.setNOMBRE(request.getParameter("FName"));
                    cliente.setAPELLIDO(request.getParameter("LName"));
                    cliente.setTIPODOCUMENTO(request.getParameter("TipoDoc"));
                    cliente.setNUMERO_DOC(request.getParameter("NoDoc"));
                    cliente.setTEL_RESIDENCIA(request.getParameter("TelRes"));
                    cliente.setTEL_CEL(request.getParameter("TelCel"));
                    cliente.setNIT(request.getParameter("Nit"));
                    cliente.setDIRECCION(request.getParameter("Direccion"));
                    //cliente.setCIUDAD(request.getParameter("Ciudad"));
                    cliente.setDEPARTAMENTO(request.getParameter("Departamento"));
                    cliente.setPAIS(request.getParameter("Pais"));
                    cliente.setPROFESION(request.getParameter("Profesion"));
                    cliente.setEMAIL(request.getParameter("email"));
                    cliente.setUSUARIO(request.getParameter("usuario"));
                    cliente.setCONTRASENA(request.getParameter("pass"));
                    
                    HttpSession sesion = request.getSession();
                    switch (opcliente.insertarCliente(cliente)) {
                        case 1:
//                            sesion.setAttribute("user", usu);//                            sesion.setAttribute("nivel", "1");
                            System.out.println("Prueba Modificacion");
                            System.out.println("Exito");
                            sesion.setAttribute("resOper", "1");
                            break;
                        default:
                            sesion.setAttribute("resOper", "2");
                            break;
                    }
                    response.sendRedirect("modificaCliente.jsp");
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
