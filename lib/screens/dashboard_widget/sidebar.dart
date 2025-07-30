import 'package:admin_panel/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sidebar extends StatelessWidget {
  final Function(String menu) onMenuTap;
  final String selectedMenu;
  final VoidCallback onLogout;

  const Sidebar({
    super.key,
    required this.selectedMenu,
    required this.onMenuTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final menuItems = {
      "Dashboard": "assets/homepage.png",
      "Classroom": "assets/class.png",
      "Exam": "assets/quest.png",
      "Student": "assets/student.png",
      "Result": "assets/result.png",
      "Setting": "assets/setting.png",
    };

    return Padding(
      padding: EdgeInsets.only(top: 25, bottom: 25, right: 5, left: 25),
      child: Container(
        width: 275,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF0074B2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 2),
            ),
          ],
        ),

        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Admin Dashboard",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        color: Colors.white.withValues(alpha: 0.8),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: menuItems.entries.map((entry) {
                    final isSelected = entry.key == selectedMenu;
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      leading: Image.asset(
                        entry.value,
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                      title: Text(
                        entry.key,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          shadows: [
                            Shadow(
                              color: Colors.white.withValues(alpha: 0.3),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      selected: isSelected,
                      selectedTileColor: Colors.amberAccent,
                      onTap: () => onMenuTap(entry.key),
                    );
                  }).toList(),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF0074B2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 87, 133),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(2, 3),
                        ),
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 125, 192),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(-2, -3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, color: Colors.white, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            "Logout",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        splashColor: Colors.white.withValues(alpha: 0.1),
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text("Confirm Dialog"),
                                content: Text("Are you sure want to logout?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF0074B2),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await AuthService.logOut(context);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF0074B2),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text("Logout"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
