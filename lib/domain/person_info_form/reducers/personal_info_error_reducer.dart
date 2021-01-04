import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/l10n/app_localization_keys.dart';
import 'package:pzz/models/person_info/person_info_errors.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/personal_info_state.dart';
import 'package:pzz/utils/UiMessage.dart';
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

UiMessage _validatePhone(PersonalInfo personalInfo) {
  return personalInfo.phone.isEmpty ? UiMessage.key(AppLocalizationKeys.errorEmptyPhone) : UiMessage.empty();
}

UiMessage _validatePaymentWay(PersonalInfo personalInfo) {
  return personalInfo.paymentWay == null
      ? const UiMessage.key(AppLocalizationKeys.errorEmptyPaymentPay)
      : const UiMessage.empty();
}

UiMessage _validateStreet(PersonalInfo personalInfo) {
  return personalInfo.street.isEmpty
      ? const UiMessage.key(AppLocalizationKeys.errorEmptyStreet)
      : const UiMessage.empty();
}

UiMessage _validateHouse(PersonalInfo personalInfo) {
  return personalInfo.house.isEmpty ? const UiMessage.key(AppLocalizationKeys.errorEmptyHome) : const UiMessage.empty();
}

final clearPersonalInfoErrorsReducer = combineReducers<PersonalInfoErrors>([
  TypedReducer<PersonalInfoErrors, SelectStreetAction>(_clearStreetErrorReducer),
  TypedReducer<PersonalInfoErrors, SelectHouseAction>(_clearHouseErrorReducer),
  TypedReducer<PersonalInfoErrors, PhoneChangedAction>(_clearPhoneErrorReducer),
  TypedReducer<PersonalInfoErrors, PaymentWayChangedAction>(_clearPaymentWayErrorReducer),
]);

PersonalInfoErrors _clearStreetErrorReducer(PersonalInfoErrors state, SelectStreetAction action) {
  return state.copyWith(street: const UiMessage.empty());
}

PersonalInfoErrors _clearHouseErrorReducer(PersonalInfoErrors state, SelectHouseAction action) {
  return state.copyWith(house: const UiMessage.empty());
}

PersonalInfoErrors _clearPhoneErrorReducer(PersonalInfoErrors state, PhoneChangedAction action) {
  return state.copyWith(phone: const UiMessage.empty());
}

PersonalInfoErrors _clearPaymentWayErrorReducer(PersonalInfoErrors state, PaymentWayChangedAction action) {
  return state.copyWith(paymentWay: const UiMessage.empty());
}
