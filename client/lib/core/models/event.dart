import 'package:client/core/models/message.dart';

class Event {
  final String? id;
  final String title;
  final String description;
  final String? image;
  final String startDate;
  final String endDate;
  final bool isPrivate;
  final int? participantsCount;
  final dynamic physicalEvent;
  final dynamic remoteEvent;
  final List<dynamic>? participants;
  final List<dynamic>? documents;
  final String? createdBy;
  final List<dynamic>? subjects;
  final int? nbMaxParticipants;
  final List<Message>? lastMessages;
  final String? code;
  final dynamic? participantStatus;

  Event({
    this.id,
    required this.title,
    required this.description,
    this.image,
    required this.startDate,
    required this.endDate,
    required this.isPrivate,
    this.participantsCount,
    this.physicalEvent,
    this.remoteEvent,
    this.participants,
    this.documents,
    this.createdBy,
    this.subjects,
    this.nbMaxParticipants,
    this.lastMessages,
    this.code,
    this.participantStatus,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    List<Message>? lastMessages;
    if (json['last_messages'] != null) {
      lastMessages = List<Message>.from(
          json['last_messages'].map((message) => Message.fromJson(message)));
    }
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
      documents: json['event_documents'],
      createdBy: json['created_by'],
      subjects: json['subjects'],
      nbMaxParticipants: json['nb_max_participants'],
      lastMessages: lastMessages,
      code: json['code'],
      participantStatus: json['participant_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'start_date': startDate,
      'end_date': endDate,
      'is_private': isPrivate,
      'participants_count': participantsCount,
      'physical_event': physicalEvent,
      'remote_event': remoteEvent,
      'participants': participants,
      'event_documents': documents,
      'created_by': createdBy,
      'subjects': subjects,
      'nb_max_participants': nbMaxParticipants,
      'last_messages': lastMessages,
      'code': code,
      'participant_status': participantStatus,
    };
  }
}
