package utils

import (
	"context"
	"os"

	openai "github.com/sashabaranov/go-openai"
)

const basePrompt = `Tu es une IA spécialisée dans la création de contenu pédagogique.
Ta mission est de générer des exercices clairs, concis, et adaptés pour un éditeur WYSIWYG.
Si la demande est autre tu dois répondre une chaine de caractère vide.`

const exercisePrompt = `Commence par "Énoncé: " suivi d'une consigne explicite pour les exercices.
Ne génère que l'exercice sans aucune correction ou explication complémentaire.
Si plusieurs exercices sont demandés, sépare-les par des points-virgules.
Voici le thème de l'exercice :`

const correctionPrompt = `On te fournit un énoncé d'exercice, et ta mission est de générer uniquement la correction de cet exercice.
Ne répète pas l'énoncé. Fournis une réponse claire et précise en commençant par "Correction: ".
La correction doit être concise, structurée et adaptée pour un éditeur WYSIWYG.
Voici l'énoncé de l'exercice à corriger :`

func InitOpenAI(prompt string) (string, error) {
	client := openai.NewClient(os.Getenv("OPENAI_API_KEY"))
	resp, err := client.CreateChatCompletion(
		context.Background(),
		openai.ChatCompletionRequest{
			Model: openai.GPT3Dot5Turbo,
			Messages: []openai.ChatCompletionMessage{
				{
					Role:    openai.ChatMessageRoleSystem,
					Content: basePrompt,
				},
				{
					Role:    openai.ChatMessageRoleUser,
					Content: prompt,
				},
			},
		},
	)
	if err != nil {
		return "", err
	}

	return resp.Choices[0].Message.Content, nil
}

func GenerateExercisePrompt(statement string) (string, error) {
	fullPrompt := exercisePrompt + " " + statement

	return InitOpenAI(fullPrompt)
}

func GenerateCorrectionPrompt(exercise string) (string, error) {
	fullPrompt := correctionPrompt + " " + exercise

	return InitOpenAI(fullPrompt)
}
