import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/profile_model.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import '../constants/md_app_assets.dart';
import '../screens/medical_speciality.dart';
import '../services/profile_ref.dart';
import '../widgets/widgets.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 0;

  List<Widget> pages = List.empty(growable: true);
  List<Widget> destinations = List.empty(growable: true);

  List<Widget> destList = [
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
        label: 'Профил')
  ];

  void generateLists() {
    isADoctor().then((bool value) {
      Widget homePage = Home(isDoctor: value);
      Widget profilePage = Profile(isDoctor: value);

      if (pages.isEmpty && destinations.isEmpty) {
        setState(() {
          if (value) {
            pages.add(homePage);
            pages.add(profilePage);

            destinations.add(destList[0]);
            destinations.add(destList[2]);
          } else {
            pages.add(homePage);
            pages.add(const MedicalSpeciality());
            pages.add(profilePage);

            destinations = destList;
          }
        });
      }
    });
  }

  Future<bool> isADoctor() async {
    late bool isDoctor;
    try {
      ProfileService psrv = ProfileService();
      ProfileModel user =
          await psrv.getDocInfoById(FirebaseAuth.instance.currentUser!.uid);

      if (user.checkIfAnyIsNull()) {
        isDoctor = false;
      } else {
        isDoctor = true;
      }
    } on FirebaseException catch (error) {
      errorAlert(context, '${error.message}');
    }

    return isDoctor;
  }

  @override
  Widget build(BuildContext context) {
    generateLists();
    return Scaffold(
      body: pages.isEmpty ? returnContainer() : pages[index],
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
        child: destinations.isEmpty
            ? NavigationBar(
                destinations: [returnContainer(), returnContainer()])
            : NavigationBar(
                height: 70,
                backgroundColor: Colors.white,
                selectedIndex: index,
                onDestinationSelected: (index) =>
                    setState(() => this.index = index),
                destinations: destinations,
              ),
      ),
    );
  }

  Widget returnContainer() {
    return Container(
      color: Colors.transparent,
    );
  }
}
