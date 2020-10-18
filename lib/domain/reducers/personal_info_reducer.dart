import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/domain/person_info_form/reducers/person_info_form_reducers.dart';
import 'package:pzz/domain/person_info_form/reducers/personal_info_error_reducer.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/personal_info_state.dart';
import 'package:redux/redux.dart';

final personalInfoStateReducer = combineReducers<PersonalInfoState>([
  TypedReducer<PersonalInfoState, SearchStreetResultAction>(_setSuggestedStreets),
  TypedReducer<PersonalInfoState, LoadedHouseAction>(_setTotalHouses),
  TypedReducer<PersonalInfoState, PerformHouseSearchAction>(_setSuggestedHouses),
  TypedReducer<PersonalInfoState, SavePersonalInfoAction>(_setPersonalInfo),
  _fromInfoReducer,
  TypedReducer<PersonalInfoState, TryPlaceOrderAction>(validateFormReducer),
  _clearErrorReducer,
]);

PersonalInfoState _fromInfoReducer(PersonalInfoState state, dynamic action) {
  return state.copyWith(formInfo: personalInfoReducer(state.formInfo, action));
}

PersonalInfoState _clearErrorReducer(PersonalInfoState state, dynamic action) {
  return state.copyWith(formInfoErrors: clearPersonalInfoErrorsReducer(state.formInfoErrors, action));
}

PersonalInfoState _setPersonalInfo(PersonalInfoState state, SavePersonalInfoAction action) {
  return state.copyWith(formInfo: action.info);
}

PersonalInfoState _setSuggestedStreets(PersonalInfoState state, SearchStreetResultAction action) {
  return state.copyWith(suggestedStreets: action.streets);
}

PersonalInfoState _setTotalHouses(PersonalInfoState state, LoadedHouseAction action) {
  return state.copyWith(totalHouses: action.houses);
}

PersonalInfoState _setSuggestedHouses(PersonalInfoState state, PerformHouseSearchAction action) {
  List<House> suggestedHouses;
  if (action.query == null || action.query.isEmpty) {
    suggestedHouses = state.totalHouses;
  }
  suggestedHouses = state.totalHouses.where((element) => element.title.contains(action.query)).toList(growable: false);
  return state.copyWith(suggestedHouses: suggestedHouses);
}
