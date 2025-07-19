import 'package:flutter/material.dart';

import '../../gen/colors.gen.dart';
import 'assesment/assesment_page.dart';
import 'health/page/health_page.dart';
import 'info/info_page.dart';
import 'profile/page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              const HealthPage(),
              const AssesmentPage(),
              const InfoPage(),
              const ProfilePage(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety_rounded),
            label: 'Health',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorName.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
