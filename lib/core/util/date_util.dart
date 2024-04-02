import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat.yMMMMd().format(date);
}

DateTime parseDate(String date) {
  return DateFormat.yMMMMd().parse(date);
}
