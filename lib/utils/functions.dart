String capitalizeEnumValue(String enumValue) {
  String enumName = enumValue.toString().split('.').last;
  return enumName.substring(0, 1).toUpperCase() +
      enumName.substring(1).toLowerCase();
}
