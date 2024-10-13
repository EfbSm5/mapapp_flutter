import 'package:amap_map/amap_map.dart';

List<Marker> findMarkersByTitle(Set<Marker> markers, String title) {
  return markers
      .where((marker) => marker.infoWindow.title!.contains(title))
      .toList();
}

List<String?> extractMarkerTitles(List<Marker> markers) {
  return markers.map((marker) => marker.infoWindow.title).toList();
}
