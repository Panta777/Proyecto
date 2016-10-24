/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import ClasesGenericas.Producto;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.GenerarPDF;
import modelo.OperacionesCliente;
import javax.ws.rs.core.Context;

/**
 *
 * @author panle
 */
@WebServlet(name = "report", urlPatterns = {"/report"})
public class Reporte extends HttpServlet {

    //metodo encargado de la gestión del método POST
    protected void processRequestPOST(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        String serverHomeDir = System.getenv("CATALINA_HOME");
        //  String reportDestination = serverHomeDir + "/Reports/" + user + "_" + church + "_" + currdate + ".pdf";
        String reportDestination = serverHomeDir + "/Reports/algo.pdf";

        FileInputStream fis = new FileInputStream(new File(reportDestination));

        // Fast way to copy a bytearray from InputStream to OutputStream
//        org.apache.commons.io.IOUtils.copy(fis, response.getOutputStream());
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=" + reportDestination);
        response.flushBuffer();
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
    public void doGet(HttpServletRequest request,
            HttpServletResponse response) throws IOException {
//        response.setContentType("application/pdf");
//        response.setHeader("Content-Disposition",
//                "attachment;filename=ReporteProductos.pdf");
//        ServletContext ctx = getServletContext();
//        InputStream is = ctx.getResourceAsStream("ReporteProductos.pdf");
//
//        int read = 0;
//        byte[] bytes = new byte[1024];
//        OutputStream os = response.getOutputStream();
//
//        while ((read = is.read(bytes)) != -1) {
//            os.write(bytes, 0, read);
//        }
//        os.flush();
//        os.close();

//Crean el HSSFWorkbook y todo lo que vaya en él (hay mucha info en la web para hacer esto)
// Escribir la hoja xls
//        hlo_libro.write(hlo_sOut);
//        hlo_sOut.flush();
//        hlo_sOut.close();
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
