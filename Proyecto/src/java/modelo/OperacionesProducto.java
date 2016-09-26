/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import ClasesAbstractas.Producto;
import java.sql.*;
import java.util.ArrayList;

/**
 * @author panle
 */
public class OperacionesProducto {

    
    private  Conexion coneLocal;

    public OperacionesProducto() {
        this.coneLocal = new Conexion();
    }

    /**
     * Retorna el listado de productos existentes 
     * @return 
     * @throws java.sql.SQLException
     * @
     */
      public ArrayList<Producto> getAllProductos()throws SQLException {
        ArrayList<Producto> productos = new ArrayList<>();
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String sql = "call selectProductos()";
            pst = coneLocal.getNewConnection().prepareCall(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                productos.add(new Producto(rs.getInt("id_producto"), rs.getString("nombre"), rs.getString("img_producto"), rs.getInt("id_categoria"), rs.getDouble("precio"), rs.getInt("stock")));
            }
        } catch (Exception e) {

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (coneLocal.getNewConnection() != null) {
                    coneLocal.getNewConnection().close();
                }
            } catch (Exception e) {
            }
        }
        return productos;
    }

    public Producto getProducto(int id) {
        Producto producto = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String sql = "call selectProducto(?)";
            pst = coneLocal.getNewConnection().prepareCall(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                producto = new Producto(rs.getInt("id_producto"), rs.getString("nombre"), rs.getString("img_producto"), rs.getInt("id_categoria"), rs.getDouble("precio"), rs.getInt("stock"));
            }
        } catch (Exception e) {

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (coneLocal.getNewConnection() != null) {
                    coneLocal.getNewConnection().close();
                }
            } catch (Exception e) {
            }
        }
        return producto;
    }

}
