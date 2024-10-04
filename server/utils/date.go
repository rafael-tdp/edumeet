package utils

import (
	"time"

	"github.com/brianvoe/gofakeit/v7"
)

type Date struct{}

func (d *Date) GenerateBirthDate() time.Time {
	now := time.Now()

	minAge := now.AddDate(-35, 0, 0)
	maxAge := now.AddDate(-20, 0, 0)

	return gofakeit.DateRange(minAge, maxAge)
}
