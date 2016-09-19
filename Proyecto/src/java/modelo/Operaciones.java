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
 *
 * @author panle
 */
public class Operaciones {

    /**
     * Clase para manejar la conectividad a base de datos. Lee variables de
     * ambiente y recursos del archivo context.xml
     *
     * @author panle
     *
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
        utileria = new Utileria();
        //variablesAmbiente = new EnvironmentVars();
    }

    /**
     * Retorna el objeto Connection, que es una nueva conexion a la base de datos.
     *
     * @return currentConnection Connection.
     *
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
      //  String URL = "jdbc:oracle:thin:@localhost:1521:xe";
        String URL = "jdbc:oracle:thin:@localhost:1521:orclsys";
        
        try {
            

            Class.forName(CLASSNAME);
//            currentConnection = DriverManager.getConnection(
//                    (String)variablesAmbiente.getDB_URL(),
//                    (String)variablesAmbiente.getDB_USERNAME(),
//                    (String)variablesAmbiente.getDB_PASSWORD());
            
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
//
//            if (variablesAmbiente.getDbDataSourceName().equals("MSSQL")) {   // Microsoft SQLSERVER
//                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
//                ds = (DataSource) variablesAmbiente.getCurrentContext().lookup("java:comp/env/MSSQLDS");
//            }
//            if (variablesAmbiente.getDbDataSourceName().equals("ORACLE")) {  // ORACLE
//                Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
//                ds = (DataSource) variablesAmbiente.getCurrentContext().lookup("java:comp/env/ORACLEDS");
//            }
//            if (variablesAmbiente.getDbDataSourceName().equals("SQLITE")) {  // ORACLE
//                Class.forName("org.sqlite.JDBC").newInstance();
//                ds = (DataSource) variablesAmbiente.getCurrentContext().lookup("java:comp/env/SQLITEDS");
//            }
//
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
//
//            if (variablesAmbiente.getDbDataSourceName().equals("MYSQL")) { // MySQL
//                usedDataSource = "MYSQL";
//            }
//
//            if (variablesAmbiente.getDbDataSourceName().equals("MSSQL")) { // Microsoft SQLSERVER
//                usedDataSource = "MSSQL";
//            }
//
//            if (variablesAmbiente.getDbDataSourceName().equals("ORACLE")) { // ORACLE
//                usedDataSource = "ORACLE";
//            }
//        } catch (Exception cnfE) {
//            utileria.escribirLog("N/A", "", "\n\nConnectionBD->getUsedDBDataSource()...Error, no se pudo instanciar la clase..: " + cnfE.getMessage());
//        }
//
//        return usedDataSource;
//    }

    /**
     * Retorna la coneccion actual de base de datos.
     *
     * @return the currentConnection
     *
     */
    public Connection getCurrentConnection() {
        return currentConnection;
    }
    
    /**
     * Retorna el tipo de Nivel de acceso, según el login de Usuario
     * La cantidad de "?" determina  la cantidad parametros que utiliza el procedimiento/función
     * @param usuario
     * @param contra
     * @return Nivel de Acceso
     * @throws java.sql.SQLException
     */
    public int loguear(String usuario, String contra) throws SQLException  {

        int nivel = 0;
        Connection coneLocal = getNewConnection();

        try { 
            coneLocal.setAutoCommit(false);
            CallableStatement funcionLogin = coneLocal.prepareCall("{ ?=call GET_TIPO_USUARIO(?,?) }");
            
            funcionLogin.setString(2, usuario);// cargar parametros de entrada
            funcionLogin.setString(3, contra);
            funcionLogin.registerOutParameter(1, Types.INTEGER);//Parametro de salida
//            if(funcionLogin.execute()) // ejecutar
//            {
            funcionLogin.execute();
                coneLocal.commit();// confirmar si se ejecuto sin errores
                nivel = funcionLogin.getInt(1);// obtener salida
//            }
//            else 
//                return nivel ; 
        } 
        catch (SQLException e) 
        {            
            coneLocal.rollback();// deshacer la ejecucion en caso de error
            System.out.println("Error al ejecutar función GET_TIPO_USUARIO por, " +e); // informar por consola
        }
        finally 
        {
            coneLocal.close();// cerrar la conexion
        }
        
       return nivel;
    }
}
