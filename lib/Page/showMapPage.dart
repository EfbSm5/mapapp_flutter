import 'package:amap_map/amap_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:x_amap_base/x_amap_base.dart';

import '../Data/markers.dart';

class ShowMapPageBody extends StatefulWidget {
  final Marker? marker;

  const ShowMapPageBody({super.key, this.marker});

  @override
  State<StatefulWidget> createState() => _ShowMapPageState();
}

class _ShowMapPageState extends State<ShowMapPageBody> {
  late CameraPosition initPosition;

  @override
  Widget build(BuildContext context) {
    var selectedMarker = widget.marker;
    if (selectedMarker != null) {
      initPosition =
          CameraPosition(target: selectedMarker.position, zoom: 17.0);
    } else {
      initPosition = const CameraPosition(
        target: LatLng(30.51279, 114.413487),
        zoom: 17.0,
      );
    }
    final AMapWidget map = AMapWidget(
      // limitBounds: LatLngBounds(
      //     southwest: const LatLng(30.505633, 114.401235),
      //     northeast: const LatLng(30.519878, 114.441127)),
      onLocationChanged: onLocationChanged,
      markers: MarkersInSchool().markersInSchool,
      mapType: MapType.satellite,
      compassEnabled: true,
      labelsEnabled: false,
      initialCameraPosition: initPosition,
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
