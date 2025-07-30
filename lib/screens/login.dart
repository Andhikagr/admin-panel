import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';
import 'dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      });
    }
    setState(() {
      _loginCek = true;
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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (ResponsiveHelper.isDesktop(context)) {
            return Row(
              children: [
                Expanded(child: IntroBox()),
                Expanded(
                  child: FormLogin(
                    isLargeScreen: ResponsiveHelper.isDesktop(context),
                    formKey: _formKey,
                    emailController: _emailcontroller,
                    passwordController: _passwordcontroller,
                    isLoading: _isLoading,
                    onLogin: _handleLogin,
                  ),
                ),
              ],
            );
          } else if (ResponsiveHelper.isTablet(context)) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    IntroBox(),

                    FormLogin(
                      isLargeScreen: ResponsiveHelper.isTablet(context),
                      formKey: _formKey,
                      emailController: _emailcontroller,
                      passwordController: _passwordcontroller,
                      isLoading: _isLoading,
                      onLogin: _handleLogin,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    IntroBox(),
                    FormLogin(
                      isLargeScreen: ResponsiveHelper.isMobile(context),
                      formKey: _formKey,
                      emailController: _emailcontroller,
                      passwordController: _passwordcontroller,
                      isLoading: _isLoading,
                      onLogin: _handleLogin,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class IntroBox extends StatelessWidget {
  const IntroBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 241, 248, 255),
      child: Padding(
        padding: EdgeInsets.only(top: 25, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.sunny, color: Color(0xFF0074B2), size: 20),
                SizedBox(width: 5),
                Text(
                  "A S K A D I G I",
                  style: TextStyle(
                    color: Color(0xFF0074B2),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              "Welcome to",
              style: TextStyle(
                color: Color(0xFF0074B2),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "CBT Admin Panel",
              style: GoogleFonts.archivoBlack(
                color: Color(0xFF0074B2),
                fontSize: 48,
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              child: Column(
                children: [
                  Image.asset(
                    "assets/covercbt.png",
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
  });
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscureText;
  }

  void _toggleObscure() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: TextFormField(
        cursorColor: Color(0xFF0074B2),
        controller: widget.controller,
        validator: widget.validator,
        obscureText: obscure,
        style: TextStyle(color: Color(0xFF0074B2)),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 12, color: Color(0x4A0074B2)),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: widget.obscureText
              ? Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: _toggleObscure,
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: Color.fromARGB(255, 0, 116, 178),
                    ),
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(93, 0, 116, 178)),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color.fromARGB(255, 0, 116, 178)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.deepOrangeAccent),
          ),
        ),
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  final bool isLargeScreen;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onLogin;

  const FormLogin({
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
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 70),
          Text(
            "Login to continue",
            style: GoogleFonts.poppins(
              color: Color(0xFF0074B2),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Please login to manage exams, participants, and results",
            style: GoogleFonts.poppins(color: Color(0xFF0074B2), fontSize: 12),
          ),
          SizedBox(height: 25),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: GoogleFonts.poppins(
                    color: Color(0xFF0074B2),
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: emailController,
                  hintText: "enter email",
                  obscureText: false,
                  validator: (hasil) {
                    if (hasil == null || hasil.isEmpty) {
                      return "Input Email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                Text(
                  "Password",
                  style: GoogleFonts.poppins(
                    color: Color(0xFF0074B2),
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  obscureText: true,
                  controller: passwordController,
                  hintText: "Enter password...",
                  validator: (hasil) {
                    if (hasil == null || hasil.isEmpty) {
                      return "Input Password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.white.withValues(alpha: 0.3),
                      highlightColor: Colors.white.withValues(alpha: 0.3),
                      onTap: isLoading ? null : onLogin,
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Ink(
                              width: 250,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFFFFCDF),
                                    fontWeight: FontWeight.w700,
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
        ],
      ),
    );
  }
}

class ResponsiveHelper {
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1000;
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
}
