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
      // PlatformViewCreatedCallback onPlatformViewCreated,
      {
        required CameraPosition initialCameraPosition,
        Set<Marker> markers = const <Marker>{},
        Set<Polyline> polylines = const <Polyline>{},
        // Map<String, dynamic> mapOptions = const <String, dynamic>{},
      }) {
    throw UnimplementedError('buildView() has not been implemented.');
  }
}
