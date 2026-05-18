import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/campus_provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<CampusProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('About UENR'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UENR Campus Guide',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'This offline campus assistant helps visitors, freshmen, and new students find lecture halls, services, hostels, laboratories, cafeterias, and support centers across the UENR campus without internet access.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'How to use',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _BulletText(
              text:
                  'Search for a building name or tap a marker on the campus map.',
            ),
            _BulletText(
              text: 'Open any building card to view easy walking directions.',
            ),
            _BulletText(
              text: 'Use the route screen for step-by-step offline guidance.',
            ),
            const SizedBox(height: 24),
            Text(
              'Settings',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Toggle between light and dark themes.'),
                value: provider.isDarkMode,
                onChanged: (_) => provider.toggleDarkMode(),
                secondary: const Icon(Icons.dark_mode),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'University of Energy and Natural Resources',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'UENR is a public university dedicated to learning, research and innovation in energy and natural resources. This guide is built as a lightweight offline companion to support campus navigation and orientation.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;

  const _BulletText({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: theme.textTheme.bodyLarge),
          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
