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
//                    cliente.setTIPODOCUMENTO(request.getParameter("TipoDoc"));
                    cliente.setNUMERO_DOC(request.getParameter("NoDoc"));
                    cliente.setTEL_RESIDENCIA(request.getParameter("TelRes"));
                    cliente.setTEL_CEL(request.getParameter("TelCel"));
                    cliente.setNIT(request.getParameter("Nit"));
                    cliente.setDIRECCION(request.getParameter("Direccion"));
                    cliente.setCIUDAD(request.getParameter("Ciudad"));
                    cliente.setIddepartamento(Integer.valueOf(request.getParameter("Departamento")));
                    cliente.setPAIS(request.getParameter("Pais"));
                    cliente.setPROFESION(request.getParameter("Profesion"));
                    cliente.setEMAIL(request.getParameter("email"));
                    cliente.setUSUARIO(request.getParameter("usuario"));
                    cliente.setCONTRASENA(request.getParameter("pass"));

                    HttpSession sesion = request.getSession();
//                    String respuesta = opcliente.insertarUsuarioDB(cliente.getUSUARIO(), cliente.getCONTRASENA());
//                    if (respuesta.equals("")) {
//                        sesion.setAttribute("resOper", "out.write(\"<h5 style=\\\" color:red; font-weight:bold;\\\"><p> FALLO AL INSERTAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>\");\n");
//                    } else {
                    String respuesta = opcliente.insertarCliente(cliente);

                    if (respuesta.equals("")) {
                        // sesion.setAttribute("resOper", "<h5 style=' color:blue; font-weight:bold;' ><p>" + respuesta + "</p></h5>");
                        sesion.setAttribute("resOper", "<h5 style=\\\" color:red; font-weight:bold;\\\"><p> FALLO AL INSERTAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>;\n");
                        response.sendRedirect("nuevoCliente.jsp#ResultadoNuevoCliente");
                    } else {
                        sesion.setAttribute("resOper", "<h5 style=' color:blue; font-weight:bold;' ><p>" + respuesta + "</p></h5>");
                        response.sendRedirect("nuevoCliente.jsp#ResultadoNuevoCliente");
                    }

                }
            } else if (request.getParameter("modificaCliente") != null) {

                cliente.setID_CLIENTE(Integer.valueOf(request.getParameter("idcliente")));
                cliente.setNOMBRE(request.getParameter("FName"));
                cliente.setAPELLIDO(request.getParameter("LName"));
                cliente.setTIPODOCUMENTO(request.getParameter("TipoDoc"));
                cliente.setNUMERO_DOC(request.getParameter("NoDoc"));
                cliente.setTEL_RESIDENCIA(request.getParameter("TelRes"));
                cliente.setTEL_CEL(request.getParameter("TelCel"));
                cliente.setNIT(request.getParameter("Nit"));
                cliente.setDIRECCION(request.getParameter("Direccion"));
                cliente.setCIUDAD(request.getParameter("Ciudad"));
                cliente.setPROFESION(request.getParameter("Profesion"));
                cliente.setEMAIL(request.getParameter("email"));

                HttpSession sesion = request.getSession();
                String respuesta = opcliente.ModificarCliente(cliente);

                if (respuesta.equals("")) {
                    sesion.setAttribute("resOper", "<h5 style=\\\" color:red; font-weight:bold;\\\"><p> FALLO AL INSERTAR LOS DATOS, VERIFIQUE E INTENTE NUEVAMENTE</p></h5>;\n");
                    response.sendRedirect("modificaCliente.jsp#main");
                } else {
                    sesion.setAttribute("resOper", "<h5 style=' color:blue; font-weight:bold;' ><p>" + respuesta + "</p></h5>");
                    response.sendRedirect("modificaCliente.jsp#main");
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
