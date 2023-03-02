import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';
import 'package:test_flutter_app/view%20models/doctor_profile_view_model.dart';
import '../constants/md_app_assets.dart';
import '../constants/md_app_colors.dart';
import '../constants/md_app_strings.dart';
import '../widgets/widgets.dart';
import 'book_appointment.dart';

class DocInfo extends StatefulWidget {
  final String uidDoc;
  final int msCode;

  const DocInfo({
    Key? key,
    required this.uidDoc,
    required this.msCode,
  }) : super(key: key);

  @override
  State<DocInfo> createState() => _DocInfoState();
}

class _DocInfoState extends State<DocInfo> {
  late DoctorProfileViewModel doctorProfileViewModel =
      DoctorProfileViewModel(uidDoc: widget.uidDoc, msCode: widget.msCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset(AppAssets.mdProfilePicture),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  alignment: Alignment.center,
                  child: doctorProfileViewModel.displayDocInfo(),
                ),
              ),
              Container(
                  height: 70,
                  width: 397,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Appointment(
                                  doctorId: widget.uidDoc,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mdDarkBlueColor,
                      shape: borderRadius(),
                      minimumSize: const Size(300, 56),
                    ),
                    child: const Text(
                      AppStrings.strBookAppointment,
                      style: AppFontStyles.semiBold22White,
                    ),
                  ))
            ],
          ),
          Container(
            height: fullHeight(context) * .5,
            decoration: const BoxDecoration(
              color: AppColors.mdLightBlueColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                    child: Text(
                      AppStrings.strMoreInformation,
                      style: AppFontStyles.semiBold20Black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: doctorProfileViewModel.displayDoctorDesc(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
