import 'package:flutter/material.dart';

class ExamModel {
  final String name;
  final String fileName;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isActive;

  ExamModel({
    required this.name,
    required this.fileName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isActive,
  });
}
