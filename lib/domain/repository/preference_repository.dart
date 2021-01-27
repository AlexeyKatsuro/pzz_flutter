import 'package:pzz/models/person_info/personal_info.dart';

abstract class PreferenceRepository {
  PersonalInfo? getPersonalInfo();

  void savePersonalInfo(PersonalInfo info);
}
