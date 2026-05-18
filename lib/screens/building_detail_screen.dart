import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/building.dart';
import '../providers/campus_provider.dart';

class BuildingDetailScreen extends StatelessWidget {
  final CampusBuilding building;

  const BuildingDetailScreen({super.key, required this.building});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();
    final theme = Theme.of(context);
    final hasImage = building.imagePath?.isNotEmpty == true;
    final isFavorite = provider.isFavorite(building.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(building.name),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? theme.colorScheme.error : null,
            ),
            onPressed: () => provider.toggleFavorite(building),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) ...[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        backgroundColor: Colors.black,
                        appBar:
                            AppBar(backgroundColor: Colors.black, elevation: 0),
                        body: Center(
                          child: Hero(
                            tag: building.id,
                            child: Image.asset(
                              building.imagePath!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: building.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      building.imagePath!,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    building.category.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    building.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    building.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: building.highlights.map(
                      (highlight) {
                        return Chip(
                          label: Text(highlight),
                          backgroundColor:
                              theme.colorScheme.surfaceContainerHighest,
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Quick directions',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: building.directions.asMap().entries.map((entry) {
                final index = entry.key;
                final direction = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          direction,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.directions_walk),
                label: const Text('View full route'),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/route',
                    arguments: {'building': building},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
