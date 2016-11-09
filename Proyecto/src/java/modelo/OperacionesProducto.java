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
     * @param tipo
     * @return Retorna el listado de productos existentes, de cada categoria
     * agregados a un listado de productos
     * @throws java.sql.SQLException
     * @
     */
    public ArrayList<Producto> getAllProductos(String tipo) throws SQLException {
        ArrayList<Producto> productos = new ArrayList<>();
        Connection cone = coneLocal.NewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement procMostrarProductos = cone.prepareCall("{CALL Consulta_productoTipo(?,?)}");

                // cargar parametros de entrada
                procMostrarProductos.setString(1, tipo.toUpperCase());

                //parametro de salida
                procMostrarProductos.registerOutParameter(2, OracleTypes.CURSOR);

                procMostrarProductos.executeUpdate();
                ResultSet rsRecords = (ResultSet) procMostrarProductos.getObject(2);

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
                System.out.println("Error al ejecutar función CONSULTA_PRODUCTOTIPO por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
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
    public Producto getProducto(int id) throws SQLException {
        Producto producto = null;
        Connection cone = coneLocal.NewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement procMostrarProductos = cone.prepareCall("{CALL CONSULTAPRODUCTOID(?,?,?)}");

                // cargar parametros de entrada
                procMostrarProductos.setInt(1, id);

                //parametro de salida
                procMostrarProductos.registerOutParameter(2, OracleTypes.CURSOR);
                procMostrarProductos.registerOutParameter(3, OracleTypes.VARCHAR);

                procMostrarProductos.executeUpdate();
                ResultSet rsRecords = (ResultSet) procMostrarProductos.getObject(2);

                if (rsRecords != null) {
                    // System.out.println("Hay data");
                    while (rsRecords.next()) {
                        producto = new Producto(rsRecords.getInt("ID_PRODUCTO"),
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
                                rsRecords.getDouble("PRECIO_VENTA"));
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
     * Retorna determinado valor, según respuesta del SP para insertar Datos de
     * Nuevo Producto
     *
     * @param producto
     * @return
     *
     * @throws java.sql.SQLException
     */
    public String insertarProducto(Producto producto) throws SQLException {
        String respuesta = "";
        Connection cone = coneLocal.NewConnection();
//        if (producto.getDESCRIPCION().equals("prueba")) {
//            return "si";
//        }

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement InsertarProducto = cone.prepareCall("{ call INS_PRODUCTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

                System.out.println("Dato: " + producto.getID_PRODUCTO());
                System.out.println("Dato: " + producto.getREFERENCIA());
                System.out.println("Dato: " + producto.getNOMBRE());
                System.out.println("Dato: " + producto.getDESCRIPCION());
                System.out.println("Dato: " + producto.getTIPO());
                System.out.println("Dato: " + producto.getMATERIAL());
                System.out.println("Dato: " + producto.getALTO());
                System.out.println("Dato: " + producto.getANCHO());
                System.out.println("Dato: " + producto.getPROFUNDIDAD());
                System.out.println("Dato: " + producto.getCOLOR());
                System.out.println("Dato: " + producto.getPESO());
                System.out.println("Dato: " + producto.getFOTO());
                System.out.println("Dato: " + producto.getESTADO());
                System.out.println("Dato: " + producto.getPRECIOVENTA());
                /*
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
in_mensaje     out varchar2
                 */
                // cargar parametros de entrada
                InsertarProducto.setString(1, producto.getREFERENCIA());
                InsertarProducto.setString(2, producto.getNOMBRE());
                InsertarProducto.setString(3, producto.getDESCRIPCION());
                InsertarProducto.setString(4, producto.getTIPO());
                InsertarProducto.setString(5, producto.getMATERIAL());
                InsertarProducto.setString(6, producto.getALTO());
                InsertarProducto.setString(7, producto.getANCHO());
                InsertarProducto.setString(8, producto.getPROFUNDIDAD());
                InsertarProducto.setString(9, producto.getCOLOR());
                InsertarProducto.setString(10, producto.getPESO());
                InsertarProducto.setString(11, producto.getFOTO());
                InsertarProducto.setString(12, producto.getESTADO());
                InsertarProducto.setDouble(13, producto.getPRECIOVENTA());

                InsertarProducto.registerOutParameter(14, OracleTypes.VARCHAR);//Parametro de salida
                InsertarProducto.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = InsertarProducto.getString(14);// obtener salida
            } catch (SQLException e) {
                respuesta = "";
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " ); // informar por consola
                e.printStackTrace();
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return respuesta;
    }

    /**
     * Retorna determinado valor, según respuesta de Sp para modificar Datos de
     * Producto
     *
     * @param producto
     * @return
     * @throws java.sql.SQLException
     */
    public String modificarProducto(Producto producto) throws SQLException {
        String respuesta = "";
        Connection cone = coneLocal.NewConnection();

        System.out.println("Dato: " + producto.getID_PRODUCTO());
        System.out.println("Dato: " + producto.getREFERENCIA());
        System.out.println("Dato: " + producto.getNOMBRE());
        System.out.println("Dato: " + producto.getDESCRIPCION());
        System.out.println("Dato: " + producto.getTIPO());
        System.out.println("Dato: " + producto.getMATERIAL());
        System.out.println("Dato: " + producto.getALTO());
        System.out.println("Dato: " + producto.getANCHO());
        System.out.println("Dato: " + producto.getPROFUNDIDAD());
        System.out.println("Dato: " + producto.getCOLOR());
        System.out.println("Dato: " + producto.getPESO());
        System.out.println("Dato: " + producto.getFOTO());
        System.out.println("Dato: " + producto.getESTADO());
        System.out.println("Dato: " + producto.getPRECIOVENTA());
        if (producto.getDESCRIPCION().equals("prueba")) {
            return "si";
        }

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement ModificarProducto = cone.prepareCall("{ call ACTUALIZARPRODUCTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                // cargar parametros de entrada
                ModificarProducto.setInt(1, producto.getID_PRODUCTO());
                ModificarProducto.setString(2, producto.getREFERENCIA());
                ModificarProducto.setString(3, producto.getNOMBRE());
                ModificarProducto.setString(4, producto.getDESCRIPCION());
                ModificarProducto.setString(5, producto.getTIPO());
                ModificarProducto.setString(6, producto.getMATERIAL());
                ModificarProducto.setString(7, producto.getALTO());
                ModificarProducto.setString(8, producto.getANCHO());
                ModificarProducto.setString(9, producto.getPROFUNDIDAD());
                ModificarProducto.setString(10, producto.getCOLOR());
                ModificarProducto.setString(11, producto.getPESO());
                ModificarProducto.setString(12, producto.getFOTO());
                ModificarProducto.setString(13, producto.getESTADO());
                ModificarProducto.setDouble(14, producto.getPRECIOVENTA());

                ModificarProducto.registerOutParameter(15, OracleTypes.VARCHAR);//Parametro de salida
                ModificarProducto.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = ModificarProducto.getString(15);// obtener salida
            } catch (SQLException e) {
                respuesta = "";
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función ACTUALIZARPRODUCTO por, " + Arrays.toString(e.getStackTrace())); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return respuesta;
    }

}
