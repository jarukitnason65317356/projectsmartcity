import 'package:flutter/material.dart';
import 'package:project/model/ProjectItem.dart';

class ProjectProvider extends ChangeNotifier {
  List<ProjectItem> projects = [
    // ตัวอย่างโปรเจกต์ที่มีข้อมูลเริ่มต้น
    ProjectItem(
      keyID: 1,
      projectName: 'Smart City Initiative',
      description: 'A project to improve urban infrastructure',
      budget: 5000000,
      date: DateTime.now(),
    ),
    // เพิ่มโปรเจกต์อื่นๆ ที่ต้องการทดสอบ
  ];

  // เพิ่มโปรเจกต์ใหม่
  void addProject(ProjectItem project) {
    projects.add(project);
    notifyListeners();  // รีเฟรช UI
  }

  // อัปเดตโปรเจกต์
  void updateProject(ProjectItem updatedProject) {
    final index = projects.indexWhere((project) => project.keyID == updatedProject.keyID);
    if (index != -1) {
      projects[index] = updatedProject;
      notifyListeners();  // รีเฟรช UI
    }
  }

  // ลบโปรเจกต์
   void removeProject(int keyID) {  // เปลี่ยนเป็นรับ keyID
    projects.removeWhere((project) => project.keyID == keyID);
    notifyListeners();
  }
  
  void initData() {
    projects = [
      ProjectItem(
        keyID: 1,
        projectName: "โครงการ Smart City",
        description: "โครงการพัฒนาเมืองอัจฉริยะ",
        budget: 1000000,
        date: DateTime.now(),
      ),
    ];
    notifyListeners();
  }
}
