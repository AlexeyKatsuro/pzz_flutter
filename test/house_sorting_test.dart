// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/utils/house_comparator.dart';

void main() {
  final house3A = const House(id: 0, title: '1');
  final house3B = House(id: 3, title: '3B');
  final house14 = const House(id: 4, title: '14');
  final house101 = const House(id: 8, title: '101');
  group('Single compare houses', () {
    test("'14' should be higher than '3A", () {
      expect(compareHouse(house14, house3A), 1);
    });
    test("'3B' should be higher than '3A", () {
      expect(compareHouse(house3B, house3A), 1);
    });
    test("'14' should be lower than '101", () {
      expect(compareHouse(house14, house101), -1);
    });
  });

  group('Test order of sorted  house list', () {
    final houses = [
      const House(id: 0, title: '1'),
      const House(id: 2, title: '3A'),
      const House(id: 1, title: '2'),
      const House(id: 7, title: '100/A'),
      const House(id: 3, title: '3B'),
      const House(id: 6, title: '14/2'),
      const House(id: 9, title: '101/B'),
      const House(id: 5, title: '14/1'),
      const House(id: 4, title: '14'),
      const House(id: 8, title: '101'),
    ];

    final housesSortedMatcher = [
      const House(id: 0, title: '1'),
      const House(id: 1, title: '2'),
      const House(id: 2, title: '3A'),
      const House(id: 3, title: '3B'),
      const House(id: 4, title: '14'),
      const House(id: 5, title: '14/1'),
      const House(id: 6, title: '14/2'),
      const House(id: 7, title: '100/A'),
      const House(id: 8, title: '101'),
      const House(id: 9, title: '101/B'),
    ];

    final houseSorted = houses..sort(compareHouse);

    Function stringify = (List<House> houses) => houses.map((e) => e.title).join(', ');
    test('Test sorting by compareWeight prop ', () {
      expect(stringify(houseSorted), stringify(housesSortedMatcher));
    });
  });
}
