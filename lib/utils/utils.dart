import 'package:intl/intl.dart';

List<String> timeSlotsSet = [
  '7:00',
  '7:30',
  '8:00',
  '8:30',
  '9:00',
  '9:30',
  '10:00',
  '10:30',
  '11:00',
  '11:30',
  '12:00',
  '12:30',
  '13:00',
  '13:30',
  '14:00',
];

String getDateFormated(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}
