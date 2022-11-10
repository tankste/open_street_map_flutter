
class Style {
  static Style fromMap(Map<String, dynamic> map) => Style(
    invertColors: map["Style"] as bool,
  );

  const Style({
    this.invertColors = false,
  });

  final bool invertColors;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is Style &&
        invertColors == other.invertColors;
  }

  @override
  int get hashCode => invertColors.hashCode;

  @override
  String toString() => 'Style(invertColors: $invertColors)';

  Map<String, dynamic> toMap() => {'invertColors': invertColors};
}