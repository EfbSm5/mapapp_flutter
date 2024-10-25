import 'dart:developer';

import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:x_amap_base/x_amap_base.dart';

import '../utils/mapUtils.dart';
import 'searchPage.dart';
import 'showMapPage.dart';

class MapApp extends StatefulWidget {
  const MapApp({super.key});

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  var selectedPage = 0;
  LatLng position = const LatLng(30.51279, 114.413487);
  bool showLabels = false;
  MapType mapType = MapType.satellite;

  @override
  Widget build(BuildContext context) {
    Widget showPage;
    switch (selectedPage) {
      case 0:
        showPage = ShowMapPageBody(
          position: position,
          mapType: mapType,
          showLabels: showLabels,
        );
        break;
      case 1:
        showPage = SearchPage(
          onTap: (marker) {
            setState(() {
              position = marker.position;
              selectedPage = 0;
            });
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
          leading: Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu)))),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("settings")),
          ListTile(
            leading: const Icon(Icons.map),
            title: Text("MapType ${mapType.name}"),
            onTap: () {
              setState(() {
                mapType = nextMapType(mapType);
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.font_download),
            title: Text("labels ${showLabels ? 'true' : 'false'}"),
            onTap: () {
              setState(() {
                showLabels = !showLabels;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("delete all visited points"),
            onTap: () {
              setState(() {
              //TODO
              });
            },
          )
        ],
      )),
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
