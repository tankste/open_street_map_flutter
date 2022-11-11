import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:open_street_map_flutter_platform_interface/open_street_map_flutter_platform_interface.dart';

class OpenStreetMapFlutterAndroid
    extends OpenStreetMapFlutterPlatformInterface {
  static void registerWith() {
    OpenStreetMapFlutterPlatformInterface.instance =
        OpenStreetMapFlutterAndroid();
  }

  final Map<int, MethodChannel> _channels = {};

  Map<int, VoidCallback?> onCameraMoveStarted = {};
  Map<int, ArgumentCallback<CameraPosition>?> onCameraMove = {};
  Map<int, ArgumentCallback<CameraPosition>?> onCameraIdle = {};
  Map<int, Map<String, VoidCallback?>> markerClickListeners = {};

  MethodChannel ensureChannelInitialized(int mapId) {
    if (_channels[mapId] == null) {
      _channels[mapId] = MethodChannel(
          'app.tankste.osm/open_street_map_flutter_android_$mapId');
      _channels[mapId]!.setMethodCallHandler(
          (methodCall) => _handleMethodCall(mapId, methodCall));
    }
    return _channels[mapId]!;
  }

  @override
  Future<void> init(int mapId) {
    ensureChannelInitialized(mapId);
    return Future.value();
  }

  @override
  Widget buildView({
    required int mapId,
    required PlatformViewCreatedCallback onPlatformViewCreated,
    required CameraPosition initialCameraPosition,
    Set<Marker> markers = const <Marker>{},
    Set<Polyline> polylines = const <Polyline>{},
    VoidCallback? onCameraMoveStarted,
    ArgumentCallback<CameraPosition>? onCameraMove,
    ArgumentCallback<CameraPosition>? onCameraIdle,
  }) {
    this.onCameraMoveStarted[mapId] = onCameraMoveStarted;
    this.onCameraMove[mapId] = onCameraMove;
    this.onCameraIdle[mapId] = onCameraIdle;

    String viewType = "app.tankste.osm/open_street_map_flutter";

    return PlatformViewLink(
      viewType: viewType,
      onCreatePlatformView: (PlatformViewCreationParams params) {
        return PlatformViewsService.initExpensiveAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            onFocus: () => params.onFocusChanged(true),
            creationParams: {"channelId": mapId},
            creationParamsCodec: const StandardMessageCodec())
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..addOnPlatformViewCreatedListener(onPlatformViewCreated)
          ..create();
      },
      surfaceFactory:
          (BuildContext context, PlatformViewController controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const {},
          // gestureRecognizers: widgetConfiguration.gestureRecognizers,
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
    );
  }

  Future<dynamic> _handleMethodCall(int mapId, MethodCall methodCall) {
    switch (methodCall.method) {
      case "camera#startMoving":
        onCameraMoveStarted[mapId]?.call();
        return Future.value();
      case "camera#moved":
        onCameraMove[mapId]?.call(CameraPosition.fromMap(
            Map<String, dynamic>.from(methodCall.arguments)));
        return Future.value();
      case "camera#idle":
        onCameraIdle[mapId]?.call(CameraPosition.fromMap(
            Map<String, dynamic>.from(methodCall.arguments)));
        return Future.value();
      case "marker#clicked":
        String id = methodCall.arguments["id"];
        markerClickListeners[mapId]?[id]?.call();
        return Future.value();
      default:
        throw MissingPluginException();
    }
  }

  @override
  Future<void> setStyle(int mapId, Style style) {
    return _channels[mapId]?.invokeMethod<void>(
            'style#set', <String, dynamic>{'style': style.toMap()}) ??
        Future.value();
  }

  @override
  Future<void> setShowMyLocation(int mapId, bool showMyLocation) {
    return _channels[mapId]?.invokeMethod<void>('myLocation#set',
            <String, dynamic>{'showMyLocation': showMyLocation}) ??
        Future.value();
  }

  @override
  Future<void> setCameraPosition(int mapId, CameraPosition cameraPosition) {
    return _channels[mapId]?.invokeMethod<void>('camera#set',
            <String, dynamic>{'cameraPosition': cameraPosition.toMap()}) ??
        Future.value();
  }

  @override
  Future<void> animateCameraPosition(int mapId, CameraPosition cameraPosition) {
    return _channels[mapId]?.invokeMethod<void>('camera#move',
            <String, dynamic>{'cameraPosition': cameraPosition.toMap()}) ??
        Future.value();
  }

  @override
  Future<void> animateCameraBounds(
      int mapId, LatLngBounds bounds, int padding) {
    return _channels[mapId]?.invokeMethod<void>('camera#moveBounds',
            <String, dynamic>{'bounds': bounds.toMap(), 'padding': padding}) ??
        Future.value();
  }

  @override
  Future<void> setMarkers(int mapId, Set<Marker> markers) {
    markerClickListeners[mapId] = {for (var m in markers) m.id: m.onTap};
    return _channels[mapId]?.invokeMethod<void>(
            'markers#set', <String, dynamic>{
          'markers': markers.map((m) => m.toMap()).toList()
        }) ??
        Future.value();
  }

  @override
  Future<void> setPolylines(int mapId, Set<Polyline> polylines) {
    return _channels[mapId]?.invokeMethod<void>(
            'polylines#set', <String, dynamic>{
          'polylines': polylines.map((p) => p.toMap()).toList()
        }) ??
        Future.value();
  }
}
