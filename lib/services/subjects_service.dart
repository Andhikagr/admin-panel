import 'dart:convert';
import 'package:admin_panel/models/subject.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SubjectsService {
  static const String baseUrl = "http://192.168.1.2:8080";

  static Future<String?> _getToken() async {
    final cek = await SharedPreferences.getInstance();
    return cek.getString("token");
  }

  static Future<List<Subject>> getSubjects({required int gradeId}) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/subjects?grade_id=$gradeId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((json) => Subject.fromJson(json)).toList();
    } else {
      throw Exception("Failed to get data subject");
    }
  }

  static Future<Subject> createSubject(String name, int? gradeId) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/subjects"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode({"name": name, "grade_id": gradeId}),
    );
    if (response.statusCode == 201) {
      return Subject.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to add subject");
    }
  }

  static Future<void> deleteSubject(int id) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/subjects/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode != 204) {
      throw Exception("Failed to delete subject");
    }
  }
}
