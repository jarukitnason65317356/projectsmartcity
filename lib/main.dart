import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/model/ProjectItem.dart';
import 'package:project/provider/projectprovider.dart';
import 'package:project/addProjectScreen.dart';
import 'package:project/editProjectScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProjectProvider()),
      ],
      child: MaterialApp(
        title: 'Smart City Projects',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Smart City Projects'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProjectProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddProjectScreen();
              }));
            },
          ),
        ],
      ),
      body: Consumer<ProjectProvider>(
        builder: (context, provider, child) {
          int itemCount = provider.projects.length;
          if (itemCount == 0) {
            return const Center(
              child: Text(
                'ไม่มีโครงการ',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                ProjectItem project = provider.projects[index];
                return Dismissible(
                  key: Key(project.keyID.toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    provider.removeProject(project.keyID);

                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 12),
                    child: ListTile(
                      title: Text(project.projectName),
                      subtitle: Text(
                        project.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: CircleAvatar(
                        child: FittedBox(
                          child: Text(project.budget.toString()),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('ยืนยันการลบ'),
                                content:
                                    const Text('คุณต้องการลบโครงการนี้ใช่หรือไม่?'),
                                actions: [
                                  TextButton(
                                    child: const Text('ยกเลิก'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('ลบโครงการ'),
                                    onPressed: () {
                                      provider.removeProject(project.keyID);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditProjectScreen(project: project);
                        }));
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
