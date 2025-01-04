package metrics

import (
	"github.com/prometheus/client_golang/prometheus"
)

// Définition des métriques
var (
	LoginAttempts = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "login_attempts_total",
			Help: "Nombre total de tentatives de connexion, distinguées par succès ou échec",
		},
		[]string{"status"}, // Labels : "success" ou "failure"
	)
)

// InitMetrics enregistre toutes les métriques auprès de Prometheus
func InitMetrics() {
	prometheus.MustRegister(LoginAttempts)
	LoginAttempts.WithLabelValues("success").Add(0)
	LoginAttempts.WithLabelValues("failure").Add(0)

}
