class CampusBuilding {
  final String id;
  final String name;
  final String description;
  final String? imagePath;
  final double mapX;
  final double mapY;
  final String category;
  final List<String> directions;
  final List<String> highlights;
  final List<String> nearbyLandmarks;

  const CampusBuilding({
    required this.id,
    required this.name,
    required this.description,
    this.imagePath,
    required this.mapX,
    required this.mapY,
    required this.category,
    required this.directions,
    required this.highlights,
    this.nearbyLandmarks = const [],
  });

  static const double _campusCenterLat = 5.3045;
  static const double _campusCenterLng = -1.9910;
  static const double _campusHeight = 0.014;
  static const double _campusWidth = 0.012;

  double get latitude => _campusCenterLat + (mapY - 0.5) * _campusHeight;
  double get longitude => _campusCenterLng + (mapX - 0.5) * _campusWidth;
}
