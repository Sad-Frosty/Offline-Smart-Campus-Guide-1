import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/campus_provider.dart';
import 'screens/building_detail_screen.dart';
import 'screens/directory_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/route_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const UenrCampusGuideApp());
}

class UenrCampusGuideApp extends StatelessWidget {
  const UenrCampusGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CampusProvider(),
      child: Consumer<CampusProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'UENR Campus Guide',
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
              useMaterial3: true,
              textTheme: GoogleFonts.interTextTheme(
                ThemeData.light().textTheme,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.teal,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
            ),
            initialRoute: '/',
            routes: {
              '/': (_) => const SplashScreen(),
              '/main': (_) => const MainPage(),
              '/search': (_) => const SearchScreen(),
              '/onboarding': (_) => const OnboardingScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/detail' &&
                  settings.arguments is Map<String, dynamic>) {
                final args = settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                  builder: (_) =>
                      BuildingDetailScreen(building: args['building']),
                );
              }
              if (settings.name == '/route' &&
                  settings.arguments is Map<String, dynamic>) {
                final args = settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                  builder: (_) => RouteScreen(building: args['building']),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _activeIndex = 0;
  bool _onboardingShown = false;

  static const List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
    DirectoryScreen(),
    SettingsScreen(),
  ];

  static const List<IconData> _icons = [
    Icons.home_outlined,
    Icons.search_outlined,
    Icons.favorite_border,
    Icons.menu_book_outlined,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();

    if (!_onboardingShown && provider.isReady && !provider.onboardingComplete) {
      _onboardingShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushNamed(context, '/onboarding');
        }
      });
    }

    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(child: _pages[_activeIndex]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: AnimatedBottomNavigationBar(
          icons: _icons,
          activeIndex: _activeIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 18,
          rightCornerRadius: 18,
          activeColor: theme.colorScheme.secondary,
          inactiveColor: theme.colorScheme.onSurface.withAlpha(
            (theme.colorScheme.onSurface.a * 255.0 * 0.65).round(),
          ),
          backgroundColor: theme.colorScheme.surface,
          iconSize: 28,
          onTap: (index) => setState(() => _activeIndex = index),
          splashColor: theme.colorScheme.primary.withAlpha(
            (theme.colorScheme.primary.a * 255.0 * 0.18).round(),
          ),
          shadow: const BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ),
      ),
    );
  }
}
