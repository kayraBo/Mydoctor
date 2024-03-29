import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/appointment_ref.dart';
import '../constants/md_app_colors.dart';
import '../constants/md_app_fontstyle.dart';

import '../constants/md_app_strings.dart';
import '../utils/utils.dart' as utils;
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
  late Map<String, bool> timeSlots = <String, bool>{};
  late List<String> takenHours = List<String>.empty(growable: true);
  int? isSelected;

  DateTime today = DateTime.now();
  final _descriptionController = TextEditingController();
  AppointmentsService appointmentsService = AppointmentsService();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                      firstDay: DateTime.now(),
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
                      if (timeSlots[utils.timeSlotsSet[index]] == true) {
                        setState(() {
                          isSelected = index;
                        });
                        appTime = utils.timeSlotsSet.elementAt(index);
                      }
                    }),
                    child: Card(
                        color: returnHourColor(
                            isSelected == index, utils.timeSlotsSet[index]),
                        shape: borderRadius(),
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: GridTile(
                          child: Center(
                            child: Text(utils.timeSlotsSet.elementAt(index),
                                style: isSelected == index
                                    ? AppFontStyles.normal17White
                                    : AppFontStyles.normal17Black),
                          ),
                        )),
                  );
                },
                childCount: utils.timeSlotsSet.length,
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
                            appointmentsService.setAppointment(appDate, appTime,
                                _descriptionController.text, widget.doctorId);
                            Navigator.pop(context);
                            successAlert(context);
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
      ),
    );
  }

  Color returnHourColor(bool isSelected, String time) {
    if (isSelected) {
      return AppColors.mdDarkBlueColor;
    }

    if (timeSlots[time] == false) {
      return AppColors.mdGreyColor;
    }

    return AppColors.mdLightBlueColor;
  }

  void generateFreeHoursList(String date) async {
    if (takenHours.isNotEmpty) {
      takenHours.clear();
    }

    takenHours =
        await appointmentsService.getTakenHoursByDocId(widget.doctorId, date);

    for (var time in utils.timeSlotsSet) {
      if (takenHours.contains(time)) {
        timeSlots[time] = false;
      } else {
        timeSlots[time] = true;
      }
    }

    // Redraw the hours buttons
    setState(() {});
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    generateFreeHoursList(utils.getDateFormated(focusedDay));
    setState(() {
      today = day;
      appDate = utils.getDateFormated(day);
    });
  }
}
