import 'types.dart';

class CameraPosition {
  static CameraPosition fromMap(Map<String, dynamic> map) => CameraPosition(
        center: LatLng.fromMap(Map<String, dynamic>.from(map["center"])),
        zoom: map["zoom"] as double,
      );

  const CameraPosition({
    required this.center,
    this.zoom = 0.0,
  });

  final LatLng center;

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
        center == other.center &&
        zoom == other.zoom;
  }

  @override
  int get hashCode => Object.hash(center, zoom);

  @override
  String toString() => 'CameraPosition(center: $center, zoom: $zoom)';

  Map<String, dynamic> toMap() => {'center': center.toMap(), 'zoom': zoom};
}
