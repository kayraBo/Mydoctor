import 'package:flutter/material.dart';
import '../constants/md_app_colors.dart';
import '../constants/md_app_strings.dart';
import '../viewModels/home_view_model.dart';
import '../constants/md_app_assets.dart';
import '../constants/md_app_fontstyle.dart';
import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.isDoctor}) : super(key: key);
  final bool isDoctor;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(shrinkWrap: true, children: [
        Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: const Text(
                  AppStrings.strWelcomeMessage,
                  style: AppFontStyles.bold30Black,
                )),
            const SizedBox(
              height: 15,
            ),
            Card(
              shape: borderRadius(),
              margin: const EdgeInsets.all(10),
              color: AppColors.mdDarkBlueColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Text(
                        AppStrings.strMessageHome,
                        style: AppFontStyles.bold18White,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      child: Image.asset(
                        AppAssets.mdDoctorsHomePicture,
                        height: 115,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: const Text(
                  AppStrings.strUpcomingAppointmnets,
                  style: AppFontStyles.bold18Black,
                )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 3,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                color: AppColors.mdLightBlueDividerColor,
              ),
            ),
            Container(
              child: widget.isDoctor
                  ? homeViewModel.displayDoctorsAppointments(refreshHome)
                  : homeViewModel.displayPatientsAppointments(refreshHome),
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        ),
      ]),
    );
  }

  void refreshHome() {
    setState(() {});
  }
}
