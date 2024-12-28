package services

import (
	"edumeet/ent"
	"edumeet/repositories"
	"sort"
	"time"
)

type StatService struct {
	subjectRepository *repositories.SubjectRepository
	userRepository    *repositories.UserRepository
	eventRepository   *repositories.EventRepository
}

func NewStatService(subjectRepository *repositories.SubjectRepository, userRepository *repositories.UserRepository, eventRepository *repositories.EventRepository) *StatService {
	return &StatService{
		subjectRepository: subjectRepository,
		userRepository:    userRepository,
		eventRepository:   eventRepository,
	}
}

type Stats struct {
	UserByMonth                [12]int     `json:"userByMonth"`
	EventByMonth               [12]int     `json:"eventByMonth"`
	TopSubjects                interface{} `json:"topSubjects"`
	AverageParticipantsByEvent interface{} `json:"averageParticipantsByEvent"`
}

type AverageParticipantsByEvent struct {
	PreviousYear float64 `json:"previousYear"`
	CurrentYear  float64 `json:"currentYear"`
}

type TopSubjects struct {
	PreviousYear []map[string]interface{} `json:"previousYear"`
	CurrentYear  []map[string]interface{} `json:"currentYear"`
}

func (sr *StatService) GetStats() (interface{}, error) {
	stats := &Stats{}

	events, err := sr.eventRepository.GetEvents()
	if err != nil {
		return nil, err
	}

	users, err := sr.userRepository.GetUsers()

	if err != nil {
		return nil, err
	}

	subjects, err := sr.subjectRepository.GetSubjects()

	if err != nil {
		return nil, err
	}

	stats.UserByMonth = sr.GetUserByMonth(users)
	stats.EventByMonth = sr.GetEventByMonth(events)
	stats.AverageParticipantsByEvent = sr.GetAverageParticipantsByEvent(events)
	stats.TopSubjects = sr.GetTopSubjects(events, subjects)
	return stats, nil
}

func (sr *StatService) GetTopSubjects(events []*ent.Event, subjects []*ent.Subject) interface{} {
	currentYear := time.Now().Year()
	previousYear := currentYear - 1

	// Fonction pour récupérer les comptages d'un sujet pour une année donnée
	getSubjectCountForYear := func(year int) map[string]int {
		subjectsMap := make(map[string]int)

		// Parcours des événements et comptage des occurrences par sujet pour l'année donnée
		for _, event := range events {
			if event.EndDate.Year() == year {
				for _, subject := range event.Edges.Subjects {
					subjectsMap[subject.Name]++
				}
			}
		}

		return subjectsMap
	}

	// On récupère les comptages pour l'année actuelle et l'année précédente
	currentYearSubjectsMap := getSubjectCountForYear(currentYear)
	previousYearSubjectsMap := getSubjectCountForYear(previousYear)

	var result []map[string]interface{}

	// Créer un tableau avec les résultats
	for _, subject := range subjects {
		// Récupérer le comptage pour l'année actuelle
		currentYearCount := currentYearSubjectsMap[subject.Name]

		// Récupérer le comptage pour l'année précédente (0 si aucun événement)
		previousYearCount := previousYearSubjectsMap[subject.Name]

		// Ajouter l'objet au tableau de résultat
		result = append(result, map[string]interface{}{
			"name":              subject.Name,
			"currentYearCount":  currentYearCount,
			"previousYearCount": previousYearCount,
		})
	}

	// Trier les résultats par nombre d'événements décroissant pour l'année actuelle
	sort.Slice(result, func(i, j int) bool {
		return result[i]["currentYearCount"].(int) > result[j]["currentYearCount"].(int)
	})

	// Limiter à 5 résultats maximum
	if len(result) > 5 {
		result = result[:5]
	}

	return result
}

func sortTopSubjects(subjects *[]map[string]interface{}) {
	sort.Slice(*subjects, func(i, j int) bool {
		return (*subjects)[i]["count"].(int) > (*subjects)[j]["count"].(int)
	})
}

func (sr *StatService) GetAverageParticipantsByEvent(events []*ent.Event) interface{} {
	currentYear := time.Now().Year()
	previousYear := currentYear - 1
	now := time.Now()

	var participantsCurrentYear int
	var participantsPreviousYear int
	var eventsCurrentYear int
	var eventsPreviousYear int

	for _, event := range events {
		if event.EndDate.Year() == currentYear {
			if event.EndDate.After(now) {
				continue
			}
			participantsCurrentYear += len(event.Edges.Participants)
			eventsCurrentYear++
		} else if event.EndDate.Year() == previousYear {
			participantsPreviousYear += len(event.Edges.Participants)
			eventsPreviousYear++
		}
	}

	var avgCurrentYear float64
	var avgPreviousYear float64

	if eventsCurrentYear > 0 {
		avgCurrentYear = float64(participantsCurrentYear) / float64(eventsCurrentYear)
	}

	if eventsPreviousYear > 0 {
		avgPreviousYear = float64(participantsPreviousYear) / float64(eventsPreviousYear)
	}

	return &AverageParticipantsByEvent{
		PreviousYear: avgPreviousYear,
		CurrentYear:  avgCurrentYear,
	}
}

func (sr *StatService) GetEventByMonth(events []*ent.Event) [12]int {
	var statsEventByMonth [12]int
	currentYear := time.Now().Year()

	for i := 0; i < 12; i++ {
		statsEventByMonth[i] = 0
	}

	for _, event := range events {
		if event.CreatedAt.Year() == currentYear {
			month := int(event.CreatedAt.Month()) - 1
			statsEventByMonth[month]++
		}
	}

	return statsEventByMonth
}

func (sr *StatService) GetUserByMonth(users []*ent.User) [12]int {
	var statsUserByMonth [12]int
	currentYear := time.Now().Year()

	for i := 0; i < 12; i++ {
		statsUserByMonth[i] = 0
	}

	for _, user := range users {
		if user.CreatedAt.Year() == currentYear {
			month := int(user.CreatedAt.Month()) - 1
			statsUserByMonth[month]++
		}
	}

	return statsUserByMonth
}
