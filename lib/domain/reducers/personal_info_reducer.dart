import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/personal_info.dart';
import 'package:redux/redux.dart';

final personalInfoReducer = combineReducers<PersonalInfo>([
  TypedReducer<PersonalInfo, SavePersonalInfoAction>(_setPersonalInfo),
]);

PersonalInfo _setPersonalInfo(PersonalInfo pizzas, SavePersonalInfoAction action) {
  return action.info;
}
