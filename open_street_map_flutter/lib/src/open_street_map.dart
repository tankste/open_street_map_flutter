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
    this.style = const Style(invertColors: false),
  }) : super(key: key);

  final CameraPosition initialCameraPosition;

  final ArgumentCallback<int>? onMapCreated;

  final Set<Marker> markers;

  final Set<Polyline> polylines;

  final VoidCallback? onCameraIdle;

  final ArgumentCallback<CameraPosition>? onCameraMove;

  final ArgumentCallback<LatLng>? onTap;

  final Style style;

  @override
  State createState() => OpenStreetMapState();
}

class OpenStreetMapState extends State<OpenStreetMap> {
  OpenStreetMapFlutterPlatformInterface platformInterface =
      OpenStreetMapFlutterPlatformInterface.instance;

  @override
  Widget build(BuildContext context) {
    return platformInterface.buildView(
      onPlatformViewCreated: onPlatformViewCreated,
      initialCameraPosition: widget.initialCameraPosition,
      markers: widget.markers,
      polylines: widget.polylines,
      onCameraMove: widget.onCameraMove,
    );
  }

  Future<void> onPlatformViewCreated(int id) {
    return platformInterface.init().then((value) {
      _initCamera();
      _updateStyle();
      _updateMarkers();
    });
  }

  @override
  void didUpdateWidget(OpenStreetMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateStyle();
    _updateMarkers();
  }

  void _initCamera() {
    platformInterface.setCameraPosition(widget.initialCameraPosition);
  }

  void _updateStyle() {
    platformInterface.setStyle(widget.style);
  }

  void _updateMarkers() {
    platformInterface.setMarkers(widget.markers);
  }
}
