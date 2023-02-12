// import 'package:flutter/material.dart';

// import '../../../cloud_firestore/profile_ref.dart';
// import '../../../constants/md_app_assets.dart';
// import '../../../constants/md_app_colors.dart';
// import '../../../constants/md_app_fontstyle.dart';
// import '../../../constants/md_app_strings.dart';
// import '../../../model/profile_model.dart';
// import '../../../widgets/widgets.dart';
// import '../../doctor_profile/view/doctor_profile.dart';

// displayDoctors() {
//     return FutureBuilder(
//         future: getDoctorsBySpectialityCode(widget.msCode),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             var doctorData = snapshot.data as List<ProfileModel>;
//             if (doctorData.isEmpty) {
//               return const Center(
//                 child: Text(AppStrings.strNoDoctorsFound),
//               );
//             } else {
//               return ListView.builder(
//                   itemCount: doctorData.length,
//                   itemBuilder: (context, index) {
//                     ProfileModel profile = doctorData[index];

//                     return GestureDetector(
//                         onTap: () {
//                           String profileID = '';
//                           if (profile.id != null) {
//                             profileID = profile.id!;
//                           }

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     DocInfo(uidDoc: profileID)),
//                           );
//                         },
//                         child: Card(
//                           shape: borderRadius(),
//                           margin: const EdgeInsets.all(8),
//                           child: ListTile(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             tileColor: AppColors.mdLightBlueColor,
//                             title: Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       AppAssets.mdProfilePicture,
//                                       height: 80,
//                                     ),
//                                     Column(
//                                       children: [
//                                         Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 '${profile.degree}',
//                                                 style: AppFontStyles
//                                                     .semiBold19Black,
//                                               ),
//                                               const SizedBox(
//                                                 width: 4,
//                                               ),
//                                               Text('${profile.name}',
//                                                   style: AppFontStyles
//                                                       .semiBold19Black),
//                                               const SizedBox(
//                                                 width: 4,
//                                               ),
//                                               Text(
//                                                 '${profile.surname}',
//                                                 style: AppFontStyles
//                                                     .semiBold19Black,
//                                               ),
//                                             ]),
//                                         Text(
//                                           '${profile.medicalSpecialityName}',
//                                           style: AppFontStyles.normal17Black,
//                                         ),
//                                         Text('${doctorData[index].hospital}',
//                                             style: AppFontStyles.normal17Black),
//                                       ],
//                                     ),
//                                   ]),
//                             ),
//                           ),
//                         ));
//                   });
//             }
//           }
//         });
//   }