import 'package:amap_map/amap_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:x_amap_base/x_amap_base.dart';

import '../Data/markers.dart';

class ShowMapPageBody extends StatefulWidget {
  final LatLng position;
  final MapType mapType;
  final bool showLabels;

  const ShowMapPageBody(
      {super.key,
      required this.position,
      required this.mapType,
      required this.showLabels});

  @override
  State<StatefulWidget> createState() => _ShowMapPageState();
}

class _ShowMapPageState extends State<ShowMapPageBody> {
  @override
  Widget build(BuildContext context) {
    //initMarkerData();
    // can not use now
    final AMapWidget map = AMapWidget(
      // limitBounds: LatLngBounds(
      //     southwest: const LatLng(30.505633, 114.401235),
      //     northeast: const LatLng(30.519878, 114.441127)),
      //     make it stupid
      onLocationChanged: onLocationChanged,
      markers: MarkersInSchool().markersInSchool,
      mapType: widget.mapType,
      compassEnabled: true,
      labelsEnabled: widget.showLabels,
      initialCameraPosition:
          CameraPosition(target: widget.position, zoom: 17.0),
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

  late AMapController mapController;

  void onMapCreated(AMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  late AMapLocation aMapLocation;

  void onLocationChanged(AMapLocation location) {
    setState(() {
      aMapLocation = location;
    });
  }
}
