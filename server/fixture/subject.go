package fixture

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
)

type Subject struct{}

func (b *Subject) GenerateSubject(ctx context.Context, client *ent.Client) {
	subjects := []dtos.SubjectDTO{
		{Name: "Intelligence Artificielle"},
		{Name: "Analyse Financière"},
		{Name: "Biotechnologie"},
		{Name: "Droit International"},
		{Name: "Architecture Systèmes et Réseaux"},
		{Name: "Marketing Digital"},
		{Name: "Gestion des Ressources Humaines"},
		{Name: "Chimie Organique"},
		{Name: "Psychologie du Développement"},
		{Name: "Design d'Interface Utilisateur"},
		{Name: "Physique Quantique"},
		{Name: "Théorie des Jeux"},
		{Name: "Management de Projet"},
		{Name: "Médecine Génétique"},
		{Name: "Sociologie des Organisations"},
		{Name: "Programmation Web Avancée"},
		{Name: "Microbiologie Appliquée"},
		{Name: "Droit des Entreprises"},
		{Name: "Systèmes d'Information Géographique"},
		{Name: "Publicité et Communication"},
		{Name: "Économie Internationale"},
		{Name: "Neurologie"},
		{Name: "Entrepreneuriat et Innovation"},
		{Name: "Gestion de la Production Industrielle"},
		{Name: "Histoire de l'Art"},
		{Name: "Big Data et Analyse de Données"},
		{Name: "Systèmes Embarqués"},
		{Name: "Anthropologie Culturelle"},
		{Name: "Gestion de la Supply Chain"},
		{Name: "Génie Civil"},
	}
	users := client.User.Query().AllX(ctx)
	for i := 0; i < len(subjects); i++ {
		client.Subject.Create().
			SetName(subjects[i].Name).
			SetCreatedBy(users[i%4].ID).
			SetUpdatedBy(users[i%4].ID).
			SaveX(ctx)
	}
}
