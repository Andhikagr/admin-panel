import 'dart:convert';
import 'package:admin_panel/models/grade.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClassroomService {
  static const String baseUrl = "http://192.168.1.2:8080";

  static Future<String?> _getToken() async {
    final cek = await SharedPreferences.getInstance();
    return cek.getString("token");
  }

  static Future<List<Grade>> getGrades() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/grades"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((json) => Grade.fromJson(json)).toList();
    } else {
      throw Exception("Failed to get data grade");
    }
  }

  static Future<Grade> createGreade(String name) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/grades"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode({"name": name}),
    );
    if (response.statusCode == 201) {
      return Grade.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to add grade");
    }
  }

  static Future<void> deleteGrades(int id) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/grades/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode != 204) {
      throw Exception("Failed to delete grade");
    }
  }
}
