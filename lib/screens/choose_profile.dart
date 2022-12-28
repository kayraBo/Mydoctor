import 'package:flutter/material.dart';
import 'package:test_flutter_app/screens/signup_doctor.dart';
import 'package:test_flutter_app/screens/signup_user.dart';

import '../widgets/widgets.dart';

class ProfileType extends StatefulWidget {
  const ProfileType({super.key});

  @override
  State<ProfileType> createState() => _ProfileTypeState();
}

class _ProfileTypeState extends State<ProfileType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
                /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );*/
              },
            ),
          ),
          Container(
              height: 182,
              width: 397,
              alignment: Alignment.bottomCenter,
              //padding: const EdgeInsets.fromLTRB(50, 200, 50, 20),
              //color: Colors.amber,
              child: const Text(
                'Регистрация',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: const Text(
                'Моля, изберете типа на профила, за който искате да се регистрирате',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              )),
          Container(
              height: 90,
              width: 397,
              alignment: Alignment.center,
              //color: Colors.green,
              //padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpDoctor()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2862B7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(328, 56),
                ),
                child: const Text(
                  'Лекарски профил',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              )),
          Container(
              height: 70,
              width: 397,
              alignment: Alignment.center,
              //color: Colors.blue,
              //padding: const EdgeInsets.fromLTRB(10, 20, 10, 60),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2862B7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(328, 56),
                ),
                child: const Text(
                  'Потребителски профил',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              )),
          Container(
            height: 300,
            width: 397,
            alignment: Alignment.bottomCenter,
            //color: Colors.yellow,
            padding: const EdgeInsets.fromLTRB(5, 40, 20, 0),
            child: pictureWidget("assets/images/Doctors.png"),
          ),
        ],
      ),
    );
  }
}
