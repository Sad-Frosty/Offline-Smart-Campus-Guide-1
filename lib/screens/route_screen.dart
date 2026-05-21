import 'package:flutter/material.dart';

import '../models/building.dart';

class RouteScreen extends StatelessWidget {
  final CampusBuilding building;

  const RouteScreen({super.key, required this.building});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = building.imagePath?.isNotEmpty == true;
    return Scaffold(
      appBar: AppBar(title: const Text('Route Directions'), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) ...[
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      building.imagePath!,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withAlpha(
                                  (Colors.black.a * 255.0 * 0.8).round()),
                              Colors.black.withAlpha(0),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              building.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              building.category,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      building.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      building.category,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Route from Main Gate',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Follow these offline directions to reach this location.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  ...building.directions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 0,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.primary.withAlpha(
                            (theme.colorScheme.primary.a * 255.0 * 0.16)
                                .round(),
                          ),
                          child: Text(
                            '${index + 1}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          step,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 14),
                  FilledButton.icon(
                    icon: const Icon(Icons.map),
                    label: const Text('Back to Home'),
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/main'));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
