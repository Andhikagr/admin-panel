import 'package:admin_panel/models/subject.dart';
import 'package:admin_panel/screens/dashboard.dart';
import 'package:admin_panel/services/subjects_service.dart';
import 'package:admin_panel/widgets/button_one.dart';
import 'package:admin_panel/widgets/textfield_one.dart';
import 'package:flutter/material.dart';

class SubjectCourse extends StatefulWidget {
  final int gradeId;
  final String grade;

  const SubjectCourse({super.key, required this.gradeId, required this.grade});

  @override
  State<SubjectCourse> createState() => _SubjectCourseState();
}

class _SubjectCourseState extends State<SubjectCourse> {
  List<Subject> subjects = [];
  TextEditingController subjectController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubject();
  }

  Future<void> fetchSubject() async {
    try {
      final data = await SubjectsService.getSubjects(gradeId: widget.gradeId);
      setState(() {
        subjects = data;
        sortSubject();
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addSubject() async {
    try {
      final newSubject = await SubjectsService.createSubject(
        subjectController.text,
        widget.gradeId,
      );
      setState(() {
        subjects.add(newSubject);
        sortSubject();
        subjectController.clear();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteSubject(int id) async {
    try {
      await SubjectsService.deleteSubject(id);
      setState(() {
        subjects.removeWhere((del) {
          return del.id == id;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void sortSubject() {
    subjects.sort((a, b) {
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
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "back",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 25),
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
                      "Subject Management",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ButtonOne(
                      name: "Add New Subject",
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
                                    "Subjects Course",
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
                                        label: "Input Subject",
                                        controller: subjectController,
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
                                        if (subjectController.text.isNotEmpty) {
                                          await addSubject();
                                          await fetchSubject();
                                          if (!context.mounted) return;
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
                          padding: EdgeInsets.only(top: 20),
                          child: ListView.builder(
                            itemCount: subjects.length,
                            itemBuilder: (context, index) {
                              final subjectCourse = subjects[index];
                              return Padding(
                                padding: EdgeInsets.all(10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 60,
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
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            subjectCourse.name,
                                            style: TextStyle(
                                              color: const Color(0xFF5B1C09),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
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
                                            await deleteSubject(
                                              subjectCourse.id,
                                            );
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
