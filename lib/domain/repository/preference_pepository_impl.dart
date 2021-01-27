import 'dart:convert';

import 'package:pzz/domain/repository/preference_repository.dart';
import 'package:pzz/models/dto/peronal_info_dto.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceRepositoryImpl extends PreferenceRepository {
  PreferenceRepositoryImpl(this._preferences);

  static const KEY_PERSONAL_INFO = 'key_personal_info';

  final SharedPreferences _preferences;

  @override
  PersonalInfo? getPersonalInfo() {
    final source = _preferences.getString(KEY_PERSONAL_INFO)!;
    // ignore: unnecessary_null_comparison
    if (source == null) return null;
    final json = jsonDecode(source) as Map<String, dynamic>;
    final PersonalInfoDto dto = PersonalInfoDto.fromJson(json);
    return dto.toModel();
  }

  @override
  void savePersonalInfo(PersonalInfo info) {
    final PersonalInfoDto dto = PersonalInfoDto.fromModel(info);
    final json = jsonEncode(dto.toJson());
    _preferences.setString(KEY_PERSONAL_INFO, json);
  }
}
