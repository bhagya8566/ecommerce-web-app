package com.ebazar.E_Bazar.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.MailSendException;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    /**
     * Light-weight test send used to verify whether SMTP accepts/delivers to recipient.
     * We send a simple short message; if mailSender.send throws an exception we treat the address as invalid/unreachable.
     *
     * WARNING: This actually attempts to send mail. Some SMTP providers accept mail and bounce later — in that case
     * send() may succeed even for non-existing addresses. For many setups (where SMTP rejects at SMTP RCPT stage)
     * this will fail and we can detect non-existing addresses.
     */
    public boolean verifyEmailBySendingTest(String to) {
        try {
            SimpleMailMessage msg = new SimpleMailMessage();
            msg.setTo(to);
            msg.setSubject("E-Bazar — Email verification (auto)");
            msg.setText("This is a verification message from E-Bazar. If you received this, the address is valid.");
            // from will be taken from mail.properties (spring.mail.username) or you can set a from here:
            // msg.setFrom("no-reply@yourdomain.com");
            mailSender.send(msg);
            return true;
        } catch (MailAuthenticationException authEx) {
            System.out.println("Email verify failed - auth: " + authEx.getMessage());
            return false;
        } catch (MailSendException sendEx) {
            System.out.println("Email verify failed - send: " + sendEx.getMessage());
            return false;
        } catch (MailException mex) {
            System.out.println("Email verify failed: " + mex.getMessage());
            return false;
        } catch (Exception ex) {
            System.out.println("Email verify unexpected error: " + ex.getMessage());
            return false;
        }
    }

    /**
     * Sends the real order confirmation to the user. Returns true if sending did not throw exception.
     */
    public boolean sendOrderConfirmation(String to, String subject, String text) {
        try {
            SimpleMailMessage msg = new SimpleMailMessage();
            msg.setTo(to);
            msg.setSubject(subject);
            msg.setText(text);
            mailSender.send(msg);
            return true;
        } catch (Exception e) {
            System.out.println("Email sending failed: " + e.getMessage());
            return false;
        }
    }
}
