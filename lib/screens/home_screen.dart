import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/campus_data.dart';
import '../providers/campus_provider.dart';
import '../widgets/building_preview_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();
    final theme = Theme.of(context);
    final quickAccess = provider.quickAccessBuildings;
    final featuredBuildings = campusBuildings.take(5).toList();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        children: [
          Text(
            'Welcome to UENR',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Find campus buildings, routes, and offline directions in one place.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/search'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search buildings, departments, halls...',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Quick access',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: quickAccess.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final building = quickAccess[index];
                return GestureDetector(
                  onTap: () {
                    provider.selectBuilding(building);
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: {'building': building},
                    );
                  },
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18)),
                            child: building.imagePath != null
                                ? Image.asset(
                                    building.imagePath!,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: theme.colorScheme.surface,
                                    child: Center(
                                      child: Icon(
                                        Icons.location_city,
                                        size: 48,
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            building.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Explore by category',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: provider.categories.map((category) {
              return ActionChip(
                label: Text(category),
                onPressed: () {
                  provider.updateSearchQuery(category);
                  Navigator.pushNamed(context, '/search');
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            'Featured buildings',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: featuredBuildings.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              thickness: 1,
              color: theme.colorScheme.outlineVariant,
            ),
            itemBuilder: (context, index) {
              final building = featuredBuildings[index];
              final hasImage = building.imagePath?.isNotEmpty == true;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    provider.selectBuilding(building);
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: {'building': building},
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hasImage) ...[
                          Hero(
                            tag: building.id,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                building.imagePath!,
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                building.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withAlpha(
                                    (theme.colorScheme.primary.a * 255.0 * 0.12)
                                        .round(),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  building.category,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                building.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Campus tips',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: campusTips.take(3).map((tip) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withAlpha(
                          (theme.colorScheme.primary.a * 255.0 * 0.14).round(),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.lightbulb_outline,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tip,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
