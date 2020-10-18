import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/ui/widgets/personal_info_form.dart';

class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringRes.delivery_address),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        children: [
          PersonalInfoFormContainer(),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final store = StoreProvider.of<AppState>(context);
              store.dispatch(SavePersonalInfoAction(personalInfoSelector(store.state)));
              Navigator.of(context).pop();
            },
            child: Text(StringRes.save),
          )
        ],
      ),
    );
  }
}
