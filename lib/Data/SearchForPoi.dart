import 'package:amap_map/amap_map.dart';
import 'package:mapapp/Data/Markers.dart';

List<Marker> findMarkersByTitle(String title) {
  var markers = MarkersInSchool().markersInSchool;
  return markers
      .where((marker) => marker.infoWindow.title!.contains(title))
      .toList();
}

List<String?> extractMarkerTitles(List<Marker> markers) {
  return markers.map((marker) => marker.infoWindow.title).toList();
}
