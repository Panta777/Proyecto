/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import ClasesGenericas.Cliente;
import java.sql.*;
import java.sql.Connection;
import java.sql.Types;

/**
 * @author panle
 */
public class OperacionesCliente {

    private Conexion coneLocal;

    public OperacionesCliente() {
        this.coneLocal = new Conexion();
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
        Connection cone = coneLocal.getNewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement funcionLogin = cone.prepareCall("{ ?=call GET_TIPO_USUARIO(?,?) }");
                // cargar parametros de entrada
                funcionLogin.setString(2, usuario);
                funcionLogin.setString(3, contra);
                funcionLogin.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                funcionLogin.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                nivel = funcionLogin.getInt(1);// obtener salida
            } catch (SQLException e) {
                nivel = 0;
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función GET_TIPO_USUARIO por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return nivel;
    }

    /**
     * Retorna determinado valor, según respuesta de la función para insertar
     * Datos de Nuevo Cliente
     *
     * @param cliente
     * @return 1 = exitoso 2 = usuario ya existe 3 = error al procesar datos
     * @throws java.sql.SQLException
     */
//    public int insertarCliente(String No_Documento, String Tipo_Documento, String Nombre, String Apellidos, String TelefonoResidencia,
//            String TelefonoCelular, String Nit, String Direccion, String Ciudad, String Departamento, String Pais,
//            String Profesion, String Correo, String usuario, String contra) throws SQLException {
    public int insertarCliente(Cliente cliente) throws SQLException {
        int respuesta = 0;
        Connection cone = coneLocal.getNewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement InsertarCliente = cone.prepareCall("{ call xxxxx(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

//                System.out.println("Dato: " + cliente.getNOMBRE());
//                System.out.println("Dato: " + cliente.getAPELLIDO());
//                System.out.println("Dato: " + cliente.getTIPODOCUMENTO());
//                System.out.println("Dato: " + cliente.getNUMERO_DOC());
//                System.out.println("Dato: " + cliente.getTEL_RESIDENCIA());
//                System.out.println("Dato: " + cliente.getTEL_CEL());
//                System.out.println("Dato: " + cliente.getNIT());
//                System.out.println("Dato: " + cliente.getDIRECCION());
//                System.out.println("Dato: " + cliente.getCIUDAD());
//                System.out.println("Dato: " + cliente.getDEPARTAMENTO());
//                System.out.println("Dato: " + cliente.getPAIS());
//                System.out.println("Dato: " + cliente.getPROFESION());
//                System.out.println("Dato: " + cliente.getEMAIL());
//                System.out.println("Dato: " + cliente.getUSUARIO());
//                System.out.println("Dato: " + cliente.getCONTRASENA());

                // cargar parametros de entrada
                InsertarCliente.setString(2, cliente.getNUMERO_DOC());
                InsertarCliente.setString(3, cliente.getTIPODOCUMENTO());
                InsertarCliente.setString(4, cliente.getNOMBRE());
                InsertarCliente.setString(5, cliente.getAPELLIDO());
                InsertarCliente.setString(6, cliente.getTEL_RESIDENCIA());
                InsertarCliente.setString(7, cliente.getTEL_CEL());
                InsertarCliente.setString(8, cliente.getNIT());
                InsertarCliente.setString(9, cliente.getDIRECCION());
                InsertarCliente.setString(10, cliente.getCIUDAD());
                InsertarCliente.setString(11, cliente.getDEPARTAMENTO());
                InsertarCliente.setString(12, cliente.getPAIS());
                InsertarCliente.setString(13, cliente.getPROFESION());
                InsertarCliente.setString(14, cliente.getEMAIL());
                InsertarCliente.setString(15, cliente.getUSUARIO());
                InsertarCliente.setString(16, cliente.getCONTRASENA());
                
                InsertarCliente.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                InsertarCliente.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = InsertarCliente.getInt(1);// obtener salida
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
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
        Connection cone = coneLocal.getNewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement funcionmodificarCliente = cone.prepareCall("{ ?=call xxxxx(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

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

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = funcionmodificarCliente.getInt(1);// obtener salida
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }

        return respuesta;
    }

    /**
     * Retorna determinado valor, según respuesta de la función para eliminar a
     * un Cliente por medio de su No. de Documento¿?
     *
     * @param No_Documento
     * @return 1 = exitoso 2 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public int eliminarClientePorDocto(String No_Documento) throws SQLException {
        int respuesta = 0;
        Connection cone = coneLocal.getNewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement funcionEliminarCliente = cone.prepareCall("{ ?=call xxxxx(?) }");

                // cargar parametros de entrada
                funcionEliminarCliente.setString(2, No_Documento);
                funcionEliminarCliente.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                funcionEliminarCliente.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = funcionEliminarCliente.getInt(1);// obtener salida
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
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
        Connection cone = coneLocal.getNewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement funcionEliminarCliente = cone.prepareCall("{ ?=call xxxxx(?) }");

                // cargar parametros de entrada
                funcionEliminarCliente.setString(2, IdCliente);
                funcionEliminarCliente.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                funcionEliminarCliente.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = funcionEliminarCliente.getInt(1);// obtener salida
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return respuesta;
    }
}
