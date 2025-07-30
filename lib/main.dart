import 'package:admin_panel/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF0074B2),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      // home: LoginPage(),
      home: Login(),
    );
  }
}
