import 'package:admin_panel/widgets/exam_model.dart';
import 'package:admin_panel/widgets/textfield_one.dart';
import 'package:admin_panel/widgets/button_one.dart';
import 'package:flutter/material.dart';

class Exam extends StatefulWidget {
  const Exam({super.key});

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController fileController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  List<ExamModel> examList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Exam",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    //add exam button pop-up
                    ButtonOne(
                      name: "Add New Exam",
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
                                    "Input Exam",
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
                                        label: "Exam Name",
                                        controller: nameController,
                                      ),
                                      TextfieldOne(
                                        label: "Choose File",
                                        controller: fileController,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2020),
                                                lastDate: DateTime(2030),
                                              );
                                          setState(() {
                                            selectedDate = pickedDate;
                                            dateController.text =
                                                "${pickedDate?.year}-${pickedDate?.month.toString().padLeft(2, '0')}-${pickedDate?.day.toString().padLeft(2, '0')}";
                                          });
                                        },
                                        child: AbsorbPointer(
                                          child: TextfieldOne(
                                            label: "Date",
                                            controller: dateController,
                                          ),
                                        ),
                                      ),
                                      //start time
                                      GestureDetector(
                                        onTap: () async {
                                          TimeOfDay? pickedStartTime =
                                              await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                          if (pickedStartTime != null) {
                                            setState(() {
                                              selectedStartTime =
                                                  pickedStartTime;
                                              startTimeController.text =
                                                  pickedStartTime.format(
                                                    context,
                                                  );
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextfieldOne(
                                            label: "Start Time",
                                            controller: startTimeController,
                                          ),
                                        ),
                                      ),
                                      //end time
                                      GestureDetector(
                                        onTap: () async {
                                          TimeOfDay? pickedEndTime =
                                              await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                          if (pickedEndTime != null) {
                                            setState(() {
                                              selectedEndTime = pickedEndTime;
                                              endTimeController.text =
                                                  pickedEndTime.format(context);
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextfieldOne(
                                            label: "Finish Time",
                                            controller: endTimeController,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (selectedDate != null &&
                                            selectedStartTime != null &&
                                            selectedEndTime != null &&
                                            nameController.text.isNotEmpty &&
                                            fileController.text.isNotEmpty) {
                                          final newExam = ExamModel(
                                            name: nameController.text,
                                            fileName: fileController.text,
                                            date: selectedDate!,
                                            startTime: selectedStartTime!,
                                            endTime: selectedEndTime!,
                                            isActive: true,
                                          );
                                          Navigator.of(context).pop();

                                          setState(() {
                                            examList.add(newExam);
                                          });
                                        }
                                      },
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(color: Colors.white),
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
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 275,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF02223B).withValues(alpha: 0.2),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.search, size: 16, color: Colors.grey),
                            SizedBox(width: 5),
                            Text(
                              "Search...",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF02223B).withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 5),
                          Text(
                            "Exam Status",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_drop_down, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: GridView.builder(
                      itemCount: examList.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        mainAxisExtent: 270,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        final exam = examList[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.4),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),

                                  child: Container(
                                    color: Colors.white,
                                    child: Image.asset(
                                      "assets/covercbt.png",
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        exam.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        width: 70,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEAFFF0),
                                          border: Border.all(
                                            color: const Color(0xFFBBFFD3),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            exam.isActive
                                                ? "Active"
                                                : "Completed",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Started on ${exam.date.day} ${_monthName(exam.date.month)} ${exam.date.year}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.timelapse, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      "Time ${_formatTime(exam.startTime)} - ${_formatTime(exam.endTime)} WIB",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

String _monthName(int month) {
  const months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return months[month];
}

String _formatTime(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return "$hour:$minute";
}
