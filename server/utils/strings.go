package utils

import (
	"encoding/json"
	"fmt"
)

func JSONStringify(v interface{}) string {
	jsonString, err := json.Marshal(v)
	if err != nil {
		// En cas d'erreur, retourner une chaîne d'erreur
		return fmt.Sprintf("error: %v", err)
	}
	return string(jsonString)
}
