import 'package:flutter/foundation.dart' show immutable, objectRuntimeType;

import 'types.dart';

@immutable
class CameraPosition {
  const CameraPosition({
    required this.target,
    this.zoom = 0.0,
  })  : assert(target != null),
        assert(zoom != null);

  final LatLng target;

  final double zoom;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is CameraPosition &&
        target == other.target &&
        zoom == other.zoom;
  }

  @override
  int get hashCode => Object.hash(target, zoom);

  @override
  String toString() =>
      '$objectRuntimeType(target: $target, zoom: $zoom)';
}
