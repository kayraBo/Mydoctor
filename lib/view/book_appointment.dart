import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_flutter_app/auth/state_management.dart';
import 'package:test_flutter_app/utils/utils.dart';

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
          'Запиши час',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
          color: const Color(0xFFE4EFFF),
          margin: const EdgeInsets.all(20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: TableCalendar(
            // locale: "bg",
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 28,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.black,
                size: 28,
              ),
            ),

            calendarStyle: const CalendarStyle(
              defaultTextStyle: TextStyle(
                fontSize: 17,
              ),
              weekendTextStyle: TextStyle(
                fontSize: 17,
              ),
              todayTextStyle: TextStyle(
                color: Color(0xFF2862B7),
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFFE4EFFF),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xFF2862B7),
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
        //         itemCount: time_slot.length,
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
