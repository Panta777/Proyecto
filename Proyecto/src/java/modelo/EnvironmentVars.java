package modelo;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * Clase que representa las distintas variables de ambiente del sistema.
 *
 *
 */
public class EnvironmentVars {

    private Context currentContext = null;
    private String dbDataSourceName = "";
    private String dtePath = "";
    private String MODO = "OnLine";
    private String SMTP_HOST_NAME = "";
    private String SMTP_HOST_PORT = "";
    private String SMTP_FROM = "";
    private String SMTP_AUTH_REQ = "false";
    private String SMTP_AUTH_USER = "";
    private String SMTP_AUTH_PWD = "";
    private String EMAIL_ACTIVE = "false";

    private String DB_CLASSNAME = "";
    private String DB_URL = "";
    private String DB_USERNAME = "";
    private String DB_PASSWORD = "";

    public void setDB_USERNAME(String DB_USERNAME) {
        this.DB_USERNAME = DB_USERNAME;
    }

    public void setDB_PASSWORD(String DB_PASSWORD) {
        this.DB_PASSWORD = DB_PASSWORD;
    }

    public EnvironmentVars() {
        try {
            currentContext = new InitialContext();

            dbDataSourceName = (String) currentContext.lookup("java:comp/env/DBDATASOURCE");
            dtePath = (String) currentContext.lookup("java:comp/env/DTE_PATH");
            MODO = (String) currentContext.lookup("java:comp/env/MODO");
            SMTP_HOST_NAME = (String) currentContext.lookup("java:comp/env/SMTP_HOST_NAME");
            SMTP_HOST_PORT = (String) currentContext.lookup("java:comp/env/SMTP_HOST_PORT");
            SMTP_FROM = (String) currentContext.lookup("java:comp/env/SMTP_FROM");
            SMTP_AUTH_REQ = (String) currentContext.lookup("java:comp/env/SMTP_AUTH_REQ");
            SMTP_AUTH_USER = (String) currentContext.lookup("java:comp/env/SMTP_AUTH_USER");
            SMTP_AUTH_PWD = (String) currentContext.lookup("java:comp/env/SMTP_AUTH_PWD");
            EMAIL_ACTIVE = (String) currentContext.lookup("java:comp/env/EMAIL_ACTIVO");

            DB_CLASSNAME = (String) currentContext.lookup("java:comp/env/DB_CLASSNAME");
            DB_URL = (String) currentContext.lookup("java:comp/env/DB_URL");
            DB_USERNAME = (String) currentContext.lookup("java:comp/env/DB_USERNAME");
            DB_PASSWORD = (String) currentContext.lookup("java:comp/env/DB_PASSWORD");

//            System.out.println("url: " + DB_URL);
//            System.out.println("USER: " + DB_USERNAME);
//            System.out.println("PASS: " + DB_PASSWORD);
        } catch (NamingException nE) {
            System.out.println("VariablesAmbiente()...Error al obtener variables del contexto...: " + nE.getMessage());
        }
    }

    /**
     * @return the dbDataSourceName
     */
    public String getDbDataSourceName() {
        return dbDataSourceName;
    }

    /**
     * @return the dtePath
     */
    public String getDtePath() {
        return dtePath;
    }

    /**
     * @return the MODO Online / StandAlone
     */
    public String getMODO() {
        return MODO;
    }

    /**
     * @return the SMTP_HOST_NAME
     */
    public String getSMTP_HOST_NAME() {
        return SMTP_HOST_NAME;
    }

    /**
     * @return the SMTP_HOST_PORT
     */
    public String getSMTP_HOST_PORT() {
        return SMTP_HOST_PORT;
    }

    /**
     * @return the SMTP_FROM
     */
    public String getSMTP_FROM() {
        return SMTP_FROM;
    }

    /**
     * @return the SMTP_AUTH_REQ
     */
    public String getSMTP_AUTH_REQ() {
        return SMTP_AUTH_REQ;
    }

    /**
     * @return the SMTP_AUTH_USER
     */
    public String getSMTP_AUTH_USER() {
        return SMTP_AUTH_USER;
    }

    /**
     * @return the SMTP_AUTH_PWD
     */
    public String getSMTP_AUTH_PWD() {
        return SMTP_AUTH_PWD;
    }

    /**
     * @return the EMAIL_ACTIVE
     */
    public String getEMAIL_ACTIVE() {
        return EMAIL_ACTIVE;
    }

    /**
     * @return the currentContext
     */
    public Context getCurrentContext() {
        return currentContext;
    }

    /**
     * @return the DB_URL
     */
    public String getDB_URL() {
        return DB_URL;
    }

    /**
     * @param DB_URL the DB_URL to set
     */
    public void setDB_URL(String DB_URL) {
        this.DB_URL = DB_URL;
    }

    /**
     * @return the DB_USERNAME
     */
    public String getDB_USERNAME() {
        return DB_USERNAME;
    }

    /**
     * @return the DB_PASSWORD
     */
    public String getDB_PASSWORD() {
        return DB_PASSWORD;
    }

    /**
     * @return the DB_CLASSNAME
     */
    public String getDB_CLASSNAME() {
        return DB_CLASSNAME;
    }

    /**
     * @SETS the DB_CLASSNAME
     */
    public void setDB_CLASSNAME(String DB_CLASSNAME) {
        this.DB_CLASSNAME = DB_CLASSNAME;
    }
}