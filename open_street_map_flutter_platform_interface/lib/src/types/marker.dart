import 'package:flutter/foundation.dart';
import 'package:open_street_map_flutter_platform_interface/src/types/types.dart';

class Marker {
  Marker({required this.id, required this.point, this.icon, this.onTap});

  final String id;
  final LatLng point;
  final ByteData? icon;
  final VoidCallback? onTap;

  Map<String, dynamic> toMap() =>
      {'id': id, 'point': point.toJson(), 'icon': icon?.buffer.asUint8List()};

  Map<String, dynamic> toJson() => toMap();
}
