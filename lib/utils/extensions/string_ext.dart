extension StringExt on String {
  bool get isDigit {
    return int.tryParse(this) != null;
  }
}
