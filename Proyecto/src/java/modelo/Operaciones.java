/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.*;
import java.sql.Connection;
import java.sql.Types;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * @author panle
 */
public class Operaciones {

    /**
     * Clase para manejar la conectividad a base de datos. Lee variables de
     * ambiente y recursos del archivo context.xml
     *
     * @author panle
     */
    private Connection currentConnection = null;
    public Statement stQuery = null;
    public PreparedStatement stPreparedQuery = null;
    public ResultSet rsRecords = null, rsRecords1 = null;
    public ResultSet rsRecordsTmp = null;
    public Utileria utileria = null;
    private EnvironmentVars variablesAmbiente = null;
    public String DtePath = "";

    public Operaciones() {
        utileria = new Utileria(); //variablesAmbiente = new EnvironmentVars();
    }

    /**
     * Retorna el objeto Connection, que es una nueva conexion a la base de
     * datos.
     *
     * @return currentConnection Connection.
     */
    public Connection getNewConnection() {

//        String USERNAME = "root";
//        String PASSWORD = "medrano7";
//        String HOST = "localhost";
//        String PORT = "3306";
//        String DATABASE = "pruebas2";
//        String CLASSNAME = "com.mysql.jdbc.Driver";
//        String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE;
        String USERNAME = "C##PRUEBAS";
        // String USERNAME = "PRUEBAS";
        String PASSWORD = "medrano7";
        String CLASSNAME = "oracle.jdbc.driver.OracleDriver";
        // String URL = "jdbc:oracle:thin:@localhost:1521:xe";
        String URL = "jdbc:oracle:thin:@localhost:1521:orclsys";

        try {
            Class.forName(CLASSNAME);
//            currentConnection = DriverManager.getConnection(
//                    (String)variablesAmbiente.getDB_URL(),
//                    (String)variablesAmbiente.getDB_USERNAME(),
//                   (String)variablesAmbiente.getDB_PASSWORD());

            currentConnection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Conexion Exitosa");

        } catch (Exception e) {
            //  utileria.escribirLog("N/A", "", "\n\nConnectionBD->getConnection()..Error..: " + ex.getMessage());
            System.out.println("Error al tratar de conectar a la Base de Datos: " + e);
        }
        return currentConnection;
    }

    /**
     * Lee la variable de ambiente DBDATASOURCE contenida en el archivo web.xml,
     * para determinar que manejador de base de datos se usarara. Luego lee el
     * contexto su-resources.xml para extraer el recurso MYSQLDS o MSSQLDS,
     * segun sea para MYSQL o para MS SQL SERVER
     *
     * @return DataSource ds
     *
     */
//    private DataSource getDBDataSource() {
//        DataSource ds = null;
//
//        try {
//
//            if (variablesAmbiente.getDbDataSourceName().equals("MYSQL")) {  // MySQL
//                Class.forName("com.mysql.jdbc.Driver").newInstance();
//                ds = (DataSource) variablesAmbiente.getCurrentContext().lookup("java:comp/env/MYSQLDS");
//            }
//        } catch (NamingException nE) {
//            utileria.escribirLog("N/A", "", "\n\nConnectionBD->getDBDataSource()...Error al obtener varaibles del contexto...: " + nE.getMessage());
//        } catch (Exception cnfE) {
//            utileria.escribirLog("N/A", "", "\n\nConnectionBD->getDBDataSource()...Error, no se pudo instanciar la clase..: " + cnfE.getMessage());
//        }
//
//        return ds;
//    }
    /**
     * Lee la variable de ambiente DBDATASOURCE contenida en el archivo web.xml,
     * para determinar que manejador de base de datos se usarara.
     *
     * @return String DBDATASOURCE
     */
//    public String getUsedDBDataSource() {
//        String usedDataSource = null;
//
//        try {
//            if (variablesAmbiente.getDbDataSourceName().equals("MYSQL")) { // MySQL
//                usedDataSource = "MYSQL";
//            }
//        } catch (Exception cnfE) {
//            utileria.escribirLog("N/A", "", "\n\nConnectionBD->getUsedDBDataSource()...Error, no se pudo instanciar la clase..: " + cnfE.getMessage());
//        }
//        return usedDataSource;
//    }
    /**
     * Retorna la coneccion actual de base de datos.
     *
     * @return the currentConnection
     */
    public Connection getCurrentConnection() {
        return currentConnection;
    }

    /**
     * Retorna el tipo de Nivel de acceso, según el login de Usuario.
     *
     * @param usuario
     * @param contra
     * @return Nivel de Acceso
     * @throws java.sql.SQLException
     */
    public int loguear(String usuario, String contra) throws SQLException {

        int nivel = 0;
        Connection coneLocal = getNewConnection();

        if (coneLocal != null) {
            try {
                coneLocal.setAutoCommit(false);
                CallableStatement funcionLogin = coneLocal.prepareCall("{ ?=call GET_TIPO_USUARIO(?,?) }");
                // cargar parametros de entrada
                funcionLogin.setString(2, usuario);
                funcionLogin.setString(3, contra);
                funcionLogin.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                funcionLogin.execute();

                coneLocal.commit();// confirmar si se ejecuto sin errores
                nivel = funcionLogin.getInt(1);// obtener salida
            } catch (SQLException e) {
                nivel = 0;
                coneLocal.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función GET_TIPO_USUARIO por, " + e); // informar por consola
            } finally {
                coneLocal.close();// cerrar la conexion
            }

        }
        return nivel;
    }

    /**
     * Retorna determinado valor, según respuesta de la función para insertar
     * Datos de Nuevo Cliente
     *
     * @param No_Documento
     * @param Tipo_Documento
     * @param Nombre
     * @param Apellidos
     * @param TelefonoResidencia
     * @param TelefonoCelular
     * @param Nit
     * @param Direccion
     * @param Ciudad
     * @param Departamento
     * @param Pais
     * @param Profesion
     * @param Correo
     * @param usuario
     * @param contra
     * @return 1 = exitoso 2 = usuario ya existe 3 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public int insertarCliente(String No_Documento, String Tipo_Documento, String Nombre, String Apellidos, String TelefonoResidencia,
            String TelefonoCelular, String Nit, String Direccion, String Ciudad, String Departamento, String Pais,
            String Profesion, String Correo, String usuario, String contra) throws SQLException {
        int respuesta = 0;
        Connection coneLocal = getNewConnection();

        if (coneLocal != null) {
            try {
                coneLocal.setAutoCommit(false);
                CallableStatement funcionInsertarCliente = coneLocal.prepareCall("{ ?=call xxxxx(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

                // cargar parametros de entrada
                funcionInsertarCliente.setString(2, No_Documento);
                funcionInsertarCliente.setString(3, Tipo_Documento);
                funcionInsertarCliente.setString(4, Nombre);
                funcionInsertarCliente.setString(5, Apellidos);
                funcionInsertarCliente.setString(6, TelefonoResidencia);
                funcionInsertarCliente.setString(7, TelefonoCelular);
                funcionInsertarCliente.setString(8, Nit);
                funcionInsertarCliente.setString(9, Direccion);
                funcionInsertarCliente.setString(10, Ciudad);
                funcionInsertarCliente.setString(11, Departamento);
                funcionInsertarCliente.setString(12, Pais);
                funcionInsertarCliente.setString(13, Profesion);
                funcionInsertarCliente.setString(14, Correo);
                funcionInsertarCliente.setString(15, usuario);
                funcionInsertarCliente.setString(16, contra);
                funcionInsertarCliente.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                funcionInsertarCliente.execute();

                coneLocal.commit();// confirmar si se ejecuto sin errores
                respuesta = funcionInsertarCliente.getInt(1);// obtener salida
            } catch (SQLException e) {
                coneLocal.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + e); // informar por consola
            } finally {
                coneLocal.close();// cerrar la conexion
            }
        }
        return respuesta;
    }

    /**
     * Retorna determinado valor, según respuesta de la función para modificar
     * Datos de Cliente
     *
     * @param No_Documento
     * @param Tipo_Documento
     * @param Nombre
     * @param Apellidos
     * @param TelefonoResidencia
     * @param TelefonoCelular
     * @param Nit
     * @param Direccion
     * @param Ciudad
     * @param Departamento
     * @param Pais
     * @param Profesion
     * @param Correo
     * @param usuario
     * @param contra
     * @return 1 = exitoso 2 = usuario ya existe 3 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public int modificarCliente(String No_Documento, String Tipo_Documento, String Nombre, String Apellidos, String TelefonoResidencia,
            String TelefonoCelular, String Nit, String Direccion, String Ciudad, String Departamento, String Pais,
            String Profesion, String Correo, String usuario, String contra) throws SQLException {
        int respuesta = 0;
        Connection coneLocal = getNewConnection();

        if (coneLocal != null) {
            try {
                coneLocal.setAutoCommit(false);
                CallableStatement funcionmodificarCliente = coneLocal.prepareCall("{ ?=call xxxxx(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

                // cargar parametros de entrada
                funcionmodificarCliente.setString(2, No_Documento);
                funcionmodificarCliente.setString(3, Tipo_Documento);
                funcionmodificarCliente.setString(4, Nombre);
                funcionmodificarCliente.setString(5, Apellidos);
                funcionmodificarCliente.setString(6, TelefonoResidencia);
                funcionmodificarCliente.setString(7, TelefonoCelular);
                funcionmodificarCliente.setString(8, Nit);
                funcionmodificarCliente.setString(9, Direccion);
                funcionmodificarCliente.setString(10, Ciudad);
                funcionmodificarCliente.setString(11, Departamento);
                funcionmodificarCliente.setString(12, Pais);
                funcionmodificarCliente.setString(13, Profesion);
                funcionmodificarCliente.setString(14, Correo);
                funcionmodificarCliente.setString(15, usuario);
                funcionmodificarCliente.setString(16, contra);
                funcionmodificarCliente.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                funcionmodificarCliente.execute();

                coneLocal.commit();// confirmar si se ejecuto sin errores
                respuesta = funcionmodificarCliente.getInt(1);// obtener salida
            } catch (SQLException e) {
                coneLocal.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + e); // informar por consola
            } finally {
                coneLocal.close();// cerrar la conexion
            }
        }

        return respuesta;
    }

    /**
     * Retorna determinado valor, según respuesta de la función para eliminar a
     * un Cliente por medio de su No. de Documento¿?
     *
     * @param IdCliente
     * @return 1 = exitoso 2 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public int eliminarClientePorDocto(String No_Documento) throws SQLException {
        int respuesta = 0;
        Connection coneLocal = getNewConnection();

        if (coneLocal != null) {
            try {
                coneLocal.setAutoCommit(false);
                CallableStatement funcionEliminarCliente = coneLocal.prepareCall("{ ?=call xxxxx(?) }");

                // cargar parametros de entrada
                funcionEliminarCliente.setString(2, No_Documento);
                funcionEliminarCliente.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                funcionEliminarCliente.execute();

                coneLocal.commit();// confirmar si se ejecuto sin errores
                respuesta = funcionEliminarCliente.getInt(1);// obtener salida
            } catch (SQLException e) {
                coneLocal.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + e); // informar por consola
            } finally {
                coneLocal.close();// cerrar la conexion
            }
        }
        return respuesta;
    }

    /**
     * Retorna determinado valor, según respuesta de la función para eliminar a
     * un Cliente por medio de su Id¿?
     *
     * @param IdCliente
     * @return 1 = exitoso 2 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public int eliminarClientePorId(String IdCliente) throws SQLException {
        int respuesta = 0;
        Connection coneLocal = getNewConnection();

        if (coneLocal != null) {
            try {
                coneLocal.setAutoCommit(false);
                CallableStatement funcionEliminarCliente = coneLocal.prepareCall("{ ?=call xxxxx(?) }");

                // cargar parametros de entrada
                funcionEliminarCliente.setString(2, IdCliente);
                funcionEliminarCliente.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                funcionEliminarCliente.execute();

                coneLocal.commit();// confirmar si se ejecuto sin errores
                respuesta = funcionEliminarCliente.getInt(1);// obtener salida
            } catch (SQLException e) {
                coneLocal.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + e); // informar por consola
            } finally {
                coneLocal.close();// cerrar la conexion
            }
        }
        return respuesta;
    }
}
