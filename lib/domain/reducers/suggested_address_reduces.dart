import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/house.dart';
import 'package:pzz/models/street.dart';
import 'package:redux/redux.dart';

final suggestedStreetsReducer = combineReducers<List<Street>>([
  TypedReducer<List<Street>, SearchStreetResultAction>(_setSuggestedStreets),
]);

final totalHousesReducer = combineReducers<List<House>>([
  TypedReducer<List<House>, LoadedHouseAction>(_setTotalHouses),
]);

final suggestedHousesReducer = combineReducers<List<House>>([
  TypedReducer<List<House>, PerformHouseSearchAction>(_setSuggestedHouses),
]);

List<Street> _setSuggestedStreets(List<Street> streets, SearchStreetResultAction action) {
  return action.streets;
}

List<House> _setTotalHouses(List<House> houses, LoadedHouseAction action) {
  return action.houses;
}

List<House> _setSuggestedHouses(List<House> totalHouses, PerformHouseSearchAction action) {
  if (action.query == null || action.query.isEmpty) return totalHouses;
  return totalHouses.where((element) => element.title.contains(action.query)).toList(growable: false);
}
