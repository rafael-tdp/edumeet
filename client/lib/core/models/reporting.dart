class Reporting {
  final String reason;
  final String type;
  final String entityId;

  Reporting({
    required this.reason,
    required this.type,
    required this.entityId,
  });

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'type': type,
      'entity_id': entityId,
    };
  }
}
