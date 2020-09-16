import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/personal_info.dart';
import 'package:pzz/models/street.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/routes.dart';
import 'package:redux/redux.dart';

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
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
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        final info = personalInfoSelector(store.state);
        nameController.text = info.name;
        phoneController.text = info.phone;
        streetController.text = info.street;
        houseController.text = info.house;
        flatController.text = info.flat;
        entranceController.text = info.entrance;
        floorController.text = info.floor;
        intercomController.text = info.intercom;
        commentController.text = info.comment;
      },
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return _build(context, vm);
      },
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    streetController.text = vm.street;
    houseController.text = vm.house;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringRes.delivery_address),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        physics: ScrollPhysics(),
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: StringRes.your_name),
            controller: nameController,
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: InputDecoration(labelText: StringRes.your_phone_number),
            controller: phoneController,
          ),
          const SizedBox(height: 12),
          TextFormField(
            enableInteractiveSelection: false,
            // will disable paste operation
            focusNode: new AlwaysDisabledFocusNode(),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.searchScreen);
            },
            decoration: InputDecoration(
              labelText: StringRes.street,
              suffixIcon: Icon(Icons.search),
            ),
            controller: streetController,
          ),
          const SizedBox(height: 12),
          TextFormField(
            enableInteractiveSelection: false, // will disable paste operation
            focusNode: new AlwaysDisabledFocusNode(),
            decoration: InputDecoration(
              labelText: StringRes.house,
              suffixIcon: Icon(Icons.keyboard_arrow_down),
            ),
            controller: houseController,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: StringRes.flat),
                  controller: flatController,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: StringRes.entrance),
                  controller: entranceController,
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
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: StringRes.intercom),
                  controller: intercomController,
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
          ),
          const SizedBox(height: 12),
          RaisedButton(
            elevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            color: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              final info = vm.personalInfo.copyWith(
                name: nameController.text,
                phone: phoneController.text,
                street: streetController.text,
                house: houseController.text,
                flat: flatController.text,
                entrance: entranceController.text,
                floor: floorController.text,
                intercom: intercomController.text,
                comment: commentController.text,
              );
              vm.onSaveClick(info);
              Navigator.of(context).pop();
            },
            child: Text(StringRes.save),
          )
        ],
      ),
    );
  }
}

class _ViewModel {
  final PersonalInfo personalInfo;
  final List<Street> suggestedStreets;
  final void Function(PersonalInfo info) onSaveClick;
  final void Function(String query) onPerformStreetSearch;

  String get street => personalInfo.street;

  String get house => personalInfo.house;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      suggestedStreets: suggestedStreetsSelector(store.state),
      personalInfo: personalInfoSelector(store.state),
      onSaveClick: (info) => store.dispatch(SavePersonalInfoAction(info)),
      onPerformStreetSearch: (query) => store.dispatch(PerformStreetSearchAction(query)),
    );
  }

  _ViewModel({
    @required this.suggestedStreets,
    @required this.onSaveClick,
    @required this.onPerformStreetSearch,
    @required this.personalInfo,
  });
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
