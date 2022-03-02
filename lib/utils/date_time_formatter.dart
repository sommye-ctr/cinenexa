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
}
