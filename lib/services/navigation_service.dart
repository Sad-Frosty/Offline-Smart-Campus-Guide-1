import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../data/campus_data.dart';
import '../models/building.dart';

class NavigationStep {
  final String instruction;
  final IconData icon;

  const NavigationStep({
    required this.instruction,
    required this.icon,
  });
}

class NavigationResult {
  final CampusBuilding destination;
  final CampusBuilding nearestBuilding;
  final double estimatedDistanceMeters;
  final bool isOutsideCampus;
  final String message;
  final List<NavigationStep> steps;

  const NavigationResult({
    required this.destination,
    required this.nearestBuilding,
    required this.estimatedDistanceMeters,
    required this.isOutsideCampus,
    required this.message,
    required this.steps,
  });
}

class NavigationService {
  static const double _campusMinLat = 5.2960;
  static const double _campusMaxLat = 5.3120;
  static const double _campusMinLng = -1.9975;
  static const double _campusMaxLng = -1.9845;
  static const double _outsideCampusDistance = 350.0;
  static const double _nearBuildingThreshold = 40.0;

  static const Map<String, List<String>> _campusGraph = {
    'main_gate': [
      'basic_applied_biology',
      'university_hall1',
      'uncompleted_entrance'
    ],
    'uncompleted_entrance': [
      'nursing_department',
      'administration_block',
      'main_gate'
    ],
    'basic_applied_biology': ['main_gate', 'uenr_clinic', 'university_hall1'],
    'uenr_clinic': ['basic_applied_biology', 'university_hall1'],
    'university_hall1': [
      'main_gate',
      'basic_applied_biology',
      'school_park',
      'sport_office',
      'lt_block'
    ],
    'school_park': ['university_hall1'],
    'sport_office': ['university_hall1'],
    'lt_block': ['university_hall1', 'odum_block', 'old_auditorium'],
    'odum_block': ['lt_block', 'old_auditorium'],
    'old_auditorium': ['lt_block', 'school_cafeteria'],
    'school_cafeteria': ['old_auditorium', 'school_of_sciences'],
    'school_of_sciences': [
      'school_cafeteria',
      'rcees_building',
      'sawmill_block'
    ],
    'rcees_building': ['school_of_sciences', 'sawmill_block'],
    'sawmill_block': ['school_of_sciences', 'rcees_building'],
    'administration_block': [
      'uncompleted_entrance',
      'lib_block',
      'examination_building',
      'it_department'
    ],
    'lib_block': ['administration_block', 'examination_building'],
    'examination_building': ['administration_block', 'lib_block'],
    'it_department': [
      'driving_school',
      'nursing_department',
      'administration_block'
    ],
    'driving_school': ['it_department', 'nursing_department'],
    'nursing_department': [
      'driving_school',
      'it_department',
      'administration_block'
    ],
    'app_lab_building': ['pav_building', 'sh_block'],
    'pav_building': ['app_lab_building'],
    'sh_block': ['app_lab_building'],
  };

  static const Map<String, String> _edgeInstructions = {
    'main_gate|basic_applied_biology':
        'Walk straight toward the Department of Basic and Applied Biology.',
    'basic_applied_biology|uenr_clinic':
        'Continue ahead and keep the clinic on your right.',
    'main_gate|university_hall1':
        'Follow the main road toward University Hall 1.',
    'university_hall1|lt_block':
        'Walk past the school park and turn slightly right toward LT Block.',
    'lt_block|odum_block':
        'Take a short left and continue until you see Odum Block.',
    'odum_block|old_auditorium': 'Walk forward toward the Old Auditorium.',
    'old_auditorium|school_cafeteria':
        'Keep heading straight until you reach the School Cafeteria.',
    'school_cafeteria|school_of_sciences':
        'From the cafeteria, move ahead toward the School of Sciences.',
    'school_of_sciences|rcees_building':
        'Turn right from the School of Sciences to reach the RCEES Building.',
    'school_of_sciences|sawmill_block':
        'Turn left from the School of Sciences toward the Sawmill Block.',
    'uncompleted_entrance|administration_block':
        'Enter the main campus road and continue straight to the Administration Block.',
    'administration_block|lib_block': 'Turn left toward the LIB Block.',
    'lib_block|examination_building':
        'Walk a short distance and you will see the Examination Building beside the library.',
    'it_department|administration_block':
        'Head toward the Administration Block past the IT Department.',
    'driving_school|it_department':
        'Walk toward the IT Department next to the Driving School.',
    'nursing_department|administration_block':
        'Move toward the Administration Block with the Nursing Department on your right.',
    'pav_building|app_lab_building':
        'Walk forward toward the App Lab Building.',
    'app_lab_building|sh_block':
        'Continue ahead and you will see the SH Block near the path.',
  };

  static const Map<String, IconData> _edgeIcons = {
    'main_gate|basic_applied_biology': Icons.arrow_upward,
    'basic_applied_biology|uenr_clinic': Icons.arrow_forward,
    'main_gate|university_hall1': Icons.arrow_forward,
    'university_hall1|lt_block': Icons.turn_right,
    'lt_block|odum_block': Icons.turn_left,
    'odum_block|old_auditorium': Icons.arrow_forward,
    'old_auditorium|school_cafeteria': Icons.arrow_forward,
    'school_cafeteria|school_of_sciences': Icons.arrow_upward,
    'school_of_sciences|rcees_building': Icons.turn_right,
    'school_of_sciences|sawmill_block': Icons.turn_left,
    'uncompleted_entrance|administration_block': Icons.arrow_forward,
    'administration_block|lib_block': Icons.turn_left,
    'lib_block|examination_building': Icons.arrow_forward,
    'it_department|administration_block': Icons.arrow_forward,
    'driving_school|it_department': Icons.arrow_forward,
    'nursing_department|administration_block': Icons.arrow_forward,
    'pav_building|app_lab_building': Icons.arrow_forward,
    'app_lab_building|sh_block': Icons.arrow_forward,
  };

  static NavigationResult calculateRoute(
      Position position, CampusBuilding destination) {
    final nearestBuilding = _findNearestBuilding(position);
    final distanceToNearest = _distance(position.latitude, position.longitude,
        nearestBuilding.latitude, nearestBuilding.longitude);

    if (!_isInsideCampus(position) ||
        distanceToNearest > _outsideCampusDistance) {
      return NavigationResult(
        destination: destination,
        nearestBuilding: nearestBuilding,
        estimatedDistanceMeters: distanceToNearest,
        isOutsideCampus: true,
        message: 'You appear to be outside the UENR campus area.',
        steps: [
          const NavigationStep(
            instruction:
                'Offline navigation only works while you are inside the UENR campus area.',
            icon: Icons.warning_amber_rounded,
          ),
        ],
      );
    }

    final directDistance = _distance(position.latitude, position.longitude,
        destination.latitude, destination.longitude);
    final nearestId = nearestBuilding.id;
    final destinationId = destination.id;
    final routePath = _findRoute(nearestId, destinationId) ??
        _findRoute('main_gate', destinationId);

    if (nearestId == destinationId || directDistance < _nearBuildingThreshold) {
      final steps = <NavigationStep>[
        NavigationStep(
          instruction: 'You are currently near ${destination.name}.',
          icon: Icons.my_location,
        ),
        NavigationStep(
          instruction:
              'Walk carefully to the destination entrance. You have arrived at ${destination.name}.',
          icon: Icons.flag,
        ),
      ];

      return NavigationResult(
        destination: destination,
        nearestBuilding: destination,
        estimatedDistanceMeters: directDistance,
        isOutsideCampus: false,
        message: 'You are already on campus close to the destination.',
        steps: steps,
      );
    }

    if (routePath == null) {
      final steps = <NavigationStep>[
        NavigationStep(
          instruction: 'You are currently near ${nearestBuilding.name}.',
          icon: Icons.my_location,
        ),
        ...destination.directions.map(
          (direction) => NavigationStep(
            instruction: direction,
            icon: Icons.directions_walk,
          ),
        ),
        NavigationStep(
          instruction: 'You have arrived at ${destination.name}.',
          icon: Icons.flag,
        ),
      ];

      return NavigationResult(
        destination: destination,
        nearestBuilding: nearestBuilding,
        estimatedDistanceMeters: directDistance,
        isOutsideCampus: false,
        message:
            'A direct campus route could not be found, using the destination’s offline landmark directions.',
        steps: steps,
      );
    }

    final steps = _buildSteps(nearestBuilding, routePath, destination);
    final estimatedDistance = _estimateDistance(position, routePath);
    return NavigationResult(
      destination: destination,
      nearestBuilding: nearestBuilding,
      estimatedDistanceMeters: estimatedDistance,
      isOutsideCampus: false,
      message:
          'Your offline route is ready. Follow the steps below to reach ${destination.name}.',
      steps: steps,
    );
  }

  static bool _isInsideCampus(Position position) {
    return position.latitude >= _campusMinLat &&
        position.latitude <= _campusMaxLat &&
        position.longitude >= _campusMinLng &&
        position.longitude <= _campusMaxLng;
  }

  static CampusBuilding _findNearestBuilding(Position position) {
    return campusBuildings.reduce((current, next) {
      final currentDistance = _distance(position.latitude, position.longitude,
          current.latitude, current.longitude);
      final nextDistance = _distance(
          position.latitude, position.longitude, next.latitude, next.longitude);
      return nextDistance < currentDistance ? next : current;
    });
  }

  static double _distance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  static List<String>? _findRoute(String startId, String destinationId) {
    if (startId == destinationId) {
      return [startId];
    }

    final queue = Queue<List<String>>();
    final visited = <String>{startId};
    queue.add([startId]);

    while (queue.isNotEmpty) {
      final path = queue.removeFirst();
      final last = path.last;
      for (final neighbor in _campusGraph[last] ?? []) {
        if (visited.contains(neighbor)) {
          continue;
        }
        final List<String> candidate = <String>[...path, neighbor];
        if (neighbor == destinationId) {
          return candidate;
        }
        visited.add(neighbor);
        queue.add(candidate);
      }
    }

    return null;
  }

  static List<NavigationStep> _buildSteps(
    CampusBuilding start,
    List<String> path,
    CampusBuilding destination,
  ) {
    final steps = <NavigationStep>[
      NavigationStep(
        instruction: 'You are currently near ${start.name}.',
        icon: Icons.my_location,
      ),
    ];

    for (var index = 0; index < path.length - 1; index++) {
      final fromId = path[index];
      final toId = path[index + 1];
      final instruction = _edgeInstructions['$fromId|$toId'] ??
          'Head toward ${_buildingNameById(toId)}.';
      final icon = _edgeIcons['$fromId|$toId'] ?? Icons.arrow_forward;
      steps.add(NavigationStep(instruction: instruction, icon: icon));
    }

    if (path.last != destination.id) {
      steps.add(NavigationStep(
        instruction: 'Continue toward ${destination.name}.',
        icon: Icons.arrow_forward,
      ));
    }

    steps.add(NavigationStep(
      instruction: 'You have arrived at ${destination.name}.',
      icon: Icons.flag,
    ));
    return steps;
  }

  static String _buildingNameById(String id) {
    return campusBuildings
        .firstWhere(
          (building) => building.id == id,
          orElse: () => CampusBuilding(
            id: id,
            name: 'landmark',
            description: '',
            imagePath: null,
            mapX: 0,
            mapY: 0,
            category: '',
            directions: const [],
            highlights: const [],
          ),
        )
        .name;
  }

  static double _estimateDistance(Position position, List<String> path) {
    var total = 0.0;
    var currentLat = position.latitude;
    var currentLng = position.longitude;

    for (final id in path) {
      final node = campusBuildings.firstWhere((building) => building.id == id);
      total += _distance(currentLat, currentLng, node.latitude, node.longitude);
      currentLat = node.latitude;
      currentLng = node.longitude;
    }

    return total;
  }
}
