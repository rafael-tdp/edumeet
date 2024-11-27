package services

import "edumeet/utils"

type AIService struct {
}

func NewAIService() *AIService {
	return &AIService{}
}

func (ai *AIService) GenerateExo(statement string) (string, error) {
	exo, err := utils.GenerateExercisePrompt(statement)
	if err != nil {
		return "", err
	}

	return exo, nil
}

func (ai *AIService) GenerateCorrection(exercice string) (string, error) {
	exo, err := utils.GenerateCorrectionPrompt(exercice)
	if err != nil {
		return "", err
	}

	return exo, nil
}
