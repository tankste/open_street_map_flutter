import 'package:flutter/widgets.dart';
import 'package:open_street_map_flutter_platform_interface/open_street_map_flutter_platform_interface.dart';

class OpenStreetMap extends StatefulWidget {
  OpenStreetMap({
    Key? key,
    required this.initialCameraPosition,
    this.onMapCreated,
    this.markers = const <Marker>{},
    this.polylines = const <Polyline>{},
    this.onCameraIdle,
    this.onCameraMove,
    this.onTap,
  }) : super(key: key);

  final CameraPosition initialCameraPosition;

  final ArgumentCallback<int>? onMapCreated;

  final Set<Marker> markers;

  final Set<Polyline> polylines;

  final VoidCallback? onCameraIdle;

  final ArgumentCallback<LatLng>? onCameraMove;

  final ArgumentCallback<LatLng>? onTap;

  @override
  State createState() => OpenStreetMapState();
}

class OpenStreetMapState extends State<OpenStreetMap> {
  // MapConfiguration _mapConfiguration;

  @override
  Widget build(BuildContext context) {
    return OpenStreetMapFlutterPlatformInterface.instance.buildView(
        initialCameraPosition: widget.initialCameraPosition,
        markers: widget.markers,
        polylines: widget.polylines
        // // _mapId,
        // // onPlatformViewCreated,
        // mapObjects: MapObjects(
        //   markers: widget.markers,
        //   polylines: widget.polylines,
        // ),
        // mapConfiguration: _mapConfiguration,
        );
  }

  @override
  void initState() {
    super.initState();
    // _mapConfiguration = _configurationFromWidget(widget);
  }

// MapConfiguration _configurationFromWidget(OpenStreetMap widget) {
//
// }
}
