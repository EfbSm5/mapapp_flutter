import 'dart:async';
import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AMapFlutterLocation flutterLocation = AMapFlutterLocation();
  final AMapLocationOption aMapLocationOption = AMapLocationOption(
    needAddress: true,
    geoLanguage: GeoLanguage.DEFAULT,
    onceLocation: false,
    locationMode: AMapLocationMode.Hight_Accuracy,
    locationInterval: 2000,
    pausesLocationUpdatesAutomatically: false,
    desiredAccuracy: DesiredAccuracy.Best,
    desiredLocationAccuracyAuthorizationMode:
    AMapLocationAccuracyAuthorizationMode.FullAccuracy,
    distanceFilter: -1,
  );
  late final StreamSubscription<Map<String, Object>> subscription;
  late int count = 0;

  @override
  void initState() {
    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);
    requestPermission();
    AMapFlutterLocation.setApiKey(
      "e51a737b3742762791f3c89f4dc61e6d",
      "cb341ecb2fb63ff6965c62a009979f29",
    );
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }
    subscription = flutterLocation.onLocationChanged().listen((event) {
      print(event.toString());
    });

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    flutterLocation.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                flutterLocation.setLocationOption(aMapLocationOption);
                Timer.periodic(const Duration(seconds: 1), (timer) {
                  count++;
                  print("定位序列号$count");
                  flutterLocation.startLocation();
                });
              },
              child: Text("开始定位"),
            ),
            ElevatedButton(
              onPressed: () {
                flutterLocation.stopLocation();
              },
              child: Text("停止定位"),
            ),
          ],
        ),
      ),
    );
  }

  /// 动态申请定位权限
  void requestPermission() async {
    bool hasLocationWhenInUsePermission =
    await requestIosLocationWhenInUserPermission();
    if (hasLocationWhenInUsePermission) {
      bool hasLocationAlwaysWhenInUsePermission =
      await requestIosLocationAlwaysWhenInUserPermission();
      if (hasLocationAlwaysWhenInUsePermission) {
      } else {}
    } else {}
  }

  /// 申请定位权限
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> requestIosLocationPermission() async {
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> requestIosLocationWhenInUserPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> requestIosLocationAlwaysWhenInUserPermission() async {
    var status = await Permission.locationAlways.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      status = await Permission.locationAlways.request();
      print("Permission.locationAlways - $status");
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
    await flutterLocation.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }
}
