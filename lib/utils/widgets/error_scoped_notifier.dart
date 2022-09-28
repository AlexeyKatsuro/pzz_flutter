import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/error/scoped_error_actions.dart';
import 'package:pzz/domain/error/scoped_error_hub_selectors.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/utils/ui_message.dart';
import 'package:redux/redux.dart';

typedef ErrorEventBuilder = void Function(BuildContext context, String error);

/// Widget that will be display errors for specific [scope].
/// As soon as an error message appears in a specific [scope], this widget show error by calling
/// of passed [errorBuilder], and then clear error message in state for [scope] automatically.
///
/// By default [errorBuilder] show SnackBar or AlertDialog if there no [Scaffold] in [BuildContext].
///
/// Also error message can be assigned for scope whose page is not yet on the screen and error will appeared
/// as soon as this widget is on the screen, if you wouldn't like that pass [showErrorOnInit] as `false`.
class ErrorScopedNotifier extends StatelessWidget {
  const ErrorScopedNotifier(
    this.scope, {
    required this.child,
    this.errorBuilder = snackBarErrorHandler,
    this.showErrorOnInit = true,
  });

  final String scope;
  final Widget child;
  final ErrorEventBuilder errorBuilder;
  final bool showErrorOnInit;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store, scope),
      onInitialBuild: (viewModel) {
        final isTopPage = ModalRoute.of(context)!.isCurrent;
        if (isTopPage && viewModel.errorScoped != null) {
          if (showErrorOnInit) {
            errorBuilder(context, viewModel.errorScoped!.localize(localizations));
          }
          viewModel.clearError();
        }
      },
      onWillChange: (_, viewModel) {
        final isTopPage = ModalRoute.of(context)!.isCurrent;
        if (isTopPage && viewModel.errorScoped != null) {
          errorBuilder(context, viewModel.errorScoped!.localize(localizations));
          viewModel.clearError();
        }
      },
      builder: (BuildContext context, _ViewModel viewModel) {
        return child;
      },
      distinct: true,
    );
  }

  static void snackBarErrorHandler(BuildContext context, String errorMessage) {
    final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
    if (scaffoldMessenger != null) {
      scaffoldMessenger.removeCurrentSnackBar(reason: SnackBarClosedReason.hide);
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text(errorMessage), behavior: SnackBarBehavior.floating));
    } else {
      alertErrorHandler(context, errorMessage);
    }
  }

  static void alertErrorHandler(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error occurred'), // TODO Use translates
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              // close dialog
              Navigator.pop(context);
            },
            child: const Text('ok'), // TODO Use translates
          )
        ],
      ),
    );
  }
}

class _ViewModel {
  _ViewModel({
    required this.clearError,
    required this.errorScoped,
  });

  factory _ViewModel.fromStore(Store<AppState> store, String scope) {
    final errorScoped = getScopedErrorSelector(store.state, scope);
    return _ViewModel(
      clearError: () => store.dispatch(ClearScopedErrorAction(scope: scope)),
      errorScoped: errorScoped,
    );
  }

  final VoidCallback clearError;

  // nullable
  final UiMessage? errorScoped;
}
