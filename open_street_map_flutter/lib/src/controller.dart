
import 'package:open_street_map_flutter/open_street_map_flutter.dart';
import 'package:open_street_map_flutter_platform_interface/open_street_map_flutter_platform_interface.dart';

class OpenStreetMapController {

  OpenStreetMapFlutterPlatformInterface platformInterface =
      OpenStreetMapFlutterPlatformInterface.instance;

  Future<void> setCamera(CameraPosition cameraPosition) {
    return platformInterface.setCameraPosition(cameraPosition);
  }

  Future<void> animateCamera(CameraPosition cameraPosition) {
    return platformInterface.animateCameraPosition(cameraPosition);
  }
}