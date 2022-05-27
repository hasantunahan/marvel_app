
extension StringToBool on String {
  bool toBoolean() {
    if (this == "true") {
      return true;
    } else {
      return false;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return this == "" ? "" : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
