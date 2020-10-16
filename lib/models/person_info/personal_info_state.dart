import 'package:flutter/cupertino.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/street.dart';

import 'house.dart';

@immutable
class PersonalInfoState {
  const PersonalInfoState({
    this.suggestedStreets = const [],
    this.totalHouses = const [],
    this.suggestedHouses = const [],
    this.formInfo = const PersonalInfo(),
  });

  final List<Street> suggestedStreets;
  final List<House> totalHouses;
  final List<House> suggestedHouses;
  final PersonalInfo formInfo;

  PersonalInfoState copyWith({
    List<Street> suggestedStreets,
    List<House> totalHouses,
    List<House> suggestedHouses,
    PersonalInfo formInfo,
  }) {
    return PersonalInfoState(
      suggestedStreets: suggestedStreets ?? this.suggestedStreets,
      totalHouses: totalHouses ?? this.totalHouses,
      suggestedHouses: suggestedHouses ?? this.suggestedHouses,
      formInfo: formInfo ?? this.formInfo,
    );
  }
}
