package mail;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class mail1 {

    public static void main(String toEmail, String messageText) {

        final String fromEmail = "javaa3775@gmail.com";
        final String password = "ujkn gvig seio ftzq";  

        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2"); 
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject("Blood Request Notification");
            msg.setText(messageText);

            Transport.send(msg);

            System.out.println("Mail Sent Successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
