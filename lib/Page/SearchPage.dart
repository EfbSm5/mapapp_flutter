import 'package:amap_map/amap_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapapp/Data/Markers.dart';
import 'package:mapapp/Data/SearchForPoi.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<String?> ListNames = [];
  List<Marker> markerList = [];

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
              itemCount: ListNames.length,
              itemBuilder: (context, index) {
                final name = ListNames[index];
                return ListTile(
                  title: Text(name!),
                  onTap: () {
                    // 点击后显示选中项的名称
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('You selected: $name')),
                    );
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
    Set<Marker> markers = MarkersInSchool().markersInSchool;
    markerList = findMarkersByTitle(markers, query);
    setState(() {
      ListNames = extractMarkerTitles(markerList);
    });
  }
}
