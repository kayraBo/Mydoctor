import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_assets.dart';
import 'package:test_flutter_app/view%20models/profile_view_model.dart';
import '../constants/md_app_colors.dart';
import '../widgets/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumController = TextEditingController();

  late ProfileViewModel profileViewModel = ProfileViewModel();

  bool isDoctor = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          Image.asset(AppAssets.mdProfilePicture),
          const Spacer(),
          Stack(alignment: AlignmentDirectional.center, children: [
            Container(
              height: fullHeight(context) * .5,
              decoration: const BoxDecoration(
                color: AppColors.mdLightBlueColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Wrap(children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: isDoctor
                      ? profileViewModel.displayDoctorData()
                      : profileViewModel.displayPatientData(),
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              ]),
            ),
          ]),
        ],
      ),
    );
  }
}
