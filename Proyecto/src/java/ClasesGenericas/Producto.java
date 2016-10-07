/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesGenericas;

/**
 *
 * @author panle
 */
public class Producto {

    public Producto(int ID_PRODUCTO, String NOMBRE,String REFERENCIA, String DESCRIPCION, String TIPO, String MATERIAL, String ALTO, String ANCHO, String PROFUNDIDAD, String COLOR, String PESO, String FOTO, String FECHA_ALTA, String FECHA_BAJA, String ESTADO, double PRECIOCOSTO, double PRECIOVENTA) {
        this.ID_PRODUCTO = ID_PRODUCTO;
        this.NOMBRE = NOMBRE;
        this.REFERENCIA = REFERENCIA;
        this.DESCRIPCION = DESCRIPCION;
        this.TIPO = TIPO;
        this.MATERIAL = MATERIAL;
        this.ALTO = ALTO;
        this.ANCHO = ANCHO;
        this.PROFUNDIDAD = PROFUNDIDAD;
        this.COLOR = COLOR;
        this.PESO = PESO;
        this.FOTO = FOTO;
        this.FECHA_ALTA = FECHA_ALTA;
        this.FECHA_BAJA = FECHA_BAJA;
        this.ESTADO = ESTADO;
        this.PRECIOCOSTO = PRECIOCOSTO;
        this.PRECIOVENTA = PRECIOVENTA;
    }

    private int ID_PRODUCTO;
    private String NOMBRE;

    public String getNOMBRE() {
        return NOMBRE;
    }

    public void setNOMBRE(String NOMBRE) {
        this.NOMBRE = NOMBRE;
    }

    public double getPRECIOCOSTO() {
        return PRECIOCOSTO;
    }

    public void setPRECIOCOSTO(double PRECIOCOSTO) {
        this.PRECIOCOSTO = PRECIOCOSTO;
    }
    private String REFERENCIA;
    private String DESCRIPCION;
    private String TIPO;
    private String MATERIAL;
    private String ALTO;
    private String ANCHO;
    private String PROFUNDIDAD;
    private String COLOR;
    private String PESO;
    private String FOTO;
    private String FECHA_ALTA;
    private String FECHA_BAJA;
    private String ESTADO;
    private double PRECIOCOSTO;
    private double PRECIOVENTA;

        public Producto() {
        this.ID_PRODUCTO = 0;
        this.REFERENCIA = "";
        this.DESCRIPCION = "";
        this.TIPO = "";
        this.MATERIAL = "";
        this.ALTO = "";
        this.ANCHO = "";
        this.PROFUNDIDAD = "";
        this.COLOR = "";
        this.PESO = "";
        this.FOTO = "";
        this.FECHA_ALTA = "";
        this.FECHA_BAJA = "";
        this.ESTADO = "";
        this.PRECIOCOSTO = 0.0;
        this.PRECIOVENTA = 0.0;
    }

    public int getID_PRODUCTO() {
        return ID_PRODUCTO;
    }

    public void setID_PRODUCTO(int ID_PRODUCTO) {
        this.ID_PRODUCTO = ID_PRODUCTO;
    }

    public String getREFERENCIA() {
        return REFERENCIA;
    }

    public void setREFERENCIA(String REFERENCIA) {
        this.REFERENCIA = REFERENCIA;
    }

    public String getDESCRIPCION() {
        return DESCRIPCION;
    }

    public void setDESCRIPCION(String DESCRIPCION) {
        this.DESCRIPCION = DESCRIPCION;
    }

    public String getTIPO() {
        return TIPO;
    }

    public void setTIPO(String TIPO) {
        this.TIPO = TIPO;
    }

    public String getMATERIAL() {
        return MATERIAL;
    }

    public void setMATERIAL(String MATERIAL) {
        this.MATERIAL = MATERIAL;
    }

    public String getALTO() {
        return ALTO;
    }

    public void setALTO(String ALTO) {
        this.ALTO = ALTO;
    }

    public String getANCHO() {
        return ANCHO;
    }

    public void setANCHO(String ANCHO) {
        this.ANCHO = ANCHO;
    }

    public String getPROFUNDIDAD() {
        return PROFUNDIDAD;
    }

    public void setPROFUNDIDAD(String PROFUNDIDAD) {
        this.PROFUNDIDAD = PROFUNDIDAD;
    }

    public String getCOLOR() {
        return COLOR;
    }

    public void setCOLOR(String COLOR) {
        this.COLOR = COLOR;
    }

    public String getPESO() {
        return PESO;
    }

    public void setPESO(String PESO) {
        this.PESO = PESO;
    }

    public String getFOTO() {
        return FOTO;
    }

    public void setFOTO(String FOTO) {
        this.FOTO = FOTO;
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

    public String getESTADO() {
        return ESTADO;
    }

    public void setESTADO(String ESTADO) {
        this.ESTADO = ESTADO;
    }

    public double getPRECIO() {
        return PRECIOCOSTO;
    }

    public void setPRECIO(double PRECIOCOSTO) {
        this.PRECIOCOSTO = PRECIOCOSTO;
    }

    public double getPRECIOVENTA() {
        return PRECIOVENTA;
    }

    public void setPRECIOVENTA(double PRECIOVENTA) {
        this.PRECIOVENTA = PRECIOVENTA;
    }
}
