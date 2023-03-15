import 'package:flutter/material.dart';

import '../services/profile_ref.dart';
import '../constants/md_app_assets.dart';
import '../constants/md_app_colors.dart';
import '../constants/md_app_fontstyle.dart';
import '../constants/md_app_strings.dart';
import '../model/profile_model.dart';
import '../screens/doctor_profile.dart';
import '../widgets/widgets.dart';

class DoctorsListViewModel {
  final int msCode;
  final String msName;

  ProfileService profileService = ProfileService();

  DoctorsListViewModel({
    required this.msCode,
    required this.msName,
  });

  displayDoctors() {
    return FutureBuilder(
        future: profileService.getDoctorsBySpectialityCode(msCode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var doctorData = snapshot.data as List<ProfileModel>;
            if (doctorData.isEmpty) {
              return const Center(
                child: Text(AppStrings.strNoDoctorsFound),
              );
            } else {
              return ListView.builder(
                  itemCount: doctorData.length,
                  itemBuilder: (context, index) {
                    ProfileModel profile = doctorData[index];

                    return GestureDetector(
                        onTap: () {
                          String profileID = '';
                          if (profile.id != null) {
                            profileID = profile.id!;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DocInfo(uidDoc: profileID, msCode: msCode)),
                          );
                        },
                        child: Card(
                          shape: borderRadius(),
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            tileColor: AppColors.mdLightBlueColor,
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.mdProfilePicture,
                                      height: 80,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(children: [
                                          Text(
                                            '${profile.degree}',
                                            softWrap: false,
                                            style:
                                                AppFontStyles.semiBold19Black,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text('${profile.name}',
                                              softWrap: false,
                                              style: AppFontStyles
                                                  .semiBold19Black),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '${profile.surname}',
                                            softWrap: false,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            style:
                                                AppFontStyles.semiBold19Black,
                                          ),
                                        ]),
                                        Text(
                                          '${profile.medicalSpecialityName}',
                                          softWrap: true,
                                          style: AppFontStyles.normal17Black,
                                        ),
                                        Text('${doctorData[index].hospital}',
                                            softWrap: true,
                                            style: AppFontStyles.normal17Black),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        ));
                  });
            }
          }
        });
  }
}
