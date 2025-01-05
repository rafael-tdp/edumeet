class Stat {
  final List<int> userByMonth;
  final List<int> eventByMonth;
  final List<TopSubject> topSubjects;
  final AverageParticipants averageParticipantsByEvent;

  Stat({
    required this.userByMonth,
    required this.eventByMonth,
    required this.topSubjects,
    required this.averageParticipantsByEvent,
  });

  // Factory constructor pour la création depuis un JSON
  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      userByMonth: List<int>.from(json['userByMonth']),
      eventByMonth: List<int>.from(json['eventByMonth']),
      topSubjects: (json['topSubjects'] as List)
          .map((item) => TopSubject.fromJson(item))
          .toList(),
      averageParticipantsByEvent:
      AverageParticipants.fromJson(json['averageParticipantsByEvent']),
    );
  }
}

class TopSubject {
  final String name;
  final int currentYearCount;
  final int previousYearCount;

  TopSubject({
    required this.name,
    required this.currentYearCount,
    required this.previousYearCount,
  });

  factory TopSubject.fromJson(Map<String, dynamic> json) {
    return TopSubject(
      name: json['name'],
      currentYearCount: json['currentYearCount'],
      previousYearCount: json['previousYearCount'],
    );
  }
}

class AverageParticipants {
  final double previousYear;
  final double currentYear;

  AverageParticipants({
    required this.previousYear,
    required this.currentYear,
  });

  factory AverageParticipants.fromJson(Map<String, dynamic> json) {
    return AverageParticipants(
      previousYear: (json['previousYear'] as num).toDouble(),
      currentYear: (json['currentYear'] as num).toDouble(),
    );
  }
}