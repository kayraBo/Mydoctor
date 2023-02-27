import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_flutter_app/services/appointment_ref.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';
import 'package:test_flutter_app/screens/home.dart';

import '../constants/md_app_strings.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class Appointment extends StatefulWidget {
  final String doctorId;

  const Appointment({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  late String appDate;
  late String appTime;
  late String appNote;
  int? isSelected;

  DateTime today = DateTime.now();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var timeWatch = watch(selectedTime).state;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.strBookAppointment,
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Card(
                  color: AppColors.mdLightBlueColor,
                  margin: const EdgeInsets.all(20),
                  shape: borderRadius(),
                  child: TableCalendar(
                    // locale: "bg",
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: AppFontStyles.semiBold19Black,
                      leftChevronIcon: AppFontStyles.iconLeftrrow,
                      rightChevronIcon: AppFontStyles.iconRightArrow,
                    ),

                    calendarStyle: const CalendarStyle(
                      defaultTextStyle: AppFontStyles.textSize17,
                      weekendTextStyle: AppFontStyles.textSize17,
                      todayTextStyle: AppFontStyles.bold16DarkBlue,
                      todayDecoration: BoxDecoration(
                        color: AppColors.mdLightBlueColor,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppColors.mdDarkBlueColor,
                        shape: BoxShape.circle,
                      ),
                    ),

                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: ((day) => isSameDay(day, today)),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    focusedDay: today,
                    firstDay: DateTime.utc(2022, 01),
                    lastDay: DateTime.utc(2040, 12),
                    onDaySelected: _onDaySelected,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppStrings.strAvailableHours,
                      style: AppFontStyles.semBold17Black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: (1 / .4)),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: (() {
                    setState(() {
                      isSelected = index;
                    });
                    appTime = timeSlot.elementAt(index);
                  }),
                  child: Card(
                      color: isSelected == index
                          ? AppColors.mdDarkBlueColor
                          : AppColors.mdLightBlueColor,
                      shape: borderRadius(),
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: GridTile(
                        child: Center(
                          child: Text(timeSlot.elementAt(index),
                              style: isSelected == index
                                  ? AppFontStyles.normal17White
                                  : AppFontStyles.normal17Black),
                        ),
                      )),
                );
              },
              childCount: timeSlot.length,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                  child: multiLineTextWidget(
                      AppStrings.strDescription, _descriptionController),
                ),
                SafeArea(
                  child: Container(
                      height: 70,
                      width: 397,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          setAppointment(appDate, appTime,
                              _descriptionController.text, widget.doctorId);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Home(/*uidDoc: widget.doctorId*/)),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      appDate = DateFormat('dd/MM/yyyy').format(day);
    });
  }
}
