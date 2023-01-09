import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                child: const Text(
                  'Добре дошли в Mydoctor',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                )),
          ],
        ),
      ),
    );
  }
}
