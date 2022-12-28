import 'package:flutter/material.dart';

class MedicalSpeciality extends StatefulWidget {
  const MedicalSpeciality({Key? key}) : super(key: key);

  @override
  State<MedicalSpeciality> createState() => _MedicalSpeciality();
}

class _MedicalSpeciality extends State<MedicalSpeciality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        children: <Widget>[
          Container(
              height: 200,
              width: 397,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              //color: Colors.amber,
              child: const Text(
                'Категории',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              )),
        ],
      ),
    ));
  }
}
