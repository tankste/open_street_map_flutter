import 'package:flutter/foundation.dart';
import 'package:open_street_map_flutter_platform_interface/src/types/types.dart';

class Marker {
  final String id;
  final LatLng point;
  final ByteData? icon;
  final VoidCallback? onTap;

  Marker({required this.id, required this.point, this.icon, this.onTap});

  Map<String, dynamic> toJson() =>
      {'id': id, 'point': point.toJson(), 'icon': icon?.buffer.asUint8List()};
}
