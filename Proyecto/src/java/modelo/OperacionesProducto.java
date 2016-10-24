/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import ClasesGenericas.Producto;
import java.sql.*;
import java.util.ArrayList;
import oracle.jdbc.OracleTypes;

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
     * @return Retorna el listado de productos existentes, de cada categoria
     * agregados a un listado de productos
     * @throws java.sql.SQLException
     * @
     */
    public ArrayList<Producto> getAllProductos(String tipo) {
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

    /**
     * Muestra datos de los productos, segun diferentes criterios para el
     * reporte
     *
     * @param campoFiltro
     * @param dato
     * @return registros Productos
     * @throws java.sql.SQLException
     */
    public ArrayList<Producto> mostrarDatosProductoReporte(String campoFiltro, String dato) throws SQLException {
        // int respuesta = 0;
        ArrayList<Producto> productos = new ArrayList<>();
        Connection cone = coneLocal.NewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement procMostrarClientes = cone.prepareCall("{CALL DatosReporteProducto(?,?,?)}");

                // cargar parametros de entrada
                procMostrarClientes.setString(1, campoFiltro);
                procMostrarClientes.setString(2, dato);

                //parametro de salida
                procMostrarClientes.registerOutParameter(3, OracleTypes.CURSOR);

                procMostrarClientes.executeUpdate();
                ResultSet rsRecords = (ResultSet) procMostrarClientes.getObject(3);

                if (rsRecords != null) {
                    // System.out.println("Hay data");
                    while (rsRecords.next()) {// obtener salida
                        productos.add(new Producto(rsRecords.getInt("ID_PRODUCTO"),
                                rsRecords.getString("NOMBRE"),
                                rsRecords.getString("REFERENCIA"),
                                rsRecords.getString("DESCRIPCION"),
                                rsRecords.getString("TIPO"),
                                rsRecords.getString("MATERIAL"),
                                rsRecords.getString("ALTO"),
                                rsRecords.getString("ANCHO"),
                                rsRecords.getString("PROFUNDIDAD"),
                                rsRecords.getString("COLOR"),
                                rsRecords.getString("PESO"),
                                rsRecords.getString("FOTO"),
                                rsRecords.getString("FECHA_ALTA"),
                                rsRecords.getString("FECHA_BAJA"),
                                rsRecords.getString("ESTADO"),
                                rsRecords.getDouble("PRECIO_VENTA")));;
                    }
                }
                cone.commit();// confirmar si se ejecuto sin errores
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función DatosReporteProducto por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return productos;
    }

}
