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

  //
  @override
  Widget build(BuildContext context) {
    _checkPermissions();
    AMapInitializer.init(context, apiKey: ConstConfig.amapApiKeys);
    AMapInitializer.updatePrivacyAgree(ConstConfig.amapPrivacyStatement);
    return const Surface();
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
        page = _ShowMapPageBody();
        break;
      case 1:
        page = const SearchPage();
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

class _ShowMapPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowMapPageState();
}

class _ShowMapPageState extends State<_ShowMapPageBody> {
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(30.51279, 114.413487),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      mapType: MapType.satellite,
      compassEnabled: true,
      labelsEnabled: false,
      initialCameraPosition: _kInitialPosition,
      onMapCreated: onMapCreated,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: map,
      ),
    );
  }

  late AMapController _mapController;

  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
}
