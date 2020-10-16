import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
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
          RaisedButton(
            elevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            color: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onPrimary,
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
