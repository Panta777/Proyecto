/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import ClasesGenericas.Producto;
import modelo.OperacionesProducto;

/**
 *
 * @author DesarrolloPantaleon
 */
public class controladorProducto {

    public String getProductos() {
        OperacionesProducto mp = new OperacionesProducto();
        String htmlcode = "";
        for (Producto producto : mp.getAllProductos()) {
            htmlcode += "                                    <div class=\"4u 12u(narrower)\">\n"
                    + "                                <section class=\"box special\">\n"
                    + "                                    <span class=\"image featured\"><img src=\"" + producto.getFOTO() + "\" alt=\"Muebles Tradicionales\" /></span>\n"
                    + "                                    <h3>" + producto.getNOMBRE()+ "</h3>                                                <ul class=\"actions\">\n"
                    + "                                        <li><a href=\"detalleproducto.jsp?id=" + producto.getID_PRODUCTO() + "#main\" class= \"button \" >VER DETALLES</a></li>\n"
                    + "                                    </ul>\n"
                    + "                                </section></div>";
        }
        //System.out.println("Resultado:" + htmlcode);
        return htmlcode;

    }

    public Producto getProducto(int id) {
        return new OperacionesProducto().getProducto(id);
    }
}
