class Subject {
  final int id;
  final String name;
  final int? gradeId;

  Subject({required this.id, required this.name, this.gradeId});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json["id"],
      name: json["name"],
      gradeId: json["grade_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    "name": name,
    "grade_id": gradeId,
  };
}
