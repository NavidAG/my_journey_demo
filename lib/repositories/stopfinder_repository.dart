import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_journey/models/location.dart';

class StopfinderRepository {
  static List<Location> locations = [];
  static findStops(String searchTerm) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            "https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?anguage=de&outputFormat=RapidJSON&type_sf=any&name_sf={$searchTerm}"),
      );
      locations.clear();
      locations.addAll(((jsonDecode(response.body)["locations"] as List)
          .map((e) => Location.fromJson(e))
          .toList()));
    } catch (e) {
      print(e);
    }
    return locations;
  }
}
