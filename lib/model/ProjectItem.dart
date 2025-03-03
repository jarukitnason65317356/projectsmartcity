class ProjectItem {
  final int keyID;
  final String projectName;
  final String description;
  final double budget;
  final DateTime? date; // เปลี่ยนเป็น DateTime? เพื่อรองรับค่า null

  ProjectItem({
    required this.keyID,
    required this.projectName,
    required this.description,
    required this.budget,
    this.date,
  });

  /// ✅ แปลงเป็น Map (สำหรับบันทึกลงฐานข้อมูล)
  Map<String, dynamic> toMap() {
    return {
      'keyID': keyID,
      'projectName': projectName,
      'description': description,
      'budget': budget,
      'date': date?.toIso8601String(), // แปลง DateTime เป็น String
    };
  }

  /// ✅ แปลงจาก Map กลับมาเป็น `ProjectItem`
  factory ProjectItem.fromMap(Map<String, dynamic> map) {
    return ProjectItem(
      keyID: map['keyID'] ?? 0,
      projectName: map['projectName'] ?? '',
      description: map['description'] ?? '',
      budget: (map['budget'] ?? 0).toDouble(),
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
    );
  }

  /// ✅ คัดลอกข้อมูล (สำหรับอัปเดตค่าบางส่วน)
  ProjectItem copyWith({
    int? keyID,
    String? projectName,
    String? description,
    double? budget,
    DateTime? date,
  }) {
    return ProjectItem(
      keyID: keyID ?? this.keyID,
      projectName: projectName ?? this.projectName,
      description: description ?? this.description,
      budget: budget ?? this.budget,
      date: date ?? this.date,
    );
  }
}
