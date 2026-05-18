import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/campus_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        children: [
          SwitchListTile(
            title: const Text('Dark mode'),
            subtitle: const Text('Save the theme preference locally.'),
            value: provider.isDarkMode,
            onChanged: (_) => provider.toggleDarkMode(),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Clear recent searches'),
            subtitle: const Text('Remove saved search history from device.'),
            trailing: provider.recentSearches.isEmpty
                ? const Text('Empty')
                : const Icon(Icons.cleaning_services_outlined),
            onTap: provider.recentSearches.isEmpty
                ? null
                : () => provider.clearRecentSearches(),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text('Show onboarding again'),
            subtitle: const Text('Restart the campus guide introduction.'),
            onTap: () {
              provider.resetOnboarding();
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Onboarding will show again on next launch.'),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'App information',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UENR Smart Campus Guide',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Built for offline campus navigation, fast search, and favorites.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
