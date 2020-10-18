import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/models/person_info/person_info_errors.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/personal_info_state.dart';
import 'package:pzz/res/strings.dart';
import 'package:redux/redux.dart';

PersonalInfoState validateFormReducer(PersonalInfoState state, TryPlaceOrderAction action) {
  return state.copyWith(formInfoErrors: _validator(state));
}

PersonalInfoErrors _validator(PersonalInfoState state) {
  return state.formInfoErrors.copyWith(
    phone: _validatePhone(state.formInfo),
    paymentWay: _validatePaymentWay(state.formInfo),
    street: _validateStreet(state.formInfo),
    house: _validateHouse(state.formInfo),
  );
}

String _validatePhone(PersonalInfo personalInfo) {
  return personalInfo.phone.isEmpty ? StringRes.error_empty_phone : '';
}

String _validatePaymentWay(PersonalInfo personalInfo) {
  return personalInfo.paymentWay == null ? StringRes.error_empty_payment_pay : '';
}

String _validateStreet(PersonalInfo personalInfo) {
  return personalInfo.street.isEmpty ? StringRes.error_empty_street : '';
}

String _validateHouse(PersonalInfo personalInfo) {
  return personalInfo.house.isEmpty ? StringRes.error_empty_home : '';
}

final clearPersonalInfoErrorsReducer = combineReducers<PersonalInfoErrors>([
  TypedReducer<PersonalInfoErrors, SelectStreetAction>(_clearStreetErrorReducer),
  TypedReducer<PersonalInfoErrors, SelectHouseAction>(_clearHouseErrorReducer),
  TypedReducer<PersonalInfoErrors, PhoneChangedAction>(_clearPhoneErrorReducer),
  TypedReducer<PersonalInfoErrors, PaymentWayChangedAction>(_clearPaymentWayErrorReducer),
]);

PersonalInfoErrors _clearStreetErrorReducer(PersonalInfoErrors state, SelectStreetAction action) {
  return state.copyWith(street: '');
}

PersonalInfoErrors _clearHouseErrorReducer(PersonalInfoErrors state, SelectHouseAction action) {
  return state.copyWith(house: '');
}

PersonalInfoErrors _clearPhoneErrorReducer(PersonalInfoErrors state, PhoneChangedAction action) {
  return state.copyWith(phone: '');
}

PersonalInfoErrors _clearPaymentWayErrorReducer(PersonalInfoErrors state, PaymentWayChangedAction action) {
  return state.copyWith(paymentWay: '');
}
