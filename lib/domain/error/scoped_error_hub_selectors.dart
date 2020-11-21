// nullable
import 'package:pzz/models/app_state.dart';

String getScopedErrorSelector(AppState state, String scope) => state.scopedErrors.get(scope);
