import 'package:amap_map/amap_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'searchPage.dart';
import 'showMapPage.dart';

class MapApp extends StatefulWidget {
  final int? page;

  const MapApp({super.key, this.page});

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    Marker? selectedMarker;
    Widget showPage;
    switch (selectedPage) {
      case 0:
        showPage = ShowMapPageBody();
        break;
      case 1:
        showPage = SearchPage(
          onTap: (marker) {
            selectedMarker = marker;
            selectedPage = 0;
          },
        );
        break;
      default:
        throw UnimplementedError('no page');
    }
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("高德地图演示"),
      ),
      body: showPage,
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
