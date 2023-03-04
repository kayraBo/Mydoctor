import 'package:flutter/material.dart';

import '../constants/md_app_assets.dart';
import '../constants/md_app_colors.dart';
import '../constants/md_app_fontstyle.dart';
import '../constants/md_app_strings.dart';
import '../model/appointment_model.dart';
import '../services/appointment_ref.dart';
import '../widgets/widgets.dart';

class HomeViewModel {
  displayPatientsAppointments() {
    return FutureBuilder(
        future: getAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var doctorData = snapshot.data as List<AppointmentModel>;

            if (doctorData.isEmpty) {
              return const Center(
                child: Text(AppStrings.strNoUpcomingAppointments),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: doctorData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
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
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.mdProfilePicture,
                                      height: 80,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${doctorData[index].doctorDegree}',
                                              style: AppFontStyles.bold18Black,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${doctorData[index].doctorName}',
                                              style: AppFontStyles.bold18Black,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${doctorData[index].doctorSurname}',
                                              style: AppFontStyles.bold18Black,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${doctorData[index].doctorMedSpeciality}',
                                          style: AppFontStyles.semiBold15Black,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${doctorData[index].doctorHospital}',
                                          style: AppFontStyles.semiBold15Black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 10,
                                  color: AppColors.mdLightBlueDividerColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doctorData[index].appointmentTime,
                                            style: AppFontStyles.bold18Black,
                                          ),
                                          Text(
                                            doctorData[index].appointmentDate,
                                            style:
                                                AppFontStyles.semiBold18Black,
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          deleteAppoinment(
                                              doctorData[index].appointmentId);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.mdDarkBlueColor,
                                          shape: borderRadius(),
                                          minimumSize: const Size(114.96, 37),
                                        ),
                                        child: const Text(
                                          AppStrings.strCancel,
                                          style: AppFontStyles.bold18White,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }
        });
  }

  displayDoctorsAppointments() {
    return FutureBuilder(
        future: getDoctorAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var patientData = snapshot.data as List<AppointmentModel>;

            if (patientData.isEmpty) {
              return const Center(
                child: Text(AppStrings.strNoUpcomingAppointments),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: patientData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
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
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.mdProfilePicture,
                                      height: 80,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${patientData[index].patientName}',
                                              style: AppFontStyles.bold18Black,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${patientData[index].patientSurname}',
                                              style: AppFontStyles.bold18Black,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          patientData[index].notes,
                                          style: AppFontStyles.semiBold15Black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 10,
                                  color: AppColors.mdLightBlueDividerColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patientData[index].appointmentTime,
                                            style: AppFontStyles.bold18Black,
                                          ),
                                          Text(
                                            patientData[index].appointmentDate,
                                            style:
                                                AppFontStyles.semiBold18Black,
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          deleteAppoinment(
                                              patientData[index].appointmentId);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.mdDarkBlueColor,
                                          shape: borderRadius(),
                                          minimumSize: const Size(114.96, 37),
                                        ),
                                        child: const Text(
                                          AppStrings.strCancel,
                                          style: AppFontStyles.bold18White,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }
        });
  }
}
