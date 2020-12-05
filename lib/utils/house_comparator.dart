import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/utils/extensions/string_ext.dart';

int compareHouse(House one, House two) {
  final oneWeights = one.compareWeights;
  final twoWeights = two.compareWeights;
  final majorCompare = oneWeights[0].compareTo(twoWeights[0]);
  if (majorCompare != 0) {
    return majorCompare;
  }
  return oneWeights[1].compareTo(twoWeights[1]);
}

extension on House {
  List<num> get compareWeights {
    final majorNumber = StringBuffer();
    int addedValue = 0;
    bool isMajorCompleted = false;
    for (int i = 0; i < title.length; i++) {
      final char = title[i];
      if (!isMajorCompleted && char.isDigit) {
        majorNumber.write(char);
      } else {
        isMajorCompleted = true;
        addedValue += title.codeUnitAt(i);
      }
    }
    return [int.parse(majorNumber.toString()), addedValue];
  }
}
