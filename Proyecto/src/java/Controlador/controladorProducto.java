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
            htmlcode += "<div class=\"col-sm-4\">\n"
                    + "							<div class=\"product-image-wrapper\">\n"
                    + "								<div class=\"single-products\">\n"
                    + "									<div class=\"productinfo text-center\">\n"
                    + "										<img src=\"" + producto.getFOTO() + "\" alt=\"\" />\n"
                    + "										<h2>$" + producto.getPRECIOVENTA() + "</h2>\n"
                    + "										<p>" + producto.getDESCRIPCION() + "</p>\n"
                    + "										<a href=\"product-details.jsp?id=" + producto.getID_PRODUCTO() + "\" class=\"btn btn-default add-to-cart\"><i class=\"fa fa-shopping-cart\"></i>Ver detalles</a>\n"
                    + "									</div>\n"
                    + "									<div class=\"product-overlay\">\n"
                    + "										<div class=\"overlay-content\">\n"
                    + "											<h2>$" + producto.getPRECIOVENTA() + "</h2>\n"
                    + "											<p>" + producto.getDESCRIPCION() + "</p>\n"
                    + "											<a href=\"product-details.jsp?id=" + producto.getID_PRODUCTO()+ "\" class=\"btn btn-default add-to-cart\"><i class=\"fa fa-shopping-cart\"></i>Ver Detalles</a>\n"
                    + "										</div>\n"
                    + "									</div>\n"
                    + "								</div>\n"
                    + "								<div class=\"choose\">\n"
                    + "									<ul class=\"nav nav-pills nav-justified\">\n"
                    + "										<li><a href=\"\"><i class=\"fa fa-plus-square\"></i>Add to wishlist</a></li>\n"
                    + "										<li><a href=\"\"><i class=\"fa fa-plus-square\"></i>Add to compare</a></li>\n"
                    + "									</ul>\n"
                    + "								</div>\n"
                    + "							</div>\n"
                    + "						</div>";
        }
        return htmlcode;
    }

    public Producto getProducto(int id) {
        return new OperacionesProducto().getProducto(id);
    }
}