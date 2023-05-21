import 'package:flutter/material.dart';
import '../constants/md_app_assets.dart';
import '../viewModels/profile_view_model.dart';
import '../constants/md_app_colors.dart';
import '../widgets/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.isDoctor});
  final bool isDoctor;

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

  ProfileViewModel profileViewModel = ProfileViewModel();

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
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: widget.isDoctor
                    ? profileViewModel.displayDoctorData()
                    : profileViewModel.displayPatientData(),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
