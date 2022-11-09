import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_street_map_flutter/open_street_map_flutter.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
