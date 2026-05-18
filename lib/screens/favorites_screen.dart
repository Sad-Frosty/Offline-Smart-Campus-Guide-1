import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/campus_provider.dart';
import '../widgets/building_preview_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();
    final favorites = provider.favorites;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        child: favorites.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 70,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No saved buildings yet.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mark buildings as favorites and they will appear here for quick access.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
            : ListView.separated(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final building = favorites[index];
                  return BuildingPreviewCard(
                    building: building,
                    onTap: () {
                      provider.selectBuilding(building);
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: {'building': building},
                      );
                    },
                    action: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: theme.colorScheme.error,
                      ),
                      onPressed: () => provider.toggleFavorite(building),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
      ),
    );
  }
}
