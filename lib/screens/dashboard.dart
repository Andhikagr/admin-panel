import 'package:admin_panel/screens/dashboard_widget/exam.dart';
import 'package:admin_panel/screens/dashboard_widget/classroom/classroom.dart';
import 'package:admin_panel/screens/dashboard_widget/sidebar.dart';
import 'package:admin_panel/off/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedMenu = "Dashboard";

  @override
  void initState() {
    super.initState();
    _loadSelectedMenu();
  }

  void _loadSelectedMenu() async {
    SharedPreferences route = await SharedPreferences.getInstance();
    setState(() {
      selectedMenu = route.getString("selectedMenu") ?? "Dashboard";
    });
  }

  void onMenuTap(String menu) async {
    SharedPreferences routes = await SharedPreferences.getInstance();
    await routes.setString("selectedMenu", menu);

    setState(() {
      selectedMenu = menu;
    });
  }

  void onLogout() {
    setState(() {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget getSelectedpage() {
      switch (selectedMenu) {
        case "Dashboard":
          return Center(child: Text("This is Dashboard page"));
        case "Classroom":
          return Classroom();
        case "Exam":
          return Exam();
        default:
          return Center(child: Text(""));
      }
    }

    final isLargeScreen = MediaQuery.of(context).size.width >= 1200;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: isLargeScreen
          ? null
          : Drawer(
              child: Sidebar(
                selectedMenu: selectedMenu,
                onMenuTap: onMenuTap,
                onLogout: onLogout,
              ),
            ),

      body: Row(
        children: [
          if (isLargeScreen)
            Sidebar(
              selectedMenu: selectedMenu,
              onMenuTap: onMenuTap,
              onLogout: onLogout,
            ),
          Expanded(child: getSelectedpage()),
        ],
      ),
    );
  }
}
