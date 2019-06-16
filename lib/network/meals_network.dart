import 'package:http/http.dart' as http;
import 'package:meals_catalogue/data/meals_data_mapper.dart';

const String _BASE_URL = "https://www.themealdb.com/api/json/v1/1/";
const ENDPOINT_FILTER = "filter.php?c=";
const ENDPOINT_LOCKUP = "lookup.php?i=";
const ENDPOINT_SEARCH = "search.php?s=";

dynamic httpRequest(String endpoint) async {
  try {
    return await http
        .get("$_BASE_URL$endpoint")
        .then((response) => generateResponse(response))
        .then((json) => generateList(json));
  } catch (e) {
    return [];
  }
}