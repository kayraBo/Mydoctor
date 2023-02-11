import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';

import '../../../cloud_firestore/profile_ref.dart';
import '../../../constants/md_app_colors.dart';
import '../../../constants/md_app_strings.dart';
import '../../../model/profile_model.dart';
import '../../../widgets/widgets.dart';
import '../../book_appointment copy/view/book_appointment.dart';

class DocInfo extends StatefulWidget {
  final String uidDoc;

  const DocInfo({
    Key? key,
    required this.uidDoc,
  }) : super(key: key);

  @override
  State<DocInfo> createState() => _DocInfoState();
}

class _DocInfoState extends State<DocInfo> {
  displayDocInfo() {
    return FutureBuilder(
        future: getDocInfo(widget.uidDoc),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // var specialityName = snapshot.data as MedicalSpecialityModel;
            var docDesc = snapshot.data as ProfileModel;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${docDesc.degree} ',
                      style: AppFontStyles.semiBold20Black,
                    ),
                    Text(
                      '${docDesc.name} ',
                      style: AppFontStyles.semiBold20Black,
                    ),
                    Text(
                      '${docDesc.surname}',
                      style: AppFontStyles.semiBold20Black,
                    ),
                  ],
                ),
                // Text(
                //   '${specialityName.medicalSpeciality}',
                //   style: AppFontStyles.normal20Black,
                // ),
                Text(
                  '${docDesc.hospital}',
                  style: AppFontStyles.normal19Black,
                ),
              ],
            );
          }
        });
  }

  displayDoctorDesc() {
    return FutureBuilder(
        future: getDocInfo(widget.uidDoc),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var docDesc = snapshot.data as ProfileModel;
            return Text(
              '${docDesc.description}',
              style: AppFontStyles.normal17Black,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Image.asset("assets/images/profile_pic.png"),
            Wrap(children: [
              Container(
                alignment: Alignment.center,
                child: displayDocInfo(),
              )
            ]),
            Stack(children: <Widget>[
              DraggableScrollableSheet(builder: (context, scrollController) {
                return Container(
                  height: fullHeight(context) * .5,
                  decoration: const BoxDecoration(
                    color: AppColors.mdLightBlueColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            AppStrings.strMoreInformation,
                            style: AppFontStyles.semiBold20Black,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: displayDoctorDesc(),
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
                                        builder: (context) =>
                                            const Appointment()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.mdDarkBlueColor,
                                  shape: borderRadius(),
                                  minimumSize: const Size(328, 56),
                                ),
                                child: const Text(
                                  AppStrings.strBookAppointment,
                                  style: AppFontStyles.semiBold22White,
                                ),
                              )),
                        ],
                      )),
                );
              }),
            ]),
          ],
        ),
      ),
    );
  }
}
