import 'dart:developer';

import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:mapapp/const_config.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Page/SearchPage.dart';
import 'Page/ShowMapPage.dart';

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
    return const Surface();
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

class Surface extends StatefulWidget {
  const Surface({super.key});

  @override
  _SurfaceWidgetState createState() => _SurfaceWidgetState();
}

class _SurfaceWidgetState extends State<Surface> {
  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedPage) {
      case 0:
        page = ShowMapPageBody();
        break;
      case 1:
        page = SearchPage();
        break;
      default:
        throw UnimplementedError('no page');
    }
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("高德地图演示"),
      ),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (int index) {
          setState(() {
            selectedPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    ));
  }
}
