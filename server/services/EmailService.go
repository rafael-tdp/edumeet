package services

import (
	"os"

	"github.com/sirupsen/logrus"
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

	if os.Getenv("DEBUG") == "true" {
		toEmail = os.Getenv("DEBUG_MAIL")
	}

	m.SetHeader("From", "Edumeet <"+es.username+">")

	m.SetHeader("To", toEmail)

	m.SetHeader("Subject", subject)

	m.SetBody("text/html", htmlContent)

	d := gomail.NewDialer(es.smtpServer, es.port, es.username, es.password)

	if err := d.DialAndSend(m); err != nil {
		logrus.Error("Error EmailService.SendEmail: ", err)
		return err
	}

	return nil
}
