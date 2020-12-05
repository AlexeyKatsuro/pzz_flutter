extension StringExt on String {
  bool get isDigit {
    if (this == null) {
      return false;
    }
    return int.tryParse(this) != null;
  }
}
