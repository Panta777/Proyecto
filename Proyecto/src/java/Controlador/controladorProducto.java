/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import ClasesGenericas.Cliente;
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
import modelo.OperacionesCliente;
import modelo.OperacionesProducto;


/**
 *
 * @author DesarrolloPantaleon
 */
@WebServlet(name = "controladorProducto", urlPatterns = {"/controladorProducto"})
public class controladorProducto extends HttpServlet{ 

    public String getProductos(String tipo) {
        OperacionesProducto mp = new OperacionesProducto();
        String htmlcode = "";
        for (Producto producto : mp.getAllProductos(tipo)) {
            htmlcode += "                                    <div class=\"4u 12u(narrower)\">\n"
                    + "                                <section class=\"box special\">\n"
                    + "                                    <span class=\"image featured\"><img src=\"" + producto.getFOTO() + "\" alt=\"Muebles Tradicionales\" /></span>\n"
                    + "                                    <h3>" + producto.getNOMBRE()+ "</h3>                                                <ul class=\"actions\">\n"
                    + "                                        <li><a href=\"detalleproducto.jsp?id=" + producto.getID_PRODUCTO() + "#main\" class= \"button \" >VER DETALLES</a></li>\n"
                    + "                                    </ul>\n"
                    + "                                </section></div>";
        }
        if(htmlcode.equals(""))
        {
            htmlcode = "<h3>NO HAY MUEBLES EN ESTA CATEGORIA</h3> ";
            htmlcode += "<span class=\"image featured\"><img src=\"images/404.png\" alt=\"Sin Muebles\" /></span>\n ";
        }
        //System.out.println("Resultado:" + htmlcode);
        return htmlcode;

    }

    public Producto getProducto(int id) {
        return new OperacionesProducto().getProducto(id);
    }
}
