import 'dart:convert';
import 'dart:typed_data';

import 'package:open_street_map_flutter_platform_interface/src/types/types.dart';

class Marker {
  final String id;
  final LatLng point;
  final ByteData? icon;

  Marker({required this.id, required this.point, this.icon});

  Map<String, dynamic> toJson() =>
      {'id': id, 'point': point.toJson(), 'icon': icon?.buffer?.asUint8List()};
}
