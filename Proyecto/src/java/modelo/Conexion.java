/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author panle
 */
public class Conexion {

    /**
     * Clase para manejar la conectividad a base de datos. 
     * Lee variables de ambiente y recursos del archivo web.xml
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

    public Conexion() {
        utileria = new Utileria();
        variablesAmbiente = new EnvironmentVars();
    }

    /**
     * Retorna el objeto Connection, que es una nueva conexion a la base de
     * datos.
     *
     * @return currentConnection Connection.
     */
    public Connection getNewConnection() {
        try {
            Class.forName((String) variablesAmbiente.getDB_CLASSNAME());
            currentConnection = DriverManager.getConnection(
                    (String) variablesAmbiente.getDB_URL(),
                    (String) variablesAmbiente.getDB_USERNAME(),
                    (String) variablesAmbiente.getDB_PASSWORD());
            System.out.println("Conexion Exitosa");
        } catch (Exception e) {
            System.out.println("Error al tratar de conectar a la Base de Datos: " + e);//  utileria.escribirLog("N/A", "", "\n\nConnectionBD->getConnection()..Error..: " + ex.getMessage())
        }
        return currentConnection;
    }
}
