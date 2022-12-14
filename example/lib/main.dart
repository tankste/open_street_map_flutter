// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_street_map_flutter/open_street_map_flutter.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Street Map Flutter - Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Open Street Map Flutter - Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ByteData? icon;
  String cameraState = "";
  String cameraPosition = "";
  OpenStreetMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: OpenStreetMap(
            initialCameraPosition: const CameraPosition(
                center: LatLng(52.3532222, 9.7582331), zoom: 13),
            enableMyLocation: true,
            style: const Style(invertColors: false),
            onMapCreated: (controller) {
              mapController = controller;
            },
            onCameraMoveStarted: () {
              setState(() {
                print("Moving started..");
                cameraState = "Moving started";
              });
            },
            onCameraMove: (CameraPosition cameraPosition) {
              setState(() {
                print("Moving..");
                cameraState = "Moving";
                this.cameraPosition = cameraPosition.toString();
              });
            },
            onCameraIdle: (CameraPosition cameraPosition) {
              print("Camera idle..");
              setState(() {
                cameraState = "Idle";
              });
            },
            markers: {
              Marker(
                  id: "marker-1",
                  point: const LatLng(52.3532222, 9.7582331),
                  icon: icon,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Clicked marker one."),
                    ));
                  }),
              Marker(
                  id: "marker-2",
                  point: const LatLng(52.346984, 9.7584736),
                  icon: icon,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Clicked marker two."),
                    ));
                  }),
            },
            polylines: {
              Polyline(
                  id: "polyline-1",
                  color: Colors.orange,
                  width: 10,
                  points: {
                    const LatLng(52.34841, 9.75083),
                    const LatLng(52.35434, 9.74628),
                    const LatLng(52.35681, 9.76301)
                  })
            },
          )),
          Text(cameraState),
          Text(cameraPosition),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            mapController?.animateCamera(const CameraPosition(
                center: LatLng(52.3881111, 9.6944627), zoom: 17.0));
          },
          child: const Icon(Icons.move_down_rounded)),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadIcon();
  }

  void _loadIcon() async {
    String resolutionName = await const AssetImage('images/marker.png')
        .obtainKey(ImageConfiguration.empty)
        .then((value) => value.name);

    ByteData bytes = await rootBundle.load(resolutionName);
    setState(() {
      icon = bytes;
    });
  }
}
