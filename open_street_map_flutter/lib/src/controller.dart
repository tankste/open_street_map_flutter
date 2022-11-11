import 'package:open_street_map_flutter/open_street_map_flutter.dart';
import 'package:open_street_map_flutter_platform_interface/open_street_map_flutter_platform_interface.dart';

class OpenStreetMapController {

  OpenStreetMapController(this.mapId, this.platformInterface);

  int mapId;
  OpenStreetMapFlutterPlatformInterface platformInterface;

  Future<void> setCamera(CameraPosition cameraPosition) {
    return platformInterface.setCameraPosition(mapId, cameraPosition);
  }

  Future<void> animateCamera(CameraPosition cameraPosition) {
    return platformInterface.animateCameraPosition(mapId, cameraPosition);
  }

  Future<void> animateCameraToBounds(LatLngBounds bounds, int padding) {
    return platformInterface.animateCameraBounds(mapId, bounds, padding);
  }
}