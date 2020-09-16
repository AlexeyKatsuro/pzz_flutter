import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/house.dart';
import 'package:pzz/models/street.dart';
import 'package:redux/redux.dart';

final suggestedStreetsReducer = combineReducers<List<Street>>([
  TypedReducer<List<Street>, SearchStreetResultAction>(_setSuggestedStreets),
]);

final suggestedHousesReducer = combineReducers<List<House>>([
  TypedReducer<List<House>, LoadedHouseAction>(_setSuggestedHouses),
]);

List<Street> _setSuggestedStreets(List<Street> streets, SearchStreetResultAction action) {
  return action.streets;
}

List<House> _setSuggestedHouses(List<House> streets, LoadedHouseAction action) {
  return action.houses;
}
