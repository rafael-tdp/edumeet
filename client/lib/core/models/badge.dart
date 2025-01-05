class Badge {
  final String id;
  final String name;
  final String type;
  final int nbRequirementEvent;
  final String svg;

  Badge({
    required this.id,
    required this.name,
    required this.type,
    required this.nbRequirementEvent,
    required this.svg,
  });

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      nbRequirementEvent: json['nbRequirementEvent'] as int,
      svg: json['svg'] as String,
    );
  }
}
