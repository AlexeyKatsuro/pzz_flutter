import 'package:pzz/models/personal_info.dart';

abstract class PreferenceRepository {
  PersonalInfo getPersonalInfo();

  void savePersonalInfo(PersonalInfo info);
}
