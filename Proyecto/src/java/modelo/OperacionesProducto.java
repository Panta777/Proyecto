/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import ClasesGenericas.Cliente;
import ClasesGenericas.Producto;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
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
    
        /**
     * Retorna determinado valor, según respuesta de la función para insertar
     * Datos de Nuevo Producto
     *
     * @param producto
     * @return 1 = exitoso 2 = usuario ya existe 3 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public String insertarProducto(Producto producto) throws SQLException {
        String respuesta = "";
        Connection cone = coneLocal.NewConnection();
        if (producto.getDESCRIPCION().equals("prueba")) {
            return "si";
        }
        
        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement InsertarProducto = cone.prepareCall("{ call INSERTARPRODUCTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

//                System.out.println("Dato: " + producto.getNOMBRE());
//                System.out.println("Dato: " + producto.getAPELLIDO());
//                System.out.println("Dato: " + producto.getTIPODOCUMENTO());
//                System.out.println("Dato: " + producto.getNUMERO_DOC());
//                System.out.println("Dato: " + producto.getTEL_RESIDENCIA());
//                System.out.println("Dato: " + producto.getTEL_CEL());
//                System.out.println("Dato: " + producto.getNIT());
//                System.out.println("Dato: " + producto.getDIRECCION());
//                System.out.println("Dato: " + producto.getCIUDAD());
//                System.out.println("Dato: " + producto.getDEPARTAMENTO());
//                System.out.println("Dato: " + producto.getPAIS());
//                System.out.println("Dato: " + producto.getPROFESION());
//                System.out.println("Dato: " + producto.getEMAIL());
//                System.out.println("Dato: " + producto.getUSUARIO());
//                System.out.println("Dato: " + producto.getCONTRASENA());
                
                /*
in_ID_PRODUCTO IN producto.id_producto%TYPE,
in_REFERENCIA  IN producto.referencia%TYPE,
in_NOMBRE      IN PRODUCTO.NOMBRE%TYPE,
in_DESCRIPCION IN PRODUCTO.DESCRIPCION%type,
in_TIPO        IN PRODUCTO.TIPO%TYPE,
in_MATERIAL    IN PRODUCTO.MATERIAL%TYPE,
in_ALTO        IN PRODUCTO.ALTO%TYPE,
in_ANCHO       IN PRODUCTO.ANCHO%TYPE,
in_PROFUNDIDAD IN PRODUCTO.PROFUNDIDAD%TYPE,
in_COLOR       IN PRODUCTO.COLOR%TYPE,
in_PESO        IN PRODUCTO.PESO%TYPE,
in_FOTO        IN PRODUCTO.FOTO%TYPE,
in_ESTADO      IN PRODUCTO.ESTADO%TYPE,
in_PRECIO_VENTA IN PRODUCTO.PRECIO_VENTA%TYPE,
 */
                // cargar parametros de entrada
                InsertarProducto.setString(2, producto.getREFERENCIA());
                InsertarProducto.setString(3, producto.getNOMBRE());
                InsertarProducto.setString(4, producto.getDESCRIPCION());
                InsertarProducto.setString(5, producto.getTIPO());
                InsertarProducto.setString(6, producto.getMATERIAL());
                InsertarProducto.setString(7, producto.getALTO());
                InsertarProducto.setString(8, producto.getANCHO());
                InsertarProducto.setString(9, producto.getPROFUNDIDAD());
                InsertarProducto.setString(10, producto.getCOLOR());
                InsertarProducto.setString(11, producto.getPESO());
                InsertarProducto.setString(12, producto.getFOTO());
                InsertarProducto.setString(13, producto.getESTADO());
                InsertarProducto.setDouble(14, producto.getPRECIOVENTA());

                InsertarProducto.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                InsertarProducto.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = InsertarProducto.getString(1);// obtener salida
            } catch (SQLException e) {
                respuesta = "";
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + Arrays.toString(e.getStackTrace())); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return respuesta;
    }

}
