package services

import (
	"os"

	"gopkg.in/gomail.v2"
)

type EmailService struct {
	smtpServer string
	port       int
	username   string
	password   string
}

func NewEmailService() *EmailService {
	return &EmailService{
		smtpServer: "smtp-relay.sendinblue.com",
		port:       587,
		username:   os.Getenv("BREVO_SMTP_USERNAME"),
		password:   os.Getenv("BREVO_SMTP_PASSWORD"),
	}
}

func (es *EmailService) SendEmail(toEmail, subject, htmlContent string) error {
	m := gomail.NewMessage()

	m.SetHeader("From", es.username)

	m.SetHeader("To", toEmail)

	m.SetHeader("Subject", subject)

	m.SetBody("text/html", htmlContent)

	d := gomail.NewDialer(es.smtpServer, es.port, es.username, es.password)

	if err := d.DialAndSend(m); err != nil {
		return err
	}

	return nil
}
