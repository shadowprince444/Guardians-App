import 'package:intl/intl.dart';

String capitalizeEnumValue(String enumValue) {
  String enumName = enumValue.toString().split('.').last;
  return enumName.substring(0, 1).toUpperCase() +
      enumName.substring(1).toLowerCase();
}

String formatDateTime(DateTime dateTime) {
  final formattedDate = DateFormat('hh:mm a dd/MM/yyyy').format(dateTime);
  return formattedDate;
}
