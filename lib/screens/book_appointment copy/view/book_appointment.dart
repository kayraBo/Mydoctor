import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_flutter_app/constants/md_app_colors.dart';
import 'package:test_flutter_app/constants/md_app_fontstyle.dart';

import '../../../constants/md_app_strings.dart';
import '../../../widgets/widgets.dart';

class Appointment extends StatefulWidget {
  const Appointment({
    Key? key,
  }) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  DateTime today = DateTime.now();

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
      body: calendar(),
    );
  }

  Widget calendar() {
    return Column(
      children: [
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
              todayTextStyle: TextStyle(
                color: AppColors.mdDarkBlueColor,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
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
        // Expanded(
        //     child: GridView.builder(
        //         itemCount: timeSlot.length,
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 3),
        //         itemBuilder: ((context, index) => GestureDetector(
        //               onTap: (() {
        //                 context.read(selectedTime).state =
        //                     time_slot.elementAt(index);
        //               }),
        //               child: Card(
        //                   color: context.read(selectedTime).state ==
        //                           time_slot.elementAt(index)
        //                       ? const Color(0xFF2862B7)
        //                       : Colors.white,
        //                   shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(20)),
        //                   margin: const EdgeInsets.all(10),
        //                   child: GridTile(
        //                     child: Center(
        //                       child: Text(time_slot.elementAt(index)),
        //                     ),
        //                   )),
        //             ))))
      ],
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  // final selectedDay = useState(DateTime.now());

  // void _onDaySelected(DateTime day, DateTime focusedDay) {
  //   selectedDay.value = day;
  // }
}
