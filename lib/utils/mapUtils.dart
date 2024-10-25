import 'dart:developer';

import 'package:amap_map/amap_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapapp/Data/markers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const_config.dart';
import '../main.dart';

void changeMarker(Marker selectedMarker) {}

Future<void> changeMarkerToVisited(Marker selectedMarker) async {
  final dataInStorage = await SharedPreferences.getInstance();
  var list = dataInStorage.getStringList("Markers")!;
  list[MarkersInSchool().markersInSchool.toList().indexOf(selectedMarker)] =
      "true";
  await dataInStorage.setStringList("Markers", list);
}

Future<void> initMarkerData() async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey("Markers")) {
    final dataInStorage = await SharedPreferences.getInstance();
    List<String> initList = [];
    initList.fillRange(0, 25, "false");
    dataInStorage.setStringList("Markers", initList);
  }
}

MapType nextMapType(MapType mapTypeNow) {
  late MapType mapTypeNext;
  if (mapTypeNow == MapType.satellite) {
    mapTypeNext = MapType.normal;
  } else {
    mapTypeNext = MapType.satellite;
  }
  return mapTypeNext;
}

void deleteVisitedPoints() {
//TODO
}

void initMap(BuildContext context) {
  AMapInitializer.init(context, apiKey: ConstConfig.amapApiKeys);
  AMapInitializer.updatePrivacyAgree(ConstConfig.amapPrivacyStatement);
}

void checkPermissions() async {
  Map<Permission, PermissionStatus> statuses =
      await needPermissionList.request();
  statuses.forEach((key, value) {
    log('$key permissionStatus is $value');
  });
}
