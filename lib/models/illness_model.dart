class Illness {
  final int id;
  final String name;
  final String persianName;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  Illness({
    required this.id,
    required this.name,
    required this.persianName,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory Illness.fromJson(Map<String, dynamic> json) {
    return Illness(
      id: json['id'],
      name: json['name'],
      persianName: json['persianName'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Level {
  final String id;
  final String name;
  final String nameFa;
  
  Level({
    required this.id,
    required this.name,
    required this.nameFa,
  });
  
  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'],
      name: json['name'],
      nameFa: json['name_fa'],
    );
  }
}

class IllnessResponse {
  final List<Illness> illnesses;
  final List<Level> levels;
  
  IllnessResponse({
    required this.illnesses,
    required this.levels,
  });
  
  factory IllnessResponse.fromJson(Map<String, dynamic> json) {
    return IllnessResponse(
      illnesses: (json['illnesses'] as List)
          .map((item) => Illness.fromJson(item))
          .toList(),
      levels: (json['levels'] as List)
          .map((item) => Level.fromJson(item))
          .toList(),
    );
  }
} 