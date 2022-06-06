import 'package:intl/intl.dart';

class DateTimeFormatter {
  static int getYearFromString(String string) {
    return DateTime.parse(string).year;
  }

  static String getTimeFromMin(int min) {
    Duration duration = Duration(
      minutes: min,
    );

    return "${duration.inHours}hr ${duration.inMinutes.remainder(60)}min";
  }

  static String getMonthYearFromString(String string) {
    DateTime date = DateFormat("yyyy-MM-dd").parse(string);
    return DateFormat("dd MMM").format(date);
  }

  static String getDateMonthYearFromString(String string) {
    DateTime date = DateFormat("yyyy-MM-dd").parse(string);
    return DateFormat("dd MMM yyyy").format(date);
  }

  static int getAge(String string) {
    DateTime date = DateFormat("yyyy-MM-dd").parse(string);
    DateTime current = DateTime.now();

    return current.year - date.year;
  }
}
