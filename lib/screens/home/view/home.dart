import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';

import '../../../cloud_firestore/appointment_ref.dart';
import '../../../constants/md_app_fontstyle.dart';
import '../../../model/appointment_model.dart';
import '../../../widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  displayDoctors() {
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(children: [
                                  Text(
                                    doctorData[index].appointmentTime,
                                    style: AppFontStyles.semiBold22Black,
                                  ),
                                  Text(
                                    doctorData[index].appointmentDate,
                                    style: AppFontStyles.semiBold18Black,
                                  ),
                                  // Text(
                                  //   '${doctorData[index].notes}',
                                  //   style: const TextStyle(
                                  //       color: AppColors.mdBlackColor,
                                  //       fontWeight: FontWeight.normal,
                                  //       fontSize: 18),
                                  // ),
                                ]),
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
