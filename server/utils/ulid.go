package utils

import (
	"math/rand"
	"time"

	"github.com/oklog/ulid/v2"
)

type ULID struct{}

func (u *ULID) GenerateUlid() func() string {
	return func() string {
		t := time.Now().UTC()
		entropy := ulid.Monotonic(rand.New(rand.NewSource(t.UnixNano())), 0)
		return ulid.MustNew(ulid.Timestamp(t), entropy).String()
	}
}
