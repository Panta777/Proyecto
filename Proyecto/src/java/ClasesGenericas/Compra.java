/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesGenericas;

/**
 *
 * @author panle
 */
public class Compra {

    public Compra(int idProducto, int cantidad, double precio_u, double precio_t) {
        this.idProducto = idProducto;
        this.cantidad = cantidad;
        this.precio_u = precio_u;
        this.precio_t = precio_t;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecio_u() {
        return precio_u;
    }

    public void setPrecio_u(double precio_u) {
        this.precio_u = precio_u;
    }

    public double getPrecio_t() {
        return precio_t;
    }

    public void setPrecio_t(double precio_t) {
        this.precio_t = precio_t;
    }
    
    private int idProducto;
    private int cantidad;
    private double precio_u;
    private double precio_t;

    public Compra(int idProducto, int cantidad) {
        this.idProducto = idProducto;
        this.cantidad = cantidad;
       // this.prod = prod;
    }

    
    
}
