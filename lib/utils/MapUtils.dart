import 'dart:ffi';

import 'package:amap_map/amap_map.dart';
import 'package:mapapp/Data/markers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void changeMarker(Marker selectedMarker) {}

Future<void> changeMarkerToVisited(Marker selectedMarker) async {
  final prefs = await SharedPreferences.getInstance();
  var list = prefs.getStringList("Markers")!;
  var markersList = MarkersInSchool().markersInSchool.toList();
  var position = markersList.indexOf(selectedMarker);
  await prefs.setBool(key, true);
}

Future<void> initMarkerData() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("Markers")) {
    return prefs.getStringList("Markers");
  }
  else {

    return List<Bool> = List<Bool>(0)
  }
}

void changewang


