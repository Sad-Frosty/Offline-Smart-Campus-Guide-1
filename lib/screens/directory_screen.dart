import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/campus_data.dart';
import '../models/building.dart';
import '../providers/campus_provider.dart';
import '../widgets/building_preview_card.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  Map<String, List<CampusBuilding>> _groupByLetter() {
    final Map<String, List<CampusBuilding>> grouped = {};
    final sortedBuildings = List<CampusBuilding>.from(campusBuildings)
      ..sort((a, b) => a.name.compareTo(b.name));

    for (final building in sortedBuildings) {
      final letter = building.name[0].toUpperCase();
      grouped.putIfAbsent(letter, () => []).add(building);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();
    final theme = Theme.of(context);
    final grouped = _groupByLetter();
    final letters = grouped.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Directory'),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        itemCount: letters.length,
        separatorBuilder: (_, __) => const SizedBox(height: 22),
        itemBuilder: (context, index) {
          final letter = letters[index];
          final buildings = grouped[letter]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                letter,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...buildings.map(
                (building) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: BuildingPreviewCard(
                    building: building,
                    onTap: () {
                      provider.selectBuilding(building);
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: {'building': building},
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
