import 'dart:ui';
import 'package:open_street_map_flutter_platform_interface/src/types/types.dart';

class Polyline {
  Polyline(
      {required this.id,
      required this.points,
      this.color = const Color(0xFF0000FF),
      this.width = 4});

  final String id;
  final Set<LatLng> points;
  final Color color;
  final double width;

  Map<String, dynamic> toMap() => {
        'id': id,
        'points': points.map((p) => p.toMap()).toList(),
        'color': color.value,
        'width': width
      };

  Map<String, dynamic> toJson() => toMap();
}
