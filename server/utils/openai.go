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
Si plusieurs exercices sont demandés, sépare-les par des saut de ligne.
Voici le thème de l'exercice :`

const correctionPrompt = `
Voici une version corrigée et optimisée de votre prompt pour générer des corrections :

On te fournit un ou plusieurs énoncés d'exercices. Ta mission est de fournir une correction pour chaque énoncé.
Pour chaque énoncé : Écris une correction en commençant par "Correction :".
Assure-toi que la correction soit concise et clairement structurée, en respectant le format et le contexte de l'énoncé.
Place chaque correction immédiatement après l'énoncé correspondant.
Voici les énoncés d'exercices à corriger :`

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
