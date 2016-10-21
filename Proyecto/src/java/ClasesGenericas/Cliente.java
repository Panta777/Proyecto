/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesGenericas;

/**
 *
 * @author panle
 */
public class Cliente {

    private int ID_CLIENTE;
    private String USUARIO;
    private String CONTRASENA;
    private String NUMERO_DOC;
    private String TIPODOCUMENTO;
    private String NOMBRE;
    private String APELLIDO;
    private String TEL_RESIDENCIA;
    private String TEL_CEL;
    private String NIT;
    private String DIRECCION;
    private String CIUDAD;
    private String PAIS;
    private String DEPARTAMENTO;
    private String PROFESION;
    private String EMAIL;
    private String FECHA_ALTA;
    private String FECHA_BAJA;
    private String CUENTA_BANCO;
    private String NUMERO_TARJETA;
    private int ESTADO;
    private int ID_USUARIO;
    private int idbanco;
    private int identidad;
    private int Iddepartamento;
    private String IdTarjeta;

    public Cliente() {
        this.ID_CLIENTE = 0;
        this.NUMERO_DOC = "";
        this.TIPODOCUMENTO = "";
        this.NOMBRE = "";
        this.APELLIDO = "";
        this.TEL_RESIDENCIA = "";
        this.TEL_CEL = "";
        this.NIT = "";
        this.DIRECCION = "";
        this.PAIS = "";
        this.DEPARTAMENTO = "";
        this.PROFESION = "";
        this.EMAIL = "";
        this.FECHA_ALTA = "";
        this.FECHA_BAJA = "";
        this.CUENTA_BANCO = "";
        this.NUMERO_TARJETA = "";
        this.ESTADO = 0;
        this.ID_USUARIO = 0;
        this.idbanco = 0;
        this.identidad = 0;
        this.Iddepartamento = 0;
        this.USUARIO = "";
        this.CIUDAD = "";
    }

    public Cliente(String NOMBRE, String APELLIDO, String USUARIO, String NUMERO_DOC,String PROFESION, String TEL_CEL, String TEL_RESIDENCIA, String NIT, String DIRECCION, String CIUDAD ) {
        this.NOMBRE = NOMBRE;
        this.APELLIDO = APELLIDO;
        this.USUARIO = USUARIO;
        this.NUMERO_DOC = NUMERO_DOC;
        this.PROFESION = PROFESION;
        this.TEL_CEL = TEL_CEL;
        this.TEL_RESIDENCIA = TEL_RESIDENCIA;
        this.NIT = NIT;
        this.DIRECCION = DIRECCION;
        this.CIUDAD = CIUDAD;
    }

    public String getCIUDAD() {
        return CIUDAD;
    }

    public void setCIUDAD(String CIUDAD) {
        this.CIUDAD = CIUDAD;
    }

    public String getUSUARIO() {
        return USUARIO;
    }

    public void setUSUARIO(String USUARIO) {
        this.USUARIO = USUARIO;
    }

    public String getCONTRASENA() {
        return CONTRASENA;
    }

    public void setCONTRASENA(String CONTRASENA) {
        this.CONTRASENA = CONTRASENA;
    }

    public int getID_CLIENTE() {
        return ID_CLIENTE;
    }

    public void setID_CLIENTE(int ID_CLIENTE) {
        this.ID_CLIENTE = ID_CLIENTE;
    }

    public String getNUMERO_DOC() {
        return NUMERO_DOC;
    }

    public void setNUMERO_DOC(String NUMERO_DOC) {
        this.NUMERO_DOC = NUMERO_DOC;
    }

    public String getTIPODOCUMENTO() {
        return TIPODOCUMENTO;
    }

    public void setTIPODOCUMENTO(String TIPODOCUMENTO) {
        this.TIPODOCUMENTO = TIPODOCUMENTO;
    }

    public String getNOMBRE() {
        return NOMBRE;
    }

    public void setNOMBRE(String NOMBRE) {
        this.NOMBRE = NOMBRE;
    }

    public String getAPELLIDO() {
        return APELLIDO;
    }

    public void setAPELLIDO(String APELLIDO) {
        this.APELLIDO = APELLIDO;
    }

    public String getTEL_RESIDENCIA() {
        return TEL_RESIDENCIA;
    }

    public void setTEL_RESIDENCIA(String TEL_RESIDENCIA) {
        this.TEL_RESIDENCIA = TEL_RESIDENCIA;
    }

    public String getTEL_CEL() {
        return TEL_CEL;
    }

    public void setTEL_CEL(String TEL_CEL) {
        this.TEL_CEL = TEL_CEL;
    }

    public String getNIT() {
        return NIT;
    }

    public void setNIT(String NIT) {
        this.NIT = NIT;
    }

    public String getDIRECCION() {
        return DIRECCION;
    }

    public void setDIRECCION(String DIRECCION) {
        this.DIRECCION = DIRECCION;
    }

    public String getPAIS() {
        return PAIS;
    }

    public void setPAIS(String PAIS) {
        this.PAIS = PAIS;
    }

    public String getDEPARTAMENTO() {
        return DEPARTAMENTO;
    }

    public void setDEPARTAMENTO(String DEPARTAMENTO) {
        this.DEPARTAMENTO = DEPARTAMENTO;
    }

    public String getPROFESION() {
        return PROFESION;
    }

    public void setPROFESION(String PROFESION) {
        this.PROFESION = PROFESION;
    }

    public String getEMAIL() {
        return EMAIL;
    }

    public void setEMAIL(String EMAIL) {
        this.EMAIL = EMAIL;
    }

    public String getFECHA_ALTA() {
        return FECHA_ALTA;
    }

    public void setFECHA_ALTA(String FECHA_ALTA) {
        this.FECHA_ALTA = FECHA_ALTA;
    }

    public String getFECHA_BAJA() {
        return FECHA_BAJA;
    }

    public void setFECHA_BAJA(String FECHA_BAJA) {
        this.FECHA_BAJA = FECHA_BAJA;
    }

    public String getCUENTA_BANCO() {
        return CUENTA_BANCO;
    }

    public void setCUENTA_BANCO(String CUENTA_BANCO) {
        this.CUENTA_BANCO = CUENTA_BANCO;
    }

    public String getNUMERO_TARJETA() {
        return NUMERO_TARJETA;
    }

    public void setNUMERO_TARJETA(String NUMERO_TARJETA) {
        this.NUMERO_TARJETA = NUMERO_TARJETA;
    }

    public int getESTADO() {
        return ESTADO;
    }

    public void setESTADO(int ESTADO) {
        this.ESTADO = ESTADO;
    }

    public int getID_USUARIO() {
        return ID_USUARIO;
    }

    public void setID_USUARIO(int ID_USUARIO) {
        this.ID_USUARIO = ID_USUARIO;
    }

    public int getIdbanco() {
        return idbanco;
    }

    public void setIdbanco(int idbanco) {
        this.idbanco = idbanco;
    }

    public int getIdentidad() {
        return identidad;
    }

    public void setIdentidad(int identidad) {
        this.identidad = identidad;
    }

    public int getIddepartamento() {
        return Iddepartamento;
    }

    public void setIddepartamento(int Iddepartamento) {
        this.Iddepartamento = Iddepartamento;
    }

    public String getIdTarjeta() {
        return IdTarjeta;
    }

    public void setIdTarjeta(String IdTarjeta) {
        this.IdTarjeta = IdTarjeta;
    }
}
