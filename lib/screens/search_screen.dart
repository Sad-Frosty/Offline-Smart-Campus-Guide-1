import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/campus_provider.dart';
import '../widgets/building_preview_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();
    final results = provider.searchResults;
    final theme = Theme.of(context);
    final hasQuery = provider.searchQuery.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Campus'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(16),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search buildings, halls, services...',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  suffixIcon: provider.searchQuery.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () => provider.updateSearchQuery(''),
                        ),
                ),
                onChanged: provider.updateSearchQuery,
              ),
            ),
            const SizedBox(height: 18),
            if (!hasQuery) ...[
              Text(
                'Recent searches',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              if (provider.recentSearches.isEmpty)
                Text(
                  'Start typing to find a building or select a category.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              else
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: provider.recentSearches.map((building) {
                    return ActionChip(
                      label: Text(building.name),
                      onPressed: () {
                        provider.updateSearchQuery(building.name);
                      },
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),
              Text(
                'Popular categories',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: provider.categories.map((category) {
                  return ActionChip(
                    label: Text(category),
                    onPressed: () => provider.updateSearchQuery(category),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
            ] else ...[
              Text(
                'Search results',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
            ],
            Expanded(
              child: results.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'No matching building found. Try another keyword.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final building = results[index];
                        return BuildingPreviewCard(
                          building: building,
                          onTap: () {
                            provider.selectBuilding(building);
                            provider.addRecentSearch(building);
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: {'building': building},
                            );
                          },
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
