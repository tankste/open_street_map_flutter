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

  MethodChannel ensureChannelInitialized() {
    if (_channel == null) {
      _channel =
          MethodChannel('app.tankste.osm/open_street_map_flutter_android');
      _channel!.setMethodCallHandler((MethodCall call) {
        return Future.value(1);
      });
    }
    return _channel!;
  }

  @override
  Future<void> init() {
    final MethodChannel channel = ensureChannelInitialized();
    return Future.value();
    // return channel.invokeMethod<void>('map#waitForMap');
  }

  @override
  Widget buildView({
    required CameraPosition initialCameraPosition,
    Set<Marker> markers = const <Marker>{},
    Set<Polyline> polylines = const <Polyline>{},
  }) {
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
}
