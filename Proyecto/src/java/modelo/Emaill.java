

package modelo;
/**
Some SMTP servers require a username and password authentication before you
can use their Server for Sending mail. This is most common with couple
of ISP's who provide SMTP Address to Send Mail.

This Program gives any example on how to do SMTP Authentication
(User and Password verification)

This is a free source code and is provided as it is without any warranties and
it can be used in any your code for free.

Author : Sudhir Ancha
**/

import java.io.File;
import java.security.Security;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;
import javax.activation.*;

public class Emaill
{
    String smtpHostName   = "";
    String smtpHostPort   = "";
    String smtpAuthReq    = "";
    String smtpAuthUser   = "";
    String smtpAuthPasswd = "";
    String smtpMailFrom   = "";
    
    private Properties props = null; 

    public Emaill() {
        
        EnvironmentVars  variablesAmbiente = new EnvironmentVars();

/**        
        this.smtpHostName   = smtpHostName;
        this.smtpHostPort   = smtpHostPort;
        this.smtpAuthReq    = smtpAuthReq;
        this.smtpAuthUser   = smtpAuthUser;
        this.smtpAuthPasswd = smtpAuthPasswd;
        this.smtpMailFrom   = smtpMailFrom;
**/
        this.smtpHostName   = variablesAmbiente.getSMTP_HOST_NAME();
        this.smtpHostPort   = variablesAmbiente.getSMTP_HOST_PORT();
        this.smtpAuthReq    = variablesAmbiente.getSMTP_AUTH_USER();
        this.smtpAuthUser   = variablesAmbiente.getSMTP_AUTH_USER();
        this.smtpAuthPasswd = variablesAmbiente.getSMTP_AUTH_PWD();
        this.smtpMailFrom   = variablesAmbiente.getSMTP_FROM();
        
        //Set the host smtp address
        props = new Properties();
            
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());  
        
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.user", smtpAuthUser);
//        props.put("mail.smtp.host", smtpHostName);
        props.put("mail.smtp.port", 587);
//        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.starttls.enable", "true");
//        props.put("mail.smtp.debug", "true");
        
//        props.put("mail.smtp.socketFactory.port", "587");
//        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//        props.put("mail.smtp.socketFactory.fallback", "false");
        
//        java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
    }   
/*
    public void EMailInspection() {

           //Set the host smtp address
            props = new Properties();
            
            props.put("mail.smtp.host", smtpHostName);
            props.put("mail.smtp.port", smtpHostPort);
            props.put("mail.smtp.auth", smtpAuthReq);

    }
*/
    /**
     * Envia un correo electronico.
     * @param recipients String[] contiene los destinatarios (TO) del correo.
     * @param subject String contiene el Sujeto del correo.
     * @param message String contiene el cuerpo del mensaje del correo.
     * @throws MessagingException 
     **/
    public void postMail( String recipients[ ], String subject, String message) throws MessagingException {
        boolean debug = false;

        Authenticator auth = new Emaill.SMTPAuthenticator();
        Session session = Session.getDefaultInstance(props, auth);
        session.setDebug(debug);

        // create a message
        Message msg = new MimeMessage(session);
       
        // set the from and to address
        InternetAddress addressFrom = new InternetAddress(smtpMailFrom);
        msg.setFrom(addressFrom);

        InternetAddress[] addressTo = new InternetAddress[recipients.length];
        for (int i = 0; i < recipients.length; i++) {
            addressTo[i] = new InternetAddress(recipients[i]);
        }
        msg.setRecipients(Message.RecipientType.TO, addressTo);

        // Setting the Subject and Content Type
        msg.setSubject(subject);

        MimeBodyPart messageBodyPart = 
          new MimeBodyPart();

        //fill message
        messageBodyPart.setText(message);

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);

        // Put parts in message
        msg.setContent(multipart);
        msg.setSentDate(new Date());
        
        Transport t = session.getTransport("smtp");
        try {
            t.connect(smtpHostName, 587, smtpAuthUser, smtpAuthPasswd);
            t.sendMessage(msg, msg.getAllRecipients());
        } finally {
            t.close();
        }

//        Transport.send(msg);
        
    }

    /**
     * Envia un correo electronico con un archivo adjunto.
     * @param recipients String[] contiene los destinatarios (TO) del correo.
     * @param subject String contiene el Sujeto del correo.
     * @param message String contiene el cuerpo del mensaje del correo.
     * @param fileAttachment String contiene el nombre completo (incluye ruta) del archivo a adjuntar.
     * @throws MessagingException 
     **/
    public void postMail( String recipients[ ], String subject, String message, String fileAttachment) throws MessagingException {
        boolean debug = false;
//
//        if(variablesAmbiente.getEMAIL_ACTIVE().compareToIgnoreCase("false") == 0)
//            return;

        Authenticator auth = new Emaill.SMTPAuthenticator();
        Session session = Session.getDefaultInstance(props, auth);

        session.setDebug(debug);

        // create a message
        Message msg = new MimeMessage(session);

        // set the from and to address
        InternetAddress addressFrom = new InternetAddress(smtpMailFrom);
       
        msg.setFrom(addressFrom);

        InternetAddress[] addressTo = new InternetAddress[recipients.length];
        for (int i = 0; i < recipients.length; i++) {
            addressTo[i] = new InternetAddress(recipients[i]);
        }
        msg.setRecipients(Message.RecipientType.TO, addressTo);

        // Setting the Subject and Content Type
        msg.setSubject(subject);

        MimeBodyPart messageBodyPart = 
          new MimeBodyPart();

        //fill message
        messageBodyPart.setText(message);

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);

        if(!fileAttachment.isEmpty()) {
            // Part two is attachment
            messageBodyPart = new MimeBodyPart();
            DataSource source = 
                new FileDataSource(fileAttachment);
            messageBodyPart.setDataHandler(
                new DataHandler(source));
            messageBodyPart.setFileName(new File(fileAttachment).getName());
            multipart.addBodyPart(messageBodyPart);
        }

        // Put parts in message
        msg.setContent(multipart);
        msg.setSentDate(new Date());

        Transport t = session.getTransport("smtp");
        try {
            t.connect(smtpHostName, 587, smtpAuthUser, smtpAuthPasswd);
            t.sendMessage(msg, msg.getAllRecipients());
        } finally {
            t.close();
        }
        
//        Transport.send(msg);
 }

    /**
    * SimpleAuthenticator is used to do simple authentication
    * when the SMTP server requires it.
    **/
    private class SMTPAuthenticator extends javax.mail.Authenticator {
        @Override
        public PasswordAuthentication getPasswordAuthentication(){
            String username = smtpAuthUser;
            String password = smtpAuthPasswd;
            return new PasswordAuthentication(username, password);
        }
    }
}