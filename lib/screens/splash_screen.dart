import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withAlpha(
                    (theme.colorScheme.surface.a * 255.0 * 0.18).round(),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.school,
                  size: 72,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'UENR Campus Guide',
                style: GoogleFonts.inter(
                  textStyle: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Offline navigation for visitors and new students',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withAlpha(
                      (theme.colorScheme.onPrimary.a * 255.0 * 0.88).round(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
