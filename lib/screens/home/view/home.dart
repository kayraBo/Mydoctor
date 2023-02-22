import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';

import '../../../cloud_firestore/appointment_ref.dart';
import '../../../constants/md_app_assets.dart';
import '../../../constants/md_app_fontstyle.dart';
import '../../../model/appointment_model.dart';
import '../../../widgets/widgets.dart';

class Home extends StatefulWidget {
  //final String uidDoc;
  const Home({
    Key? key,
    /*required this.uidDoc*/
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  displayDoctors() {
    return FutureBuilder(
        future: getAppointments(/*widget.uidDoc*/),
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
                                          MainAxisAlignment.center,
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
                                              '${doctorData[index].userName}',
                                              style: AppFontStyles.bold18Black,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${doctorData[index].userSurname}',
                                              style: AppFontStyles.bold18Black,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${doctorData[index].doctorMedSpeciality}',
                                          style: AppFontStyles.semiBold15Black,
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
                                        onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: const Text(
                  AppStrings.strWelcomeMessage,
                  style: AppFontStyles.bold35Black,
                )),
            const SizedBox(
              height: 30,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: const Text(
                  AppStrings.strUpcomingAppointmnets,
                  style: AppFontStyles.semBold17Black,
                )),
            Expanded(
                child: Container(
              child: displayDoctors(),
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
