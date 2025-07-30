import 'package:admin_panel/models/grade.dart';
import 'package:admin_panel/screens/dashboard_widget/classroom/subject_course.dart';
import 'package:admin_panel/services/classroom_service.dart';
import 'package:admin_panel/widgets/button_one.dart';
import 'package:admin_panel/widgets/textfield_one.dart';
import 'package:flutter/material.dart';

class Classroom extends StatefulWidget {
  const Classroom({super.key});

  @override
  State<Classroom> createState() => _ClassroomState();
}

class _ClassroomState extends State<Classroom> {
  List<Grade> grades = [];
  TextEditingController gradeController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGrades();
  }

  Future<void> fetchGrades() async {
    try {
      final data = await ClassroomService.getGrades();
      setState(() {
        grades = data;
        sortGrades();
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addGrades() async {
    try {
      final newGrade = await ClassroomService.createGreade(
        gradeController.text,
      );
      setState(() {
        grades.add(newGrade);
        sortGrades();
        gradeController.clear();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteGrades(int id) async {
    try {
      await ClassroomService.deleteGrades(id);
      setState(() {
        grades.removeWhere((del) {
          return del.id == id;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void sortGrades() {
    grades.sort((a, b) {
      final sorting = RegExp(r"\d+");
      final aNum =
          int.tryParse(sorting.firstMatch(a.name)?.group(0) ?? "") ?? 0;
      final bNum =
          int.tryParse(sorting.firstMatch(b.name)?.group(0) ?? "") ?? 0;
      return aNum.compareTo(bNum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
          ),
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Classroom Management",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ButtonOne(
                      name: "Add New Class",
                      color: const Color(0xFF0074B2),
                      icon: Icon(Icons.add),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, dialogsetState) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFF0074B2),
                                  title: Text(
                                    "Grades",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextfieldOne(
                                        label: "Input Grade",
                                        controller: gradeController,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color(
                                          0xFF0074B2,
                                        ),
                                      ),

                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0074B2),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color(
                                          0xFF0074B2,
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (gradeController.text.isNotEmpty) {
                                          await addGrades();
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0074B2),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: GridView.builder(
                            itemCount: grades.length,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  mainAxisExtent: 60,
                                  crossAxisSpacing: 40,
                                  mainAxisSpacing: 40,
                                ),
                            itemBuilder: (context, index) {
                              final grade = grades[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SubjectCourse(
                                        gradeId: grade.id,
                                        grade: grade.name,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amber,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withValues(
                                              alpha: 0.9,
                                            ),
                                            blurRadius: 6,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            grade.name,
                                            style: TextStyle(
                                              color: const Color(0xFF5B1C09),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 6,
                                      right: 6,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                          iconSize: 20,
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () async {
                                            await deleteGrades(grade.id);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
