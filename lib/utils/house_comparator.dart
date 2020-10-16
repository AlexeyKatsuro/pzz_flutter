import 'package:pzz/models/person_info/house.dart';

int compareHouse(House one, House two) {
  //TODO
  return 0;
}

bool isDigit(String s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}
