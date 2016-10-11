package modelo;

import java.net.InetAddress;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Clase Utileria,  contiene varios metodos utiles para el programa, como la obtencion de fechas en formatos especiales.
 * @author (JA)
 */
public class Utileria {

    private String referencia = "";

    /**
     *
     */
    public Utileria() {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();
        int x = new Double(Math.random() * 999).intValue();

        referencia = String.valueOf(today.get(java.util.GregorianCalendar.YEAR)).substring(3);
        referencia += String.format("%03d", today.get(java.util.GregorianCalendar.DAY_OF_YEAR));
//        referencia += String.format("%02d", today.get(java.util.GregorianCalendar.HOUR_OF_DAY));
//        referencia += String.format("%02d", today.get(java.util.GregorianCalendar.MINUTE));
//        referencia += String.format("%02d", today.get(java.util.GregorianCalendar.SECOND));
        int hora = today.get(java.util.GregorianCalendar.HOUR_OF_DAY);
        int minuto = today.get(java.util.GregorianCalendar.MINUTE);
        int segundo = today.get(java.util.GregorianCalendar.SECOND);
        long timestamp = (((hora*60)+minuto)*60)+segundo;
        
        referencia += String.format("%05d", timestamp);
        referencia += String.format("%03d", x);
    }

    /**
     * Get the value of referencia
     *
     * @return the value of referencia
     */
    public String getReferencia() {
        return referencia;
    }

    public String getAutorizacion() {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();
        
        String autorizacion = String.valueOf(today.get(java.util.GregorianCalendar.YEAR)).substring(3,4);
        autorizacion += rellenaString(String.valueOf(today.get(java.util.GregorianCalendar.DAY_OF_YEAR)), '0', 3, 1);
        autorizacion += String.valueOf(today.get(java.util.GregorianCalendar.HOUR_OF_DAY));
        autorizacion += String.valueOf(today.get(java.util.GregorianCalendar.MINUTE));
        
        return autorizacion;
    }
         
    /**
     * Retorna la fecha del sistema en formato yyyy/mm/dd
     * @return la fecha del sistema en formato yyyy/mm/dd
     */
    public String getFecha() {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();

        String fecha = "";
        fecha  = String.format("%04d", today.get(java.util.GregorianCalendar.YEAR));
        fecha += "/";
        fecha += String.format("%02d", (today.get(java.util.GregorianCalendar.MONTH) + 1));
        fecha += "/";
        fecha += String.format("%02d", today.get(java.util.GregorianCalendar.DAY_OF_MONTH));

        return fecha;
    }


    /**
     * Retorna un string dd/mm/yyyy conteniendo el valor dateToConvert enviado dd/mm/yy
     * @return la fecha del sistema en formato dd/mm/yy
     */
    public String getFecha(Date dateToConvert) {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();
        today.setTime(dateToConvert);

        String fecha = "";
        fecha  = String.format("%02d", today.get(java.util.GregorianCalendar.DAY_OF_MONTH));
        fecha += "/";
        fecha += String.format("%02d", (today.get(java.util.GregorianCalendar.MONTH) + 1));
        fecha += "/";
        fecha += String.format("%04d", today.get(java.util.GregorianCalendar.YEAR));

        return fecha;
    }

        
    /**
     * Convierte un string dado en el formato YYYY-MM-dd a dd/NameMonth/YY
     *
     * @return String fecha formato dd/NameMonth/YY
     * 
     **/   
    public  String getFechaMesLargo(String date)
    {
        String fecha="";
        int month=0;
            
        String meses[]  = {"Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic"};
        try
        { 
            month= Integer.parseInt(date.substring(5, 7));
            fecha="";
            fecha += date.substring(8, 10);
            fecha += "/";
            fecha += meses[month-1];
            fecha += "/";
            fecha += date.substring(0, 4);
        }catch(Exception ex)
        {
            System.out.println("Fecha Incorrecta...! "+ex);
        }
        return fecha;
    }
    
    /**
     * Retorna un string yyyy/mm/dd conteniendo el valor dateToConvert enviado dd/mm/yy
     * @return la fecha en formato yyyy/mm/dd
     */
    public String getFechaYYYYMMDD(Date dateToConvert) {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();
        today.setTime(dateToConvert);

        String fecha = "";
        fecha  = String.format("%04d", today.get(java.util.GregorianCalendar.YEAR));
        fecha += "/";
        fecha += String.format("%02d", (today.get(java.util.GregorianCalendar.MONTH) + 1));
        fecha += "/";
        fecha += String.format("%02d", today.get(java.util.GregorianCalendar.DAY_OF_MONTH));

        return fecha;
    }

    /**
     * Retorna un string yyyy-mm-dd conteniendo el valor dateToConvert enviado dd-mm-yy
     * @return la fecha en formato yyyy-mm-dd
     */
    public String getFechaYYYYMMDD_1(Date dateToConvert) {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();
        today.setTime(dateToConvert);

        String fecha = "";
        fecha  = String.format("%04d", today.get(java.util.GregorianCalendar.YEAR));
        fecha += "-";
        fecha += String.format("%02d", (today.get(java.util.GregorianCalendar.MONTH) + 1));
        fecha += "-";
        fecha += String.format("%02d", today.get(java.util.GregorianCalendar.DAY_OF_MONTH));

        return fecha;
    }
    
    /**
     * Para la fecha de nacimiento
     * @return campo Date con la fecha 1990-01-01
     */
    public Date getPastDate() {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();
        today.set(1990, 1, 1);

        return today.getTime();
    }

    /**
     * Retorna la hora del sistema en formato HHmmss
     * @return la hora del sistema en formato HHmmss
     */
    public String getHora() {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();

        String hora = "";
        hora  = String.format("%02d", today.get(java.util.GregorianCalendar.HOUR_OF_DAY));
        hora += String.format("%02d", today.get(java.util.GregorianCalendar.MINUTE));
        hora += String.format("%02d", today.get(java.util.GregorianCalendar.SECOND));

        return hora;
    }

    /**
     * Retorna la fecha y la hora del sistema en formato yyyy/mm/dd HH:mm:ss
     * @return la fecha y la hora del sistema en formato yyyy/mm/dd HH:mm:ss
     */
    public String getFechaHoraFormateada() {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();

        String fechaHora = "";
        fechaHora  = String.format("%04d", today.get(java.util.GregorianCalendar.YEAR));
        fechaHora += "/";
        fechaHora += String.format("%02d", (today.get(java.util.GregorianCalendar.MONTH) + 1));
        fechaHora += "/";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.DAY_OF_MONTH));
        fechaHora += " ";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.HOUR_OF_DAY));
        fechaHora += ":";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.MINUTE));
        fechaHora += ":";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.SECOND));

        return fechaHora;
    }
    
    /**
     * Retorna la fecha y la hora del sistema en formato yyyy/mm/dd HH:mm:ss
     * @return la fecha y la hora del sistema en formato yyyy/mm/dd HH:mm:ss
     */
    public String getFechaHoraFormateada(Date dateToConvert) {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();
        today.setTime(dateToConvert);

        String fechaHora = "";
        fechaHora  = String.format("%04d", today.get(java.util.GregorianCalendar.YEAR));
        fechaHora += "/";
        fechaHora += String.format("%02d", (today.get(java.util.GregorianCalendar.MONTH) + 1));
        fechaHora += "/";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.DAY_OF_MONTH));
        fechaHora += " ";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.HOUR_OF_DAY));
        fechaHora += ":";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.MINUTE));
        fechaHora += ":";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.SECOND));

        return fechaHora;
    }

    /**
     * Retorna la fecha y la hora del sistema en formato dd/mm/yyyy HH:mm:ss
     * @return la fecha y la hora del sistema en formato dd/mm/yyyy HH:mm:ss
     */
    public String getFechaHoraFormateada2(Date dateToConvert) {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();
        today.setTime(dateToConvert);

        String fechaHora = "";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.DAY_OF_MONTH));
        fechaHora += "/";
        fechaHora += String.format("%02d", (today.get(java.util.GregorianCalendar.MONTH) + 1));
        fechaHora += "/";
        fechaHora += String.format("%04d", today.get(java.util.GregorianCalendar.YEAR));
        fechaHora += " ";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.HOUR_OF_DAY));
        fechaHora += ":";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.MINUTE));
        fechaHora += ":";
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.SECOND));

        return fechaHora;
    }

    /**
     * Retorna la fecha y la hora del sistema en formato yyyymmddHHmmss
     * @return la fecha y hora del sistema en formato yyyymmddHHmmss
     */
    public String getFechaHoraSinFormato() {
        java.util.GregorianCalendar today = new java.util.GregorianCalendar();

        String fechaHora = "";
        fechaHora  = String.format("%04d", today.get(java.util.GregorianCalendar.YEAR));
        fechaHora += String.format("%02d", (today.get(java.util.GregorianCalendar.MONTH) + 1));
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.DAY_OF_MONTH));
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.HOUR_OF_DAY));
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.MINUTE));
        fechaHora += String.format("%02d", today.get(java.util.GregorianCalendar.SECOND));

        return fechaHora;
    }

    /**
     * Retorna la ip local
     * @return la ip local
     */
    public String getLocalIpAddress() {
        String ipAddress = "";
        try{
            InetAddress ownIP=InetAddress.getLocalHost();
            ipAddress = ownIP.getHostAddress();
            //System.out.println("Identificacion de NODO " + ipAddress);
        }catch (Exception e){
            e.printStackTrace();
        }
        return ipAddress;
    }

    /**
     * Rellena una cadena con el caracter de relleno,  de una longitud dada y hacia la izquierda o hacia la derecha.
     * @param cadena String con la cadena original
     * @param caracterRelleno char[1]  contiene el caracter de relleno
     * @param longitud int largo del relleno o de la cadena final...
     * @param lado int 0=izquierda,  1=derecha
     * @return String nueva cadena de caracteres.
     */
    public String rellenaString(String cadena, char caracterRelleno, int longitud, int lado) {
        String salida = cadena;

        //Si tiene la misma longitud la devuelve
        if(salida.length() == longitud)	return salida;
        //Si es mas larga la trunca
        if(salida.length() > longitud)	return salida.substring(0,longitud);
        //Si es menor, entonces modificamos
        if(salida.length() < longitud) {
            if(lado == 1) {
                //	Rellenar por la derecha
                for(int k=cadena.length();k<longitud;k++)
                    salida = salida + caracterRelleno;
            }
            else {
                if (lado == 0){
                    //	Rellenar por la izquierda
                    for(int k=cadena.length();k<longitud;k++)
                        salida = caracterRelleno + salida;
                }
                else {
                    return "Lado es incorrecto";
                }
            }

            return salida;
        }
        return cadena;
    }
   
    /**
     * Escribe en la salida standard de JAVA o Tomcat.
     * @param sessionID
     * @param eFace
     * @param textoLog 
     */
    public void escribirLog(String sessionID, String posInfo, String textoLog) {
        String sNuevoTexto;
        byte[] buf = new byte[1024];
        Date fechaActual;
        SimpleDateFormat formatoFechaHora;
        String fechaHoraActual;

        fechaActual = new Date() ;
        formatoFechaHora = new SimpleDateFormat("yyyyMMdd_HHmmss");
        fechaHoraActual = formatoFechaHora.format(fechaActual);
        String nuevoTexto = fechaHoraActual + " PronetWebPay v 1.0 (" + sessionID + " " + posInfo + ") [" + textoLog.trim() + "]";

        System.out.println(nuevoTexto.trim());
        
/**
        if(sMensaje.contains("-2|ERROR") || sMensaje.contains("-1|ERROR") || sMensaje.contains("INSERT INTO")) {
            EnviarCorreo enviarCorreo = new EnviarCorreo(sEmailSMTP, sEmailFrom,  sEmailFrom, "Error en SwitchTelepin", sNuevoTexto);
            System.out.println("EMAIL:" + sEmailSMTP + " " + sEmailFrom + " "  + sMensaje);
                    
            enviarCorreo.send();
        }
**/        

/**
        try {
            
            MulticastSocket mServer =  new MulticastSocket();
                    
            InetAddress group = InetAddress.getByName("225.4.5.6");
        
            DatagramPacket packet;
        
            buf = sNuevoTexto.getBytes();
            packet = new DatagramPacket(buf, buf.length, group, 4459); 
          
            mServer.send(packet);
            
       }
        catch(Exception ex1) {
            System.out.println("ERROR (EscribirLog(()): " + ex1.getMessage().trim());
        } 
 *****/ 
    }  

    /**
     * Remueve caracteres especiales newline, carriage return, tab y white space,  de la cadena dada.
     *
     * @param toBeEscaped string to escape
     * @return String nueva cadena de carecteres sin los caracteres especiales.
     * 
     **/
    public static String removeFormattingCharacters(final String toBeEscaped) {
        StringBuilder escapedBuffer = new StringBuilder();
        for (int i = 0; i < toBeEscaped.length(); i++) {
            if ((toBeEscaped.charAt(i) != '\n') && (toBeEscaped.charAt(i) != '\r') 
                    && (toBeEscaped.charAt(i) != '\t')) {
                escapedBuffer.append(toBeEscaped.charAt(i));
            }
        }
        String s = escapedBuffer.toString().trim();
        return s;//
        // Strings.replaceSubString(s, "\"", "")
    }
       
}
