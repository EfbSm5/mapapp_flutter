import 'package:amap_map/amap_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapapp/Data/markers.dart';
import 'package:mapapp/Data/searchForPoi.dart';

class SearchPage extends StatefulWidget {
  final Function(Marker) onTap;

  const SearchPage({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Marker> markerList = MarkersInSchool().markersInSchool.toList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Search for a name',
                border: OutlineInputBorder(),
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: markerList.length,
              itemBuilder: (context, index) {
                final name = markerList[index].infoWindow.title;
                return ListTile(
                  title: Text(name!),
                  onTap: () {
                    widget.onTap(markerList[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _search(String query) {
    setState(() {
      markerList = findMarkersByTitle(query);
    });
  }
}
