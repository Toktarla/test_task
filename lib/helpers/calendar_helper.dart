class CalendarHelper {
  static int getNumberOfDaysInMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1);
    final lastDayOfMonth = nextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }

  // Get the starting day of the month (Monday = 0, Sunday = 6)
  static int getStartDayOfMonth(DateTime date) {
    return (date.weekday - 1) % 7; // Adjust for Monday as the first day
  }
}