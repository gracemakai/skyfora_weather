import 'package:intl/intl.dart';

String fahrenheitToCelsiusConverter(double temp){
  return '${(temp - 273.15).toStringAsFixed(1)}°C';
}

String formatDateToTime(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  DateTime now = DateTime.now();

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day &&
      dateTime.hour == now.hour) {
    return "Now";
  }

  return DateFormat('HH:mm').format(dateTime);
}

String getDayOfWeek(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  String day = DateFormat('EEEE').format(date);

  DateTime today = DateTime.now();
  if (date.year == today.year &&
      date.month == today.month &&
      date.day == today.day) {
    return "Today";
  }

  return day;
}

String formatToDayAndMonth(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  String formattedDate = DateFormat('d MMM').format(date);
  return formattedDate;
}