abstract class DateTimeFormatter {
  static String formatChineseDate(DateTime dateTime) {
    if (dateTime == null) {
      return '';
    }
    return '${dateTime.year}年${dateTime.month}月${dateTime.day}日';
  }
}