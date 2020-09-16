import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/personal_info.dart';
import 'package:redux/redux.dart';

final personalInfoReducer = combineReducers<PersonalInfo>([
  TypedReducer<PersonalInfo, SavePersonalInfoAction>(_setPersonalInfo),
  TypedReducer<PersonalInfo, SelectStreetAction>(_setSelectedStreet),
]);

PersonalInfo _setPersonalInfo(PersonalInfo info, SavePersonalInfoAction action) {
  return action.info;
}

PersonalInfo _setSelectedStreet(PersonalInfo info, SelectStreetAction action) {
  return info.copyWith(
    street: action.street.title,
    streetId: action.street.id,
    house: '',
    houseId: 0,
  );
}
