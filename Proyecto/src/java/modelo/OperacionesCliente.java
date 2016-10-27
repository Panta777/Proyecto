/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import ClasesGenericas.Cliente;
import ClasesGenericas.Producto;
import java.sql.*;
import java.sql.Connection;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Arrays;
import oracle.jdbc.OracleTypes;

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
        Connection cone = coneLocal.NewConnection();

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

//       /**
//     * Retorna el tipo de Nivel de acceso, según el login de Usuario.
//     *
//     * @param usuario
//     * @param contra
//     * @return Nivel de Acceso
//     * @throws java.sql.SQLException
//     */
//    public int loguear(String usuario, String contra) throws SQLException {
//
//        int nivel = 0;
//            try {  
//                Connection cone = coneLocal.NewConnection(usuario, contra);
//                if(cone!= null)
//                { 
//                    nivel = 1;
//                }
////                cone.setAutoCommit(false);
////                CallableStatement funcionLogin = cone.prepareCall("{ ?=call GET_TIPO_USUARIO(?,?) }");
////                // cargar parametros de entrada
////                funcionLogin.setString(2, usuario);
////                funcionLogin.setString(3, contra);
////                funcionLogin.registerOutParameter(1, Types.INTEGER);//Parametro de salida
////                funcionLogin.execute();
////
////                cone.commit();// confirmar si se ejecuto sin errores
//                // obtener salida
//            } catch (Exception e) {
//                nivel = 0;
//             //   cone.rollback();// deshacer la ejecucion en caso de error
//                System.out.println("Error al ejecutar función GET_TIPO_USUARIO por, " + e); // informar por consola
//            } finally {
//               // cone.close();// cerrar la conexion
//            }
//        return nivel;
//    }
    
    /**
     * Retorna determinado mensaje al registrar un nuevo usuario a la BD
     *
     * @param Usuario
     * @param clave
     * @return 1 = exitoso 2 = usuario ya existe 3 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public String insertarUsuarioDB(String Usuario, String clave) throws SQLException {
        String respuesta = "";
        Connection cone = coneLocal.NewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement insertarUsuario = cone.prepareCall("{ call CREACION_USUARIO(?,?,?,?) }");

                insertarUsuario.setString(1, Usuario);
                insertarUsuario.setString(2, clave);
                insertarUsuario.setString(3, "CLIENTE");
                
                insertarUsuario.registerOutParameter(4, OracleTypes.VARCHAR);//Parametro de salida
                insertarUsuario.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = (String) insertarUsuario.getObject(4);// obtener salida
//                insertarUsuario.executeUpdate();
//                ResultSet rsRecords = (ResultSet) insertarUsuario.getObject(3);
            } catch (SQLException e) {
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
     * Retorna determinado valor, según respuesta de la función para insertar
     * Datos de Nuevo Cliente
     *
     * @param cliente
     * @return 1 = exitoso 2 = usuario ya existe 3 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public int insertarCliente(Cliente cliente) throws SQLException {
        int respuesta = 0;
        Connection cone = coneLocal.NewConnection();

        if (cliente.getUSUARIO().equals("prueba")) {
            return 1;
        }
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
                respuesta = 0;
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función  por, " + Arrays.toString(e.getStackTrace())); // informar por consola
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
     * @param cliente
     * @return 1 = exitoso 2 = usuario ya existe 3 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public int ModificarCliente(Cliente cliente) throws SQLException {
        int respuesta = 0;
        Connection cone = coneLocal.NewConnection();

        if (cliente.getUSUARIO().equals("prueba")) {
            respuesta = 1;
        }

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement ModificarCliente = cone.prepareCall("{ ?=call xxxxx(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

                // cargar parametros de entrada
                ModificarCliente.setString(2, cliente.getNUMERO_DOC());
                ModificarCliente.setString(3, cliente.getTIPODOCUMENTO());
                ModificarCliente.setString(4, cliente.getNOMBRE());
                ModificarCliente.setString(5, cliente.getAPELLIDO());
                ModificarCliente.setString(6, cliente.getTEL_RESIDENCIA());
                ModificarCliente.setString(7, cliente.getTEL_CEL());
                ModificarCliente.setString(8, cliente.getNIT());
                ModificarCliente.setString(9, cliente.getDIRECCION());
                ModificarCliente.setString(10, cliente.getCIUDAD());
                ModificarCliente.setString(11, cliente.getDEPARTAMENTO());
                ModificarCliente.setString(12, cliente.getPAIS());
                ModificarCliente.setString(13, cliente.getPROFESION());
                ModificarCliente.setString(14, cliente.getEMAIL());
                ModificarCliente.setString(15, cliente.getUSUARIO());
                ModificarCliente.setString(16, cliente.getCONTRASENA());

                ModificarCliente.registerOutParameter(1, Types.INTEGER);//Parametro de salida
                ModificarCliente.execute();
                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = ModificarCliente.getInt(1);// obtener salida
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
        Connection cone = coneLocal.NewConnection();

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
        Connection cone = coneLocal.NewConnection();

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

    /**
     * Muestra datos del Cliente, segun su usuario un Cliente por medio de su
     * Id¿?
     *
     * @param IdCliente
     * @param Usuario
     * @return 1 = exitoso 2 = error al procesar datos
     * @throws java.sql.SQLException
     */
    public Cliente mostrarDatosCliente(String Usuario) throws SQLException {
        int respuesta = 0;
        Connection cone = coneLocal.NewConnection();

        Cliente cl = new Cliente();
        if (cone != null) {
//            try {
//                cone.setAutoCommit(false);
//                CallableStatement funcionEliminarCliente = cone.prepareCall("");
//
//                // cargar parametros de entrada
//                funcionEliminarCliente.setString(2, IdCliente);
//                funcionEliminarCliente.registerOutParameter(1, Types.INTEGER);//Parametro de salida
//                funcionEliminarCliente.execute();
//
//                cone.commit();// confirmar si se ejecuto sin errores
//                respuesta = funcionEliminarCliente.getInt(1);// obtener salida
//            } catch (SQLException e) {
//                cone.rollback();// deshacer la ejecucion en caso de error
//                System.out.println("Error al ejecutar función  por, " + e); // informar por consola
//            } finally {
//                cone.close();// cerrar la conexion
//            }

            String queryString = "Select ID_USUARIO From USUARIO  Where USUARIO  = '" + Usuario + "'";
            System.out.println("QUERY 1: " + queryString);

            try {
                Statement stQuery = cone.createStatement();
                ResultSet rsRecords = stQuery.executeQuery(queryString);

                while (rsRecords.next()) {
                    Usuario = rsRecords.getNString("ID_USUARIO");
                }
            } catch (Exception ex1) {
                System.out.println("ERROR SQL1");
            }

            queryString = "Select *";
            queryString += " From CLIENTE";
            queryString += " Where ID_USUARIO  = '" + Usuario + "'";
            System.out.println("QUERY 2: " + queryString);
            try {
                Statement stQuery = cone.createStatement();
                ResultSet rsRecords = stQuery.executeQuery(queryString);
                while (rsRecords.next()) {
                    cl.setNOMBRE(rsRecords.getString("NOMBRE"));
                    cl.setAPELLIDO(rsRecords.getString("APELLIDO"));
                    cl.setTIPODOCUMENTO(rsRecords.getString("TIPODOCUMENTO"));
                    cl.setNUMERO_DOC(rsRecords.getString("NUMERO_DOC"));
                    cl.setTEL_RESIDENCIA(rsRecords.getString("TEL_RESIDENCIA"));
                    cl.setTEL_CEL(rsRecords.getString("TEL_CEL"));
                    cl.setNIT(rsRecords.getString("NIT"));
                    cl.setDIRECCION(rsRecords.getString("DIRECCION"));
                    cl.setCIUDAD(rsRecords.getString("IDCIUDAD"));
                    cl.setPAIS(rsRecords.getString("PAIS"));
                    cl.setDEPARTAMENTO(rsRecords.getString("DEPARTAMENTO"));
                    cl.setPROFESION(rsRecords.getString("PROFESION"));
//                    cl.setEMAIL(rsRecords.getString("EMAIL"));
//                    cl.setUSUARIO(rsRecords.getString("NOMBRE"));
//                    cl.setCONTRASENA(rsRecords.getString("NOMBRE"));
                }
            } catch (Exception ex1) {
                System.out.println("ERROR SQL2: " + ex1);

            }
        }
        return cl;
    }

    /**
     * Muestra pais 
     *
liente
     * @return 
     * @throws java.sql.SQLException
     */
    public ArrayList<String > mostrarPais() throws SQLException {
        // int respuesta = 0;
        ArrayList<String> pais = new ArrayList<>();
        Connection cone = coneLocal.NewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement procMostrarPais = cone.prepareCall("{CALL verPaises(?)}");

                // cargar parametros de entrada
//                procMostrarClientes.setString(1, campoFiltro);
//                procMostrarClientes.setString(2, dato);

                //parametro de salida
                procMostrarPais.registerOutParameter(1, OracleTypes.CURSOR);

                procMostrarPais.executeUpdate();
                ResultSet rsRecords = (ResultSet) procMostrarPais.getObject(1);

                if (rsRecords != null) {
                    // System.out.println("Hay data");
                    while (rsRecords.next()) {// obtener salida
                        pais.add( rsRecords.getString("IDPAIS")+";"+rsRecords.getString("PAIS"));
                    }
                }
                cone.commit();// confirmar si se ejecuto sin errores
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función VERPAIS por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return pais;
    }

    
        /**
     * Muestra pais 
     *
liente
     * @return 
     * @throws java.sql.SQLException
     */
    public ArrayList<String > mostrarDepartamento(int p) throws SQLException {
        // int respuesta = 0;
        ArrayList<String> pais = new ArrayList<>();
        Connection cone = coneLocal.NewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement procMostrarDepa = cone.prepareCall("{CALL verDepartamentos(?,?)}");

                // cargar parametros de entrada
                procMostrarDepa.setInt(1, p);
//                procMostrarClientes.setString(2, dato);

                //parametro de salida
                procMostrarDepa.registerOutParameter(2, OracleTypes.CURSOR);

                procMostrarDepa.executeUpdate();
                ResultSet rsRecords = (ResultSet) procMostrarDepa.getObject(2);

                if (rsRecords != null) {
                     System.out.println("Hay data");
                    while (rsRecords.next()) {// obtener salida
                        System.out.println("Ha" + rsRecords.getString("IDDEPARTAMENTO")+";"+rsRecords.getString("NOMBREDEPARTAMENTO"));
                        pais.add( rsRecords.getString("IDDEPARTAMENTO")+";"+rsRecords.getString("NOMBREDEPARTAMENTO"));
                    }
                }
                cone.commit();// confirmar si se ejecuto sin errores
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función verDepartamentos por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return pais;
    }

    /**
     * Muestra datos del Cliente, segun diferentes criterios para el reporte
     *
     * @param campoFiltro
     * @param dato
     * @return registros Cliente
     * @throws java.sql.SQLException
     */
    public ArrayList<Cliente> mostrarDatosClienteReporte(String campoFiltro, String dato) throws SQLException {
        // int respuesta = 0;
        ArrayList<Cliente> clientes = new ArrayList<>();
        Connection cone = coneLocal.NewConnection();

        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement procMostrarClientes = cone.prepareCall("{CALL DatosReporteCliente(?,?,?)}");

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
                        clientes.add(new Cliente(
                                rsRecords.getString("NOMBRE"),
                                rsRecords.getString("APELLIDO"),
                                rsRecords.getString("ID_USUARIO"),
                                rsRecords.getString("NUMERO_DOC"),
                                rsRecords.getString("PROFESION"),
                                rsRecords.getString("TEL_CEL"),
                                rsRecords.getString("TEL_RESIDENCIA"),
                                rsRecords.getString("NIT"),
                                rsRecords.getString("DIRECION"),
                                rsRecords.getString("IDCIUDAD")));
                    }
                }
                cone.commit();// confirmar si se ejecuto sin errores
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función MOSTRARCLIENTESREPORTE por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return clientes;
    }


}
