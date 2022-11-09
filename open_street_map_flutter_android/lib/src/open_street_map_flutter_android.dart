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

  MethodChannel? _channel;

  ArgumentCallback<CameraPosition>? onCameraMove;

  MethodChannel ensureChannelInitialized() {
    if (_channel == null) {
      _channel =
          MethodChannel('app.tankste.osm/open_street_map_flutter_android');
      _channel!.setMethodCallHandler(_handleMethodCall);
    }
    return _channel!;
  }

  @override
  Future<void> init() {
    ensureChannelInitialized();
    return Future.value();
    // return channel.invokeMethod<void>('map#waitForMap');
  }

  @override
  Widget buildView({
    required PlatformViewCreatedCallback onPlatformViewCreated,
    required CameraPosition initialCameraPosition,
    Set<Marker> markers = const <Marker>{},
    Set<Polyline> polylines = const <Polyline>{},
    ArgumentCallback<CameraPosition>? onCameraMove,
  }) {
    this.onCameraMove = onCameraMove;

    String viewType = "app.tankste.osm/open_street_map_flutter";

    return PlatformViewLink(
      viewType: viewType,
      onCreatePlatformView: (PlatformViewCreationParams params) {
        return PlatformViewsService.initExpensiveAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          // creationParams: creationParams,
          // creationParamsCodec: const StandardMessageCodec(),
          onFocus: () => params.onFocusChanged(true),
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..addOnPlatformViewCreatedListener(onPlatformViewCreated)
          ..create();
      },
      surfaceFactory:
          (BuildContext context, PlatformViewController controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: {},
          // gestureRecognizers: widgetConfiguration.gestureRecognizers,
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
    );
  }

  Future<dynamic> _handleMethodCall(MethodCall methodCall) {
    switch (methodCall.method) {
      case "camera#moved":
        onCameraMove?.call(CameraPosition.fromMap(Map<String, dynamic>.from(methodCall.arguments)));
        return Future.value();
      default:
        throw MissingPluginException();
    }
  }

  @override
  Future<void> setMarkers(Set<Marker> markers) {
    return _channel?.invokeMethod<void>('markers#set', <String, dynamic>{
          'markers': markers.map((m) => m.toJson()).toList()
        }) ??
        Future.value();
  }
}
