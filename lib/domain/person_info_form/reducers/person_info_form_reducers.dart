import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/models/payment_way.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:redux/redux.dart';

final personalInfoReducer = combineReducers<PersonalInfo>([
  TypedReducer<PersonalInfo, SelectStreetAction>(_setSelectedStreet),
  TypedReducer<PersonalInfo, SelectHouseAction>(_setSelectedHouse),
  TypedReducer<PersonalInfo, NameChangedAction>(nameChangedReducer),
  TypedReducer<PersonalInfo, PhoneChangedAction>(phoneChangedReducer),
  TypedReducer<PersonalInfo, StreetChangedAction>(streetChangedReducer),
  TypedReducer<PersonalInfo, HouseChangedAction>(houseChangedReducer),
  TypedReducer<PersonalInfo, FlatChangedAction>(flatChangedReducer),
  TypedReducer<PersonalInfo, EntranceChangedAction>(entranceChangedReducer),
  TypedReducer<PersonalInfo, FloorChangedAction>(floorChangedReducer),
  TypedReducer<PersonalInfo, IntercomChangedAction>(intercomChangedReducer),
  TypedReducer<PersonalInfo, CommentChangedAction>(commentChangedReducer),
  TypedReducer<PersonalInfo, PaymentWayChangedAction>(paymentWayChangeReducer),
  TypedReducer<PersonalInfo, PaymentWayChangedAction>(clearRentingReducer),
  TypedReducer<PersonalInfo, RentingChangedAction>(rentingChangedReducer),
]);

PersonalInfo _setSelectedStreet(PersonalInfo info, SelectStreetAction action) {
  return info.copyWith(
    street: action.street.title,
    streetId: action.street.id,
    house: '',
    houseId: 0,
  );
}

PersonalInfo _setSelectedHouse(PersonalInfo info, SelectHouseAction action) {
  return info.copyWith(
    house: action.house.title,
    houseId: action.house.id,
  );
}

PersonalInfo nameChangedReducer(PersonalInfo state, NameChangedAction action) {
  return state.copyWith(
    name: action.text,
  );
}

PersonalInfo phoneChangedReducer(PersonalInfo state, PhoneChangedAction action) {
  return state.copyWith(
    phone: action.text,
  );
}

PersonalInfo streetChangedReducer(PersonalInfo state, StreetChangedAction action) {
  return state.copyWith(
    street: action.text,
  );
}

PersonalInfo houseChangedReducer(PersonalInfo state, HouseChangedAction action) {
  return state.copyWith(
    house: action.text,
  );
}

PersonalInfo flatChangedReducer(PersonalInfo state, FlatChangedAction action) {
  return state.copyWith(
    flat: action.text,
  );
}

PersonalInfo entranceChangedReducer(PersonalInfo state, EntranceChangedAction action) {
  return state.copyWith(
    entrance: action.text,
  );
}

PersonalInfo floorChangedReducer(PersonalInfo state, FloorChangedAction action) {
  return state.copyWith(
    floor: action.text,
  );
}

PersonalInfo intercomChangedReducer(PersonalInfo state, IntercomChangedAction action) {
  return state.copyWith(
    intercom: action.text,
  );
}

PersonalInfo commentChangedReducer(PersonalInfo state, CommentChangedAction action) {
  return state.copyWith(
    comment: action.text,
  );
}

PersonalInfo paymentWayChangeReducer(PersonalInfo state, PaymentWayChangedAction action) {
  return state.copyWith(
    paymentWay: action.paymentWay,
  );
}

PersonalInfo clearRentingReducer(PersonalInfo state, PaymentWayChangedAction action) {
  return action.paymentWay != PaymentWay.cash
      ? state.copyWith(
          renting: '',
        )
      : state;
}

PersonalInfo rentingChangedReducer(PersonalInfo state, RentingChangedAction action) {
  return state.copyWith(
    renting: action.text,
  );
}
