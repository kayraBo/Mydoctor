import 'package:flutter/material.dart';
import '../model/profile_model.dart';
import '../widgets/widgets.dart';

class EditProfile extends StatefulWidget {
  final ProfileModel user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController? _nameController;
  TextEditingController? _surnameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneNumController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _surnameController = TextEditingController(text: widget.user.surname);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneNumController = TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _nameController!.dispose();
    _surnameController!.dispose();
    _phoneNumController!.dispose();
    super.dispose();
  }

  displayUpdatedUserData() {
    Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: textFieldWidget('Име', false, _nameController!),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: textFieldWidget('Фамилия', false, _surnameController!),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: textFieldWidget('Имейл', false, _emailController!),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: numberFieldWidget('Телефон', _phoneNumController!),
        ),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: buttonWidget(context, 'Запази', const Color(0xFF2862B7),
                Colors.white, () {})),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Stack(alignment: AlignmentDirectional.center, children: [
            Container(
              height: 450,
              width: 397,
              decoration: const BoxDecoration(
                color: Color(0xFFE4EFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
            ),
            Expanded(
                child: Container(
              child: displayUpdatedUserData(),
              width: 357,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            )),
          ]),
        ],
      ),
    );
  }
}
