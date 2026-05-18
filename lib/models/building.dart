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
  });
}
