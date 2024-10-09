import 'dart:developer';

import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:mapapp/const_config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:x_amap_base/x_amap_base.dart';

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
    _checkPermissions();
    AMapInitializer.init(context, apiKey: ConstConfig.amapApiKeys);
    AMapInitializer.updatePrivacyAgree(ConstConfig.amapPrivacyStatement);
    return Surface();
  }

  void _checkPermissions() async {
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
        page = const ShowMapPage();
        break;
      case 1:
        page = SearchPage();
        break;
      default:
        throw UnimplementedError('no page');
    }
    return Scaffold(
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
    );
  }
}

class ShowMapPage extends StatelessWidget {
  const ShowMapPage({super.key});

  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(39.909187, 116.397451),
    zoom: 10.0,
  );
  final AMapWidget map = const AMapWidget(
    initialCameraPosition: _kInitialPosition,
    onMapCreated: onMapCreated,
  );

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: map,
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
