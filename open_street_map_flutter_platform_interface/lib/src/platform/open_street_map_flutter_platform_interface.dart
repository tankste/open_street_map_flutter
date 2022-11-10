import 'package:flutter/services.dart';
import 'package:open_street_map_flutter_platform_interface/src/channel/method_channel_open_street_map_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter/widgets.dart';

import '../types/types.dart';

abstract class OpenStreetMapFlutterPlatformInterface extends PlatformInterface {
  OpenStreetMapFlutterPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static OpenStreetMapFlutterPlatformInterface _instance =
      MethodChannelOpenStreetMapFlutter();

  static OpenStreetMapFlutterPlatformInterface get instance => _instance;

  static set instance(OpenStreetMapFlutterPlatformInterface instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Widget buildView(
      // int creationId,
      {
        required PlatformViewCreatedCallback onPlatformViewCreated,
        required CameraPosition initialCameraPosition,
        Set<Marker> markers = const <Marker>{},
        Set<Polyline> polylines = const <Polyline>{},
        ArgumentCallback<CameraPosition>? onCameraMove = null,
        // Map<String, dynamic> mapOptions = const <String, dynamic>{},
      }) {
    throw UnimplementedError('`buildView(...)` has not been implemented.');
  }

  Future<void> setStyle(Style style) {
    throw UnimplementedError('`setStyle(...)` has not been implemented.');
  }

  Future<void> setShowMyLocation(bool showMyLocation) {
    throw UnimplementedError('`setShowMyLocation(...)` has not been implemented.');
  }

  Future<void> setMarkers(Set<Marker> markers) {
    throw UnimplementedError('`setMarkers(...)` has not been implemented.');
  }

  Future<void> setCameraPosition(CameraPosition camera) {
    throw UnimplementedError('`setCameraPosition(...)` has not been implemented.');
  }

  Future<void> animateCameraPosition(CameraPosition camera) {
    throw UnimplementedError('`animateCameraPosition(...)` has not been implemented.');
  }
}
