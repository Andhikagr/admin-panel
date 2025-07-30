import 'dart:ui';

import 'package:admin_panel/screens/dashboard.dart';
import 'package:admin_panel/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  bool _isLoading = false;
  bool _loginCek = false;
  bool _sudahLogin = false;

  @override
  void initState() {
    super.initState();
    _cekLoginStatus();
  }

  Future<void> _cekLoginStatus() async {
    final loggedIn = await AuthService.isLoggedIn();
    if (loggedIn) {
      setState(() {
        _sudahLogin = true;
        // status hasil login (true jika login sukses, default-nya false).
      });
    }
    setState(() {
      _loginCek = true;
      //status pengecekan login sudah selesai atau belum. Nilainya diubah menjadi true selalu, baik login berhasil maupun gagal.
    });
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final sukses = await AuthService.login(
      _emailcontroller.text,
      _passwordcontroller.text,
    );
    setState(() => _isLoading = false);

    if (sukses) {
      if (!mounted) return;
      // Navigasi ke halaman dashboard jika login sukses
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Dashboard()),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login gagal.Cek email/password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loginCek) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_sudahLogin) {
      return const Dashboard();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth >= 900;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Image.asset(
                "assets/logincover.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    //container pembungkus
                    child: Container(
                      width: double.infinity,
                      // height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: isLargeScreen
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: IntroBox(
                                      isLargeScreen: isLargeScreen,
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  Flexible(
                                    flex: 1,
                                    child: LoginBox(
                                      isLargeScreen: isLargeScreen,
                                      formKey: _formKey,
                                      emailController: _emailcontroller,
                                      passwordController: _passwordcontroller,
                                      isLoading: _isLoading,
                                      onLogin: _handleLogin,
                                    ),
                                  ),
                                ],
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IntroBox(isLargeScreen: isLargeScreen),
                                    SizedBox(height: 30),
                                    LoginBox(
                                      isLargeScreen: isLargeScreen,
                                      formKey: _formKey,
                                      emailController: _emailcontroller,
                                      passwordController: _passwordcontroller,
                                      isLoading: _isLoading,
                                      onLogin: _handleLogin,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: "enter email .....",
        hintStyle: TextStyle(
          fontSize: 12,
          color: Colors.black.withValues(alpha: 0.2),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}

class IntroBox extends StatelessWidget {
  final bool isLargeScreen;

  const IntroBox({super.key, required this.isLargeScreen});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: isLargeScreen ? 450 : 0,
        maxWidth: isLargeScreen ? 500 : MediaQuery.of(context).size.width * 0.9,
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Selamat Datang",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Text(
            "Admin Panel CBT",
            style: TextStyle(
              fontSize: 53,
              fontWeight: FontWeight.bold,
              color: Colors.yellowAccent,
              shadows: [
                Shadow(
                  color: Colors.yellow,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          Text(
            "Silakan login untuk mengelola ujian dan data peserta",
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class LoginBox extends StatelessWidget {
  final bool isLargeScreen;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onLogin;

  const LoginBox({
    super.key,
    required this.isLargeScreen,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          constraints: BoxConstraints(
            minHeight: isLargeScreen ? 450 : 0,
            maxWidth: isLargeScreen
                ? 500
                : MediaQuery.of(context).size.width * 0.9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withValues(alpha: 0.4),
          ),
          child: Padding(
            padding: EdgeInsets.all(isLargeScreen ? 50 : 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Enter email...",
                    validator: (hasil) {
                      if (hasil == null || hasil.isEmpty) {
                        return "Masukkan email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  Text("Password", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Enter password...",
                    validator: (hasil) {
                      if (hasil == null || hasil.isEmpty) {
                        return "Masukkan password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.deepPurple.withValues(alpha: 0.3),
                        highlightColor: Colors.deepPurple.withValues(
                          alpha: 0.3,
                        ),
                        onTap: isLoading ? null : onLogin,
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : Ink(
                                width: 250,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
