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
    private Connection coneCliente;

    public OperacionesCliente() {
        this.coneLocal = new Conexion();
        this.coneCliente = null;
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

        String respuesta = "";
        int tipo = 0;
        Connection cone = coneLocal.NewConnection();

//        if (cone != null) {
//            try {
//                cone.setAutoCommit(false);
//                CallableStatement funcionLogin = cone.prepareCall("{ ?=call GET_TIPO_USUARIO(?) }");
//                // cargar parametros de entrada
//              //  funcionLogin.setString(2, usuario);
//               // funcionLogin.setString(3, contra);
//                funcionLogin.setString(2, usuario);
//                funcionLogin.registerOutParameter(1, Types.INTEGER);//Parametro de salida
//                funcionLogin.execute();
//
//                cone.commit();// confirmar si se ejecuto sin errores
//                nivel = funcionLogin.getInt(1);// obtener salida
//            } catch (SQLException e) {
//                nivel = 0;
//                cone.rollback();// deshacer la ejecucion en caso de error
//                System.out.println("Error al ejecutar función GET_TIPO_USUARIO por, " + e); // informar por consola
//            } finally {
//                cone.close();// cerrar la conexion
//            }
//        }
        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement funcionLogin = cone.prepareCall("{ call VALIDA_USUARIO(?,?,?,?) }");
                // cargar parametros de entrada
                funcionLogin.setString(1, usuario);
                funcionLogin.setString(2, contra);
                //    funcionLogin.setString(2, usuario);

                funcionLogin.registerOutParameter(3, OracleTypes.INTEGER);//Parametro de salida
                funcionLogin.registerOutParameter(4, OracleTypes.VARCHAR);//Parametro de salida
                funcionLogin.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = funcionLogin.getString(4);// obtener salida
                tipo = funcionLogin.getInt(3);// obtener salida
                System.out.println("resp:" + respuesta); // informar por consola
                System.out.println("d:" + tipo); // informar por consola

                if (respuesta.contains("EXITOSAMENTE") && tipo != 0) {
                    cone.close();
                    System.out.println("crear nueva conexión");
                    coneCliente = coneLocal.NewConnection(usuario, contra);
                    if (coneCliente == null) {
                        tipo = 0;
                    }
                }
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función VALIDA_USUARIO por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return tipo;
    }

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

                System.out.println("esta respuesta " + respuesta);
//                insertarUsuario.executeUpdate();
//                ResultSet rsRecords = (ResultSet) insertarUsuario.getObject(3);
            } catch (SQLException e) {
                respuesta = "";
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función CREACION_USUARIO  por, "); // informar por consola
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
    public String insertarCliente(Cliente cliente) throws SQLException {
        String respuesta = "";
        Connection cone = coneLocal.NewConnection();

        System.out.println("Dato: " + cliente.getNOMBRE());
        System.out.println("Dato: " + cliente.getAPELLIDO());
        System.out.println("Dato: " + cliente.getTIPODOCUMENTO());
        System.out.println("Dato: " + cliente.getNUMERO_DOC());
        System.out.println("Dato: " + cliente.getTEL_RESIDENCIA());
        System.out.println("Dato: " + cliente.getTEL_CEL());
        System.out.println("Dato: " + cliente.getNIT());
        System.out.println("Dato: " + cliente.getDIRECCION());
        System.out.println("Dato: " + cliente.getCIUDAD());
        System.out.println("Dato: " + cliente.getDEPARTAMENTO());
        System.out.println("Dato: " + cliente.getPAIS());
        System.out.println("Dato: " + cliente.getPROFESION());
        System.out.println("Dato: " + cliente.getEMAIL());
        System.out.println("Dato: " + cliente.getUSUARIO());
        System.out.println("Dato: " + cliente.getCONTRASENA());

//        if (cliente.getUSUARIO().equals("prueba")) {
//            return "";
//        }
        if (cone != null) {

            try {
                cone.setAutoCommit(false);
                CallableStatement insertarUsuario = cone.prepareCall("{ call CREACION_USUARIO(?,?,?,?) }");

                insertarUsuario.setString(1, cliente.getUSUARIO());
                insertarUsuario.setString(2, cliente.getCONTRASENA());
                insertarUsuario.setString(3, "CLIENTE");

                insertarUsuario.registerOutParameter(4, OracleTypes.VARCHAR);//Parametro de salida
                insertarUsuario.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = (String) insertarUsuario.getObject(4);// obtener salida
                System.out.println("esta respuesta " + respuesta);
//                insertarUsuario.executeUpdate();
//                ResultSet rsRecords = (ResultSet) insertarUsuario.getObject(3);
                // }
//            } catch (SQLException e) {
//                cone.rollback();// deshacer la ejecucion en caso de error
//                System.out.println("Error al ejecutar función  por, "); // informar por consola
//                e.printStackTrace();
//            } finally {
//                cone.close();// cerrar la conexion
//            }

                //  try {
                if (respuesta.contains("EXITOSAMENTE")) {
                    cone.setAutoCommit(false);
                    CallableStatement InsertarCliente = cone.prepareCall("{ call InsertarCliente(?,?,?,?,?," + "?,?,?,?,?, " + "?,?,?,?,?," + "?,?,?,?,?,?)}");

                    // cargar parametros de entrada
                    InsertarCliente.setString(1, cliente.getTIPODOCUMENTO());
                    InsertarCliente.setString(2, cliente.getNUMERO_DOC());
                    InsertarCliente.setString(3, cliente.getNOMBRE());
                    InsertarCliente.setString(4, cliente.getAPELLIDO());
                    InsertarCliente.setString(5, cliente.getTEL_RESIDENCIA());
                    InsertarCliente.setString(6, cliente.getTEL_CEL());
                    InsertarCliente.setString(7, cliente.getNIT());
                    InsertarCliente.setString(8, cliente.getDIRECCION());
                    InsertarCliente.setString(9, cliente.getPROFESION());
                    InsertarCliente.setString(10, cliente.getEMAIL());
                    InsertarCliente.setString(11, "0");//InsertarCliente.setString(14, cliente.getCUENTA_BANCO());
                    InsertarCliente.setString(12, "0");//InsertarCliente.setString(14, cliente.getNUMERO_TARJETA());
                    InsertarCliente.setInt(13, 1);//InsertarCliente.setInt(14, cliente.getESTADO());
                    InsertarCliente.setInt(14, 1);//Banco
                    InsertarCliente.setInt(15, 2);//tipousuario
                    InsertarCliente.setInt(16, cliente.getIddepartamento());
                    InsertarCliente.setInt(17, 1);//tarjeta
                    InsertarCliente.setInt(18, Integer.valueOf(cliente.getPAIS()));
                    InsertarCliente.setString(19, cliente.getCIUDAD());
                    InsertarCliente.setString(20, cliente.getUSUARIO());
                    //InsertarCliente.setString(16, cliente.getCONTRASENA());

                    InsertarCliente.registerOutParameter(21, OracleTypes.VARCHAR);//Parametro de salida
                    InsertarCliente.execute();

                    cone.commit();// confirmar si se ejecuto sin errores
                    respuesta = InsertarCliente.getObject(21).toString();// obtener salida
                    System.out.println("esta otra respuesta " + respuesta);
                }
            } catch (SQLException e) {
                respuesta = "";
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar InsertarCliente  por, " + e); // informar por consola
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
    public String ModificarCliente(Cliente cliente) throws SQLException {
        String respuesta = "";
        Connection cone = coneLocal.NewConnection();

        System.out.println("Dato: " + cliente.getNOMBRE());
        System.out.println("Dato: " + cliente.getAPELLIDO());
        System.out.println("Dato: " + cliente.getTIPODOCUMENTO());
        System.out.println("Dato: " + cliente.getNUMERO_DOC());
        System.out.println("Dato: " + cliente.getTEL_RESIDENCIA());
        System.out.println("Dato: " + cliente.getTEL_CEL());
        System.out.println("Dato: " + cliente.getNIT());
        System.out.println("Dato: " + cliente.getDIRECCION());
        System.out.println("Dato: " + cliente.getCIUDAD());
        System.out.println("Dato: " + cliente.getDEPARTAMENTO());
        System.out.println("Dato: " + cliente.getPAIS());
        System.out.println("Dato: " + cliente.getPROFESION());
        System.out.println("Dato: " + cliente.getEMAIL());
        System.out.println("Dato: " + cliente.getUSUARIO());
        System.out.println("Dato: " + cliente.getCONTRASENA());

//        if (cliente.getUSUARIO().equals("prueba")) {
//            return "";
//        }
        if (cone != null) {

            try {
                cone.setAutoCommit(false);
                CallableStatement ModificarCliente = cone.prepareCall("{ call ActualizarCliente(?,?,?,?,?," + "?,?,?,?,?, " + "?,?,?,?,?," + "?,?,?,?,?,?)}");

                // cargar parametros de entrada
                ModificarCliente.setString(1, cliente.getTIPODOCUMENTO());
                ModificarCliente.setString(2, cliente.getNUMERO_DOC());
                ModificarCliente.setString(3, cliente.getNOMBRE());
                ModificarCliente.setString(4, cliente.getAPELLIDO());
                ModificarCliente.setString(5, cliente.getTEL_RESIDENCIA());
                ModificarCliente.setString(6, cliente.getTEL_CEL());
                ModificarCliente.setString(7, cliente.getNIT());
                ModificarCliente.setString(8, cliente.getDIRECCION());
                ModificarCliente.setString(9, cliente.getPROFESION());
                ModificarCliente.setString(10, cliente.getEMAIL());
                ModificarCliente.setString(11, "0");//ModificarCliente.setString(14, cliente.getCUENTA_BANCO());
                ModificarCliente.setString(12, "0");//ModificarCliente.setString(14, cliente.getNUMERO_TARJETA());
                ModificarCliente.setInt(13, 1);//ModificarCliente.setInt(14, cliente.getESTADO());
                ModificarCliente.setInt(14, 1);//Banco
                ModificarCliente.setInt(15, 2);//tipousuario
                ModificarCliente.setInt(16, cliente.getIddepartamento());
                ModificarCliente.setInt(17, 1);//tarjeta
                ModificarCliente.setInt(18, Integer.valueOf(cliente.getPAIS()));
                ModificarCliente.setString(19, cliente.getCIUDAD());
                ModificarCliente.setString(20, cliente.getUSUARIO());
                //ModificarCliente.setString(16, cliente.getCONTRASENA());

                ModificarCliente.registerOutParameter(21, OracleTypes.VARCHAR);//Parametro de salida
                ModificarCliente.execute();

                cone.commit();// confirmar si se ejecuto sin errores
                respuesta = ModificarCliente.getObject(21).toString();// obtener salida
                System.out.println("esta otra respuesta " + respuesta);
            } catch (SQLException e) {
                respuesta = "";
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar InsertarCliente  por, " + e); // informar por consola
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
     * @param Usuario

     * @throws java.sql.SQLException
     */
    public Cliente mostrarDatosCliente(String Usuario) throws SQLException {
        // int respuesta = 0;
        Connection cone = coneLocal.NewConnection();

        Cliente cliente = new Cliente();
        if (cone != null) {
            try {
                cone.setAutoCommit(false);
                CallableStatement mostrarDatosCliente = cone.prepareCall("{ call ConsultaCliente(?,?) } ");

                // cargar parametros de entrada
                mostrarDatosCliente.setString(1, Usuario);
                mostrarDatosCliente.registerOutParameter(2, OracleTypes.CURSOR);//Parametro de salida
                //mostrarDatosCliente.execute();

                mostrarDatosCliente.executeUpdate();
                ResultSet rsRecords = (ResultSet) mostrarDatosCliente.getObject(2);

                if (rsRecords != null) {
                     System.out.println("Hay data");
                    while (rsRecords.next()) {
                        cliente.setNOMBRE(rsRecords.getString("NOMBRE"));
                        cliente.setAPELLIDO(rsRecords.getString("APELLIDO"));
                        cliente.setTIPODOCUMENTO(rsRecords.getString("TIPODOCUMENTO"));
                        cliente.setNUMERO_DOC(rsRecords.getString("NUMERO_DOC"));
                        cliente.setTEL_RESIDENCIA(rsRecords.getString("TEL_RESIDENCIA"));
                        cliente.setTEL_CEL(rsRecords.getString("TEL_CEL"));
                        cliente.setNIT(rsRecords.getString("NIT"));
                        cliente.setDIRECCION(rsRecords.getString("DIRECCION"));
                        cliente.setCIUDAD(rsRecords.getString("CIUDAD_RESIDENCIA"));
//                        cliente.setPAIS(rsRecords.getString("PAIS"));
//                        cliente.setDEPARTAMENTO(rsRecords.getString("DEPARTAMENTO"));
                        cliente.setPROFESION(rsRecords.getString("PROFESION"));
                        cliente.setUSUARIO(rsRecords.getString("USUARIO"));
                     //   cliente.setCONTRASENA(rsRecords.getString("PASSWORD"));
                    }
                }
                
                cone.commit();// confirmar si se ejecuto sin errores
            } catch (SQLException e) {
                cone.rollback();// deshacer la ejecucion en caso de error
                System.out.println("Error al ejecutar función ConsultaCliente por, " + e); // informar por consola
            } finally {
                cone.close();// cerrar la conexion
            }
        }
        return cliente;
    }

    /**
     * Muestra pais
     *
     * liente
     *
     * @return
     * @throws java.sql.SQLException
     */
    public ArrayList<String> mostrarPais() throws SQLException {
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
                        pais.add(rsRecords.getString("IDPAIS") + ";" + rsRecords.getString("PAIS"));
                    }
                }
                cone.commit();// confirmar si se ejecuto sin errores
            } catch (SQLException e) {
                pais.add(" ; SIN PAISES");
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
     * liente
     *
     * @return
     * @throws java.sql.SQLException
     */
    public ArrayList<String> mostrarDepartamento(int p) throws SQLException {
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
                        System.out.println("Ha" + rsRecords.getString("IDDEPARTAMENTO") + ";" + rsRecords.getString("NOMBREDEPARTAMENTO"));
                        pais.add(rsRecords.getString("IDDEPARTAMENTO") + ";" + rsRecords.getString("NOMBREDEPARTAMENTO"));
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
