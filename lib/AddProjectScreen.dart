import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/model/ProjectItem.dart';
import 'package:project/provider/projectprovider.dart';



class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final formKey = GlobalKey<FormState>();
  final projectNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('เพิ่มโครงการเมืองอัจฉริยะ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อโครงการ'),
                controller: projectNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณาป้อนชื่อโครงการ";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'รายละเอียดโครงการ'),
                controller: descriptionController,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณาป้อนรายละเอียดโครงการ";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'งบประมาณ (บาท)'),
                keyboardType: TextInputType.number,
                controller: budgetController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณาป้อนงบประมาณ";
                  }
                  try {
                    double.parse(value);
                  } catch (e) {
                    return "กรุณาป้อนเป็นตัวเลขเท่านั้น";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var provider =
                        Provider.of<ProjectProvider>(context, listen: false);
                    ProjectItem project = ProjectItem(
                      keyID: DateTime.now().millisecondsSinceEpoch,  // สร้าง KeyID อัตโนมัติ
                      projectName: projectNameController.text,
                      description: descriptionController.text,
                      budget: double.parse(budgetController.text),
                      date: DateTime.now(),
                    );

                    provider.addProject(project);
                    Navigator.pop(context);
                  }
                },
                child: const Text('เพิ่มโครงการ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
