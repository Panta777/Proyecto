/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

    //metodo encargado de la gestión del método POST
    protected void processRequestPOST(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            Operaciones op = new Operaciones();
            if (request.getParameter("Enviar") != null && request.getParameter("user") != null && request.getParameter("password") != null) {
                String usu = request.getParameter("user");
                String contra = request.getParameter("password");
                HttpSession sesion = request.getSession();
                switch (op.loguear(usu, contra)) {
                    case 1:
                        sesion.setAttribute("user", usu);
                        sesion.setAttribute("nivel", "1");
                        response.sendRedirect("index.jsp");
                        break;
                    case 2:
                        sesion.setAttribute("user", usu);
                        sesion.setAttribute("nivel", "2");
                        response.sendRedirect("index.jsp");
                        break;
                    case 3:
                        sesion.setAttribute("user", usu);
                        sesion.setAttribute("nivel", "3");
                        response.sendRedirect("login.jsp");
                        break;
                    default:
                        sesion.setAttribute("user", usu);
                        sesion.setAttribute("nivel", "4");
                        response.sendRedirect("login.jsp");
                        break;
                }
            }
        } catch(SQLException e)
        {
            out.write("<h5 style=\" color:red; font-weight:bold;\"><p> Error login desde Base de Datos</p></h5>");
        }finally {
            out.close();
        }
    }

    //método encargado de la gestión del método GET
    protected void processRequestGET(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //me llega la url "proyecto/login/out"
        String action = (request.getPathInfo() != null ? request.getPathInfo() : "");
        HttpSession sesion = request.getSession();
        if (action.equals("/out")) {
            sesion.invalidate();
            response.sendRedirect("/index.jsp");
        } else {
        }
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
