import 'dart:developer';

import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:mapapp/Page/mapApp.dart';
import 'package:mapapp/const_config.dart';
import 'package:permission_handler/permission_handler.dart';

final List<Permission> needPermissionList = [
  Permission.location,
  Permission.storage,
  Permission.phone,
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    checkPermissions();
    initMap(context);
    return const MapApp();
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
}
