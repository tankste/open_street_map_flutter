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
  String cameraPosition = "";

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
              initialCameraPosition: CameraPosition(
                  center: LatLng(52.3532222, 9.7582331), zoom: 13),
              enableMyLocation: true,
              style: Style(invertColors: false),
              onCameraMove: (CameraPosition cameraPosition) {
                setState(() {
                  this.cameraPosition = cameraPosition.toString();
                });
              },
              markers: {
                Marker(
                    id: "1", point: LatLng(52.3532222, 9.7582331), icon: icon),
                Marker(
                    id: "2", point: LatLng(52.346984, 9.7584736), icon: icon),
              },
            )),
            Text("$cameraPosition"),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();

    _loadIcon();
  }

  void _loadIcon() async {
    String resolutionName = await AssetImage('images/marker.png')
        .obtainKey(ImageConfiguration.empty)
        .then((value) => value.name);

    ByteData bytes = await rootBundle.load(resolutionName);
    setState(() {
      icon = bytes;
    });
  }
}
