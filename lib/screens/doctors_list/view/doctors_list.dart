import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';
import 'package:test_flutter_app/constants/md_app_strings.dart';
import 'package:test_flutter_app/widgets/widgets.dart';
import '../../../cloud_firestore/profile_ref.dart';
import '../../../constants/md_app_assets.dart';
import '../../../model/profile_model.dart';
import '../../doctor_profile/view/doctor_profile.dart';

class MedicalSpecialityDoctors extends StatefulWidget {
  const MedicalSpecialityDoctors({
    Key? key,
    required this.msCode,
    required this.msName,
  }) : super(key: key);

  final int msCode;
  final String msName;

  @override
  State<MedicalSpecialityDoctors> createState() => _MedicalSpecialityDoctors();
}

class _MedicalSpecialityDoctors extends State<MedicalSpecialityDoctors> {
  final _searchController = TextEditingController();

  displayDoctors() {
    return FutureBuilder(
        future: getDoctorsBySpectialityCode(widget.msCode),
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
                                    DocInfo(uidDoc: profileID)),
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
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.mdProfilePicture,
                                      height: 80,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${profile.degree}',
                                                style: AppFontStyles
                                                    .semiBold19Black,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text('${profile.name}',
                                                  style: AppFontStyles
                                                      .semiBold19Black),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                '${profile.surname}',
                                                style: AppFontStyles
                                                    .semiBold19Black,
                                              ),
                                            ]),
                                        Text(
                                          '${profile.medicalSpecialityName}',
                                          style: AppFontStyles.normal17Black,
                                        ),
                                        Text('${doctorData[index].hospital}',
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

  List serachResult = [];
  String inputText = "";

  void serachList(String search) async {
    final result = await FirebaseFirestore.instance
        .collection('Medical_speciality_list')
        .where("Medical_speciality", isEqualTo: search)
        .get();

    setState(() {
      serachResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.strDoctors,
          style: TextStyle(
            color: AppColors.mdBlackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          child: AppFontStyles.iconArrowBack,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(children: <Widget>[
        Container(
            height: 80,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextField(
                controller: _searchController,
                cursorColor: AppColors.mdWhiteColor,
                style: AppFontStyles.normal20White,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  prefixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.mdWhiteColor,
                    ),
                    onPressed: () {
                      serachList(inputText);
                    },
                  ),
                  hintText: AppStrings.strSearch,
                  hintStyle: AppFontStyles.normal20White,
                  filled: true,
                  fillColor: AppColors.mdDarkBlueColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
                keyboardType: TextInputType.text,
                onChanged: (search) {
                  serachList(search);
                })),
        Expanded(
            child: Container(
          child: displayDoctors(),
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
        ))
      ]),
    );
  }
}
