package com.main.mailer;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class EmailSessionBean {

    private int port = 25;
    private String host = "smtpout.asia.secureserver.net";
    private String from = "customer.first@karworx.com";
    private boolean auth = true;
    private String username = "customer.first@karworx.com";
    private String password = "customer123";
    private Protocol protocol = Protocol.SMTPS;
    private boolean debug = true;

    public void sendEmail(String to, String subject, String body, String filename, String myFile) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtpout.asia.secureserver.net");//change accordingly    
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", port);        

        Authenticator authenticator = null;
        if (auth) {
            props.put("mail.smtp.auth", true);
            authenticator = new Authenticator() {
                private PasswordAuthentication pa = new PasswordAuthentication(username, password);

                @Override
                public PasswordAuthentication getPasswordAuthentication() {
                    return pa;
                }
            };
        }

        Session session = Session.getInstance(props, authenticator);
        session.setDebug(debug);

        MimeMessage message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
            message.setRecipients(Message.RecipientType.TO, address);
            message.setSubject(subject);
            message.setSentDate(new Date());
            message.setText(body);

            BodyPart messageBodyPart = new MimeBodyPart();

            // Now set the actual message
            messageBodyPart.setText(body);

            // Create a multipar message
            Multipart multipart = new MimeMultipart();

            // Set text message part
            multipart.addBodyPart(messageBodyPart);

            // Part two is attachment
            messageBodyPart = new MimeBodyPart();
            DataSource source = new FileDataSource(filename);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName(myFile + ".pdf");
            multipart.addBodyPart(messageBodyPart);

            // Send the complete message parts
            message.setContent(multipart);

//            Multipart multipart = new MimeMultipart("alternative");
//            
//            MimeBodyPart textPart = new MimeBodyPart();
//            String textContent = "Hi, Nice to meet you!";
//            textPart.setText(textContent);
//
//            MimeBodyPart htmlPart = new MimeBodyPart();
//            String htmlContent = "<html><h1>Hi</h1><p>Nice to meet you!</p></html>";
//            htmlPart.setContent(htmlContent, "text/html");
//
//            multipart.addBodyPart(textPart);
//            multipart.addBodyPart(htmlPart);
//            message.setContent(multipart);
            Transport.send(message);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }

    public String sendCustomerMail(String subject, String message, String to, String yourname) throws MessagingException, UnsupportedEncodingException {

        String status;
        try {
            // SSL // I USED THIS METHOD            
            Properties propsSSL = new Properties();

            // EVEN IF YOU SKIP THESE TWO PROP IT WOULD WORK
            propsSSL.put("mail.transport.protocol", "smtps");
            propsSSL.put("mail.smtps.host", host);

            // THIS IS THE MOST IMPORTANT PROP --> "mail.smtps.auth"
            propsSSL.put("mail.smtps.auth", auth);

            Session sessionSSL = Session.getInstance(propsSSL);
            //sessionSSL.setDebug(true);

            Message messageSSL = new MimeMessage(sessionSSL);
            messageSSL.setFrom(new InternetAddress(username, yourname));
            messageSSL.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to)); // real recipient
            messageSSL.setSubject(subject);
            messageSSL.setText(message);

            Transport transportSSL = sessionSSL.getTransport();
            // EVEN IF YOU SKIP PORT NUMBER , IT WOULD WORK
            transportSSL.connect(host, port, username, password); // account used
            transportSSL.sendMessage(messageSSL, messageSSL.getAllRecipients());
            transportSSL.close();

            System.out.println("SSL done.");
            status = "sent";
            return status;
        } catch (Exception e) {
            status = "notsent";
            return status;
        }

    }

    public String sendCustomerPasswordMail(String subject, String messages, String stEmailId, String yourname,String stSubject) throws MessagingException, UnsupportedEncodingException {

        String status;
        try {
            //code to send mail begin here
            System.setProperty("java.protocol.handler.pkgs", "com.sun.net.ssl.internal.www.protocol");

            String stHost = "smtpout.asia.secureserver.net";
            String stTo = stEmailId;
            String stMessageText = messages;
            String stFromName = "Karworx";
//            String stSubject = "Karworx Password";
            boolean sessionDebug = true;
            // Create some properties and get the default Session.
            //System.setProperty("smtp.protocols", "SSLv3");
            Properties props = System.getProperties();

            props.put("mail.smtp.host", "smtpout.asia.secureserver.net");//change accordingly  
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", 25);    //port is 587 for TLS  if you use SSL then port is 465

            Session session = Session.getDefaultInstance(props,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(username, password);
                        }
                    });
            //2nd step)compose message  
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from, "Karworx"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(stTo));
            message.setSubject(stSubject);
            message.setText("");
            message.setContent(subject+"" + stMessageText + "", "text/html");

            //3rd step)send message  
            Transport.send(message);
            //code to send mail ends! here

            System.out.println("SSL done.");
            status = "sent";
            return status;
        } catch (Exception e) {
            status = "notsent";
            return status;
        }

    }

}
