/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import ClasesGenericas.Producto;
import java.sql.*;
import java.util.ArrayList;

/**
 * @author panle
 */
public class OperacionesProducto {

    private Conexion coneLocal;

    public OperacionesProducto() {
        this.coneLocal = new Conexion();
    }

    /**
     *
     * @return Retorna el listado de productos existentes, se debe agregarlos a
     * un listado de productos
     * @throws java.sql.SQLException
     * @
     */
    public ArrayList<Producto> getAllProductos(int tipo) {
        ArrayList<Producto> productos = new ArrayList<>();
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            //   String sql = "call selectProductos()";//SELECT * FROM PRODUCTO
            String sql = "SELECT * FROM PRODUCTO WHERE TIPO = '" + tipo + "'";//
            System.out.println("Query:" + sql);
            pst = coneLocal.NewConnection().prepareCall(sql);
            rs = pst.executeQuery();
            while (rs.next()) {

                productos.add(new Producto(rs.getInt("ID_PRODUCTO"),
                        rs.getString("NOMBRE"),
                        rs.getString("REFERENCIA"),
                        rs.getString("DESCRIPCION"),
                        rs.getString("TIPO"),
                        rs.getString("MATERIAL"),
                        rs.getString("ALTO"),
                        rs.getString("ANCHO"),
                        rs.getString("PROFUNDIDAD"),
                        rs.getString("COLOR"),
                        rs.getString("PESO"),
                        rs.getString("FOTO"),
                        rs.getString("FECHA_ALTA"),
                        rs.getString("FECHA_BAJA"),
                        rs.getString("ESTADO"),
                        rs.getDouble("PRECIO_VENTA")));
            }
        } catch (SQLException e) {
            System.out.println("Error en getAllProductos()" + e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (coneLocal.NewConnection() != null) {
                    coneLocal.NewConnection().close();
                }
            } catch (Exception e) {
            }
        }
        return productos;
    }

    /**
     *
     * @param id
     * @return el detalle de un producto en específico
     * @throws java.sql.SQLException
     * @
     */
    public Producto getProducto(int id) {
        Producto producto = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            // String sql = "call selectProducto(?)";
            String sql = "SELECT * FROM PRODUCTO WHERE ID_PRODUCTO = '" + id + "'";
            System.out.println("Consulta producto: " + sql);
            pst = coneLocal.NewConnection().prepareCall(sql);
            //  pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                producto = new Producto(rs.getInt("ID_PRODUCTO"),
                        rs.getString("NOMBRE"),
                        rs.getString("REFERENCIA"),
                        rs.getString("DESCRIPCION"),
                        rs.getString("TIPO"),
                        rs.getString("MATERIAL"),
                        rs.getString("ALTO"),
                        rs.getString("ANCHO"),
                        rs.getString("PROFUNDIDAD"),
                        rs.getString("COLOR"),
                        rs.getString("PESO"),
                        rs.getString("FOTO"),
                        rs.getString("FECHA_ALTA"),
                        rs.getString("FECHA_BAJA"),
                        rs.getString("ESTADO"),
                        rs.getDouble("PRECIO_VENTA"));
            }
        } catch (Exception e) {
            System.out.println("Error en getProducto()" + e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (coneLocal.NewConnection() != null) {
                    coneLocal.NewConnection().close();
                }
            } catch (Exception e) {
            }
        }
        return producto;
    }
}
