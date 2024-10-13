import 'package:amap_map/amap_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:x_amap_base/x_amap_base.dart';

import '../Data/Markers.dart';

class ShowMapPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowMapPageState();
}

class _ShowMapPageState extends State<ShowMapPageBody> {
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(30.51279, 114.413487),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      onLocationChanged: onLocationChanged,
      markers: MarkersInSchool().markersInSchool,
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

  late AMapLocation _aMapLocation;

  void onLocationChanged(AMapLocation location) {
    setState(() {
      _aMapLocation = location;
    });
  }
}
