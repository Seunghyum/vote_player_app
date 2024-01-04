import 'package:intl/intl.dart';

String getyyyyMMdd(DateTime date) {
  final dateFormat = DateFormat('yyyy.MM.dd');
  return dateFormat.format(date);
}
