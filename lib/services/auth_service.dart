import 'dart:convert';

import 'package:admin_panel/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // static const String baseUrl =
  //     "http://localhost:8080";
  static const String baseUrl = "http://192.168.1.2:8080";
  // ganti jika pakai device fisik
  static Future<bool> isLoggedIn() async {
    final cek = await SharedPreferences.getInstance();
    final token = cek.getString("token");
    return token != null;
  }

  Future<void> saveToken(String token) async {
    final cek = await SharedPreferences.getInstance();
    await cek.setString("token", token);
  }

  static Future<bool> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");

    try {
      //
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email.trim(), "password": password.trim()}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data["token"];

        if (token != null) {
          final cek = await SharedPreferences.getInstance();
          await cek.setString("token", token);
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<void> logOut(BuildContext context) async {
    final cek = await SharedPreferences.getInstance();
    await cek.remove("token");
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
}
