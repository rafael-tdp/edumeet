class Event {
  final String id;
  final String title;
  final String description;
  final String image;
  final String startDate;
  final String endDate;
  final bool isPrivate;
  final int participantsCount;
  final dynamic physicalEvent;
  final dynamic remoteEvent;
  final List<dynamic>? participants;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.isPrivate,
    required this.participantsCount,
    this.physicalEvent,
    this.remoteEvent,
    this.participants,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      isPrivate: json['is_private'],
      participantsCount: json['participants_count'],
      physicalEvent: json['physical_event'],
      remoteEvent: json['remote_event'],
      participants: json['participants'],
    );
  }
}