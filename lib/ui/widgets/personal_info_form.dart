import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/street.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/ui/search_page.dart';
import 'package:redux/redux.dart';
import 'package:pzz/utils/extensions/text_form_field_ext.dart';

class PersonalInfoFormContainer extends StatelessWidget {
  const PersonalInfoFormContainer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel.formStore(store);
      },
      builder: _build,
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return PersonalInfoForm(
      personalInfo: vm.personalInfo,
      isHomeSelectionAllow: vm.isHomeSelectionAllow,
      onNameChange: vm.onNameChange,
      onPhoneChange: vm.onPhoneChange,
      onStreetChange: vm.onStreetChange,
      onHouseChange: vm.onHouseChange,
      onFlatChange: vm.onFlatChange,
      onEntranceChange: vm.onEntranceChange,
      onFloorChange: vm.onFloorChange,
      onIntercomChange: vm.onIntercomChange,
      onCommentChange: vm.onCommentChange,
    );
  }
}

class _ViewModel {
  _ViewModel({
    @required this.personalInfo,
    @required this.isHomeSelectionAllow,
    @required this.onNameChange,
    @required this.onPhoneChange,
    @required this.onStreetChange,
    @required this.onHouseChange,
    @required this.onFlatChange,
    @required this.onEntranceChange,
    @required this.onFloorChange,
    @required this.onIntercomChange,
    @required this.onCommentChange,
  });

  final PersonalInfo personalInfo;
  final bool isHomeSelectionAllow;
  final ValueChanged<String> onNameChange;
  final ValueChanged<String> onPhoneChange;
  final ValueChanged<String> onStreetChange;
  final ValueChanged<String> onHouseChange;
  final ValueChanged<String> onFlatChange;
  final ValueChanged<String> onEntranceChange;
  final ValueChanged<String> onFloorChange;
  final ValueChanged<String> onIntercomChange;
  final ValueChanged<String> onCommentChange;

  factory _ViewModel.formStore(Store<AppState> store) {
    return _ViewModel(
      personalInfo: personalInfoSelector(store.state),
      isHomeSelectionAllow: isHomeSelectionAllowSelector(store.state),
      onNameChange: (text) => store.dispatch(NameChangedAction(text)),
      onPhoneChange: (text) => store.dispatch(PhoneChangedAction(text)),
      onStreetChange: (text) => store.dispatch(StreetChangedAction(text)),
      onHouseChange: (text) => store.dispatch(HouseChangedAction(text)),
      onFlatChange: (text) => store.dispatch(FlatChangedAction(text)),
      onEntranceChange: (text) => store.dispatch(EntranceChangedAction(text)),
      onFloorChange: (text) => store.dispatch(FloorChangedAction(text)),
      onIntercomChange: (text) => store.dispatch(IntercomChangedAction(text)),
      onCommentChange: (text) => store.dispatch(CommentChangedAction(text)),
    );
  }
}

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({
    @required this.personalInfo,
    @required this.isHomeSelectionAllow,
    @required this.onNameChange,
    @required this.onPhoneChange,
    @required this.onStreetChange,
    @required this.onHouseChange,
    @required this.onFlatChange,
    @required this.onEntranceChange,
    @required this.onFloorChange,
    @required this.onIntercomChange,
    @required this.onCommentChange,
  });

  final PersonalInfo personalInfo;
  final bool isHomeSelectionAllow;
  final ValueChanged<String> onNameChange;
  final ValueChanged<String> onPhoneChange;
  final ValueChanged<String> onStreetChange;
  final ValueChanged<String> onHouseChange;
  final ValueChanged<String> onFlatChange;
  final ValueChanged<String> onEntranceChange;
  final ValueChanged<String> onFloorChange;
  final ValueChanged<String> onIntercomChange;
  final ValueChanged<String> onCommentChange;

  @override
  _PersonalInfoFormState createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final houseController = TextEditingController();
  final flatController = TextEditingController();
  final entranceController = TextEditingController();
  final floorController = TextEditingController();
  final intercomController = TextEditingController();
  final commentController = TextEditingController();

  List<TextEditingController> get controllers => [
        nameController,
        phoneController,
        streetController,
        houseController,
        flatController,
        entranceController,
        floorController,
        intercomController,
        commentController,
      ];

  @override
  void dispose() {
    controllers.forEach((element) => element.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nameController.setTextIfNew(widget.personalInfo.name);
    phoneController.setTextIfNew(widget.personalInfo.phone);
    streetController.setTextIfNew(widget.personalInfo.street);
    houseController.setTextIfNew(widget.personalInfo.house);
    flatController.setTextIfNew(widget.personalInfo.flat);
    entranceController.setTextIfNew(widget.personalInfo.entrance);
    floorController.setTextIfNew(widget.personalInfo.floor);
    intercomController.setTextIfNew(widget.personalInfo.intercom);
    commentController.setTextIfNew(widget.personalInfo.comment);
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: StringRes.your_name),
          controller: nameController,
          onChanged: widget.onNameChange,
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: InputDecoration(labelText: StringRes.your_phone_number),
          controller: phoneController,
          keyboardType: TextInputType.phone,
          onChanged: widget.onPhoneChange,
        ),
        const SizedBox(height: 12),
        TextFormField(
          enableInteractiveSelection: false,
          // will disable paste operation
          focusNode: AlwaysDisabledFocusNode(),
          onChanged: widget.onStreetChange,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SearchStreetPage<Street>(
                    createPerformSearchAction: (query) => PerformStreetSearchAction(query),
                    createSelectItemAction: (item) => SelectStreetAction(item),
                    itemsSelector: suggestedStreetsSelector,
                    itemToString: (item) => item.title,
                    prefill: widget.personalInfo.street,
                  );
                },
              ),
            );
          },
          decoration: InputDecoration(
            labelText: StringRes.street,
            suffixIcon: Icon(Icons.search),
          ),
          controller: streetController,
        ),
        const SizedBox(height: 12),
        TextFormField(
          enableInteractiveSelection: false,
          // will disable paste operation
          focusNode: new AlwaysDisabledFocusNode(),
          onChanged: widget.onHouseChange,
          decoration: InputDecoration(
            labelText: StringRes.house,
            suffixIcon: Icon(Icons.keyboard_arrow_down),
          ),
          enabled: widget.isHomeSelectionAllow,
          controller: houseController,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SearchStreetPage<House>(
                    createPerformSearchAction: (query) => PerformHouseSearchAction(query),
                    createSelectItemAction: (item) => SelectHouseAction(item),
                    itemsSelector: suggestedHousesSelector,
                    itemToString: (item) => item.title,
                    prefill: widget.personalInfo.house,
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: StringRes.flat),
                controller: flatController,
                onChanged: widget.onFlatChange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: StringRes.entrance),
                controller: entranceController,
                onChanged: widget.onEntranceChange,
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: StringRes.floor),
                controller: floorController,
                onChanged: widget.onFloorChange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: StringRes.intercom),
                controller: intercomController,
                onChanged: widget.onIntercomChange,
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          minLines: 1,
          maxLines: 3,
          decoration: InputDecoration(labelText: StringRes.comments_to_order),
          controller: commentController,
          onChanged: widget.onCommentChange,
        ),
      ],
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
