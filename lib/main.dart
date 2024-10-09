import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:mapapp/const_config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }

  void _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses =
        await needPermissionList.request();
    statuses.forEach((key, value) {
      print('$key premissionStatus is $value');
    });
  }
}

class MyAppState extends ChangeNotifier {}

// ...

class MyHomePage extends StatelessWidget {
  var selectedPage = 0;

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const MapPage(),
            ),
          ),
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.map),
                  label: Text('MapPage"'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.search),
                  label: Text('SearchPage'),
                ),
              ],
              selectedIndex: selectedPage,
              onDestinationSelected: (value) {
                selectedPage = value;
                print('selected: $value');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: (Center(child: _ShowMapPageBody())),
    );
  }
}

// ...

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

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
    target: LatLng(
      30.51342,
      114.413578,
    ),
    zoom: 10.0,
  );

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
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
