import 'package:flutter/material.dart';
import '../constants/md_app_colors.dart';
import '../constants/md_app_fontstyle.dart';
import '../constants/md_app_strings.dart';
import '../screens/sign_up_doctor.dart';
import '../screens/sign_up_user.dart';

import '../constants/md_app_assets.dart';
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
      appBar: appBar(context),
      body: Column(
        children: <Widget>[
          Container(
              height: 182,
              width: 397,
              alignment: Alignment.bottomCenter,
              child: const Text(
                AppStrings.strRegistration,
                style: AppFontStyles.bold35Black,
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: const Text(
                AppStrings.strChooseProfileMessage,
                textAlign: TextAlign.center,
                style: AppFontStyles.semiBold18Black,
              )),
          Container(
              height: 90,
              width: 397,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpDoctor()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mdDarkBlueColor,
                  shape: borderRadius(),
                  minimumSize: const Size(328, 56),
                ),
                child: const Text(AppStrings.strDoctorProfile,
                    style: AppFontStyles.semiBold22White),
              )),
          Container(
              height: 70,
              width: 397,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mdDarkBlueColor,
                  shape: borderRadius(),
                  minimumSize: const Size(328, 56),
                ),
                child: const Text(
                  AppStrings.strPatientProfile,
                  style: AppFontStyles.semiBold22White,
                ),
              )),
          Container(
            height: 300,
            width: 397,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(5, 40, 20, 0),
            child: pictureWidget(AppAssets.mdSignInDoctorPicture),
          ),
        ],
      ),
    );
  }
}
