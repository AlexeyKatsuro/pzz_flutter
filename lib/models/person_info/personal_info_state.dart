import 'package:flutter/cupertino.dart';
import 'package:pzz/models/person_info/person_info_errors.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/street.dart';

import 'house.dart';

@immutable
class PersonalInfoState {
  const PersonalInfoState({
    @required this.suggestedStreets,
    @required this.totalHouses,
    @required this.suggestedHouses,
    @required this.formInfo,
    @required this.formInfoErrors,
  });

  const PersonalInfoState.initial({
    this.suggestedStreets = const [],
    this.totalHouses = const [],
    this.suggestedHouses = const [],
    this.formInfo = const PersonalInfo(),
    this.formInfoErrors = const PersonalInfoErrors(),
  });

  final List<Street> suggestedStreets;
  final List<House> totalHouses;
  final List<House> suggestedHouses;
  final PersonalInfo formInfo;
  final PersonalInfoErrors formInfoErrors;

  PersonalInfoState copyWith({
    List<Street> suggestedStreets,
    List<House> totalHouses,
    List<House> suggestedHouses,
    PersonalInfo formInfo,
    PersonalInfoErrors formInfoErrors,
  }) {
    return PersonalInfoState(
      suggestedStreets: suggestedStreets ?? this.suggestedStreets,
      totalHouses: totalHouses ?? this.totalHouses,
      suggestedHouses: suggestedHouses ?? this.suggestedHouses,
      formInfo: formInfo ?? this.formInfo,
      formInfoErrors: formInfoErrors ?? this.formInfoErrors,
    );
  }
}
