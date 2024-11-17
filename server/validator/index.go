package validator

import (
	"fmt"
	"reflect"

	"github.com/go-playground/validator/v10"
)

func ValidateDTO(validations *validator.Validate, input interface{}) ([]string, error) {
	v := reflect.ValueOf(input)
	if v.Kind() != reflect.Ptr {
		return nil, fmt.Errorf("input doit être un pointeur vers une struct")
	}

	// Effectuer la validation
	err := validations.Struct(input)
	if err != nil {
		if validationErrors, ok := err.(validator.ValidationErrors); ok {
			errors := make([]string, 0)

			// Parcourir les erreurs
			for _, validationError := range validationErrors {
				// Obtenir le nom du champ et son type
				fieldName := validationError.Field()

				// Accéder à la struct sous-jacente pour récupérer les tags (nous devons obtenir un Type de la struct pointée)
				field, found := v.Elem().Type().FieldByName(fieldName)
				if !found {
					// Si le champ n'est pas trouvé (ce qui ne devrait pas arriver)
					errors = append(errors, validationError.Error())
					continue
				}

				// Vérifier s'il y a un message d'erreur personnalisé
				customMessage := field.Tag.Get("error_message")
				if customMessage != "" {
					errors = append(errors, customMessage)
				} else {
					// Sinon, utiliser le message par défaut
					tag := validationError.Tag()
					param := validationError.Param()
					errorMessage := fmt.Sprintf("Le champ '%s' a échoué sur la validation '%s' (valeur attendue: %s)", fieldName, tag, param)
					errors = append(errors, errorMessage)
				}
			}

			return errors, nil
		}
		return nil, err
	}
	return nil, nil
}
