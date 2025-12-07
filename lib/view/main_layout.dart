import 'package:flutter/material.dart';
import 'home_page.dart'; 
import 'profile/profile_page.dart';
import 'history_page.dart'; // Import History Page

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),     
    HistoryPage(), // Add History Page as Index 1
    ProfilePage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.orange, 
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined), 
              activeIcon: Icon(Icons.cloud),
              label: "Weather"
            ),
            // NEW HISTORY TAB
            BottomNavigationBarItem(
              icon: Icon(Icons.history), 
              activeIcon: Icon(Icons.history_edu), // Fun icon for active state
              label: "History"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), 
              activeIcon: Icon(Icons.person),
              label: "Profile"
            ),
          ],
        ),
      ),
    );
  }
}