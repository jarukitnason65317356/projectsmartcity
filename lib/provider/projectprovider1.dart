/*import 'package:flutter/material.dart';
import '../model/ProjectItem.dart';
import '../database/ProjectDB.dart';

class ProjectProvider extends ChangeNotifier {
  List<ProjectItem> _projects = [];
  bool isLoading = false;

  List<ProjectItem> get projects => _projects;

  Future<void> initData() async {
    isLoading = true;
    notifyListeners();
    
    try {
      var db = ProjectDB(dbName: 'projects.db');
      _projects = await db.loadAllData();
    } catch (e) {
      debugPrint("Error loading data: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addProject(ProjectItem project) async {
    try {
      var db = ProjectDB(dbName: 'projects.db');
      await db.insertDatabase(project);
      _projects = await db.loadAllData();
    } catch (e) {
      debugPrint("Error adding project: $e");
    }
    notifyListeners();
  }

  Future<void> deleteProject(ProjectItem project) async {
    try {
      var db = ProjectDB(dbName: 'projects.db');
      await db.deleteData(project);
      _projects = await db.loadAllData();
    } catch (e) {
      debugPrint("Error deleting project: $e");
    }
    notifyListeners();
  }

  Future<void> updateProject(ProjectItem project) async {
    try {
      var db = ProjectDB(dbName: 'projects.db');
      await db.updateData(project);
      _projects = await db.loadAllData();
    } catch (e) {
      debugPrint("Error updating project: $e");
    }
    notifyListeners();
  }
}*/
