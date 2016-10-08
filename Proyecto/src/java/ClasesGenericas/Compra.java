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
    
    private int idProducto;
    private int cantidad;
    private Producto prod;

    public Compra(int idProducto, int cantidad, Producto prod) {
        this.idProducto = idProducto;
        this.cantidad = cantidad;
        this.prod = prod;
    }
    
    public Producto getProd() {
        return prod;
    }

    public void setProd(Producto prod) {
        this.prod = prod;
    }
    /**
     * @return the idProducto
     */
    public int getIdProducto() {
        return idProducto;
    }

    /**
     * @param idProducto the idProducto to set
     */
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    /**
     * @return the cantidad
     */
    public int getCantidad() {
        return cantidad;
    }

    /**
     * @param cantidad the cantidad to set
     */
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
    
}
