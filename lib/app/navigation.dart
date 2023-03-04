import 'package:flutter/material.dart';
import 'package:test_flutter_app/screens/home.dart';
import 'package:test_flutter_app/screens/profile.dart';
import '../constants/md_app_assets.dart';
import '../screens/medical_speciality.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 0;

  final _pages = [
    const Home(),
    const MedicalSpeciality(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          indicatorColor: Color(0xFFE4EFFF),
          labelTextStyle: MaterialStatePropertyAll(
            TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          height: 70,
          backgroundColor: Colors.white,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(
                icon: Image.asset(
                  AppAssets.mdNavBarMedicalIcon,
                  width: 30,
                  height: 30,
                ),
                label: 'Прегледи'),
            NavigationDestination(
                icon: Image.asset(
                  AppAssets.mdNavBarDoctorIcon,
                  width: 30,
                  height: 30,
                ),
                label: 'Лекари'),
            NavigationDestination(
                icon: Image.asset(
                  AppAssets.mdNavBarProfileIcon,
                  width: 25,
                  height: 25,
                ),
                label: 'Профил'),
          ],
        ),
      ),
    );
  }
}