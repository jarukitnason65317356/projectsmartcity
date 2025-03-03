import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:project/model/ProjectItem.dart';

class ProjectDB {
  final String dbName;

  ProjectDB({required this.dbName});

  /// เปิดฐานข้อมูล
  Future<Database> openDatabase() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDir.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);

    return db;
  }

  /// เพิ่มข้อมูลโครงการ
  Future<int> insertDatabase(ProjectItem project) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('projects');

    int keyID = await store.add(db, {
      'projectName': project.projectName,
      'description': project.description,
      'budget': project.budget,
      'date': project.date?.toIso8601String(),
    });

    db.close();
    return keyID;
  }

  /// โหลดข้อมูลทั้งหมดจากฐานข้อมูล
  Future<List<ProjectItem>> loadAllData() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('projects');

    var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder('date', false)]));

    List<ProjectItem> projects = snapshot.map((record) {
      return ProjectItem(
        keyID: record.key,
        projectName: record['projectName'].toString(),
        description: record['description'].toString(),
        budget: double.tryParse(record['budget'].toString()) ?? 0.0,
        date: (record['date'] != null && record['date'] is String)
            ? DateTime.tryParse(record['date'] as String)
            : null,
      );
    }).toList();

    db.close();
    return projects;
  }

  /// ลบข้อมูลโครงการ
  Future<void> deleteData(int keyID) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('projects');

    await store.delete(db, finder: Finder(filter: Filter.equals(Field.key, keyID)));

    db.close();
  }

  /// อัปเดตข้อมูลโครงการ
  Future<void> updateData(ProjectItem project) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('projects');

    await store.update(
      db,
      {
        'projectName': project.projectName,
        'description': project.description,
        'budget': project.budget,
        'date': project.date?.toIso8601String(),
      },
      finder: Finder(filter: Filter.equals(Field.key, project.keyID)),
    );

    db.close();
  }
}
