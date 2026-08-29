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
    const primaryColor = Color(0xFF0E6C6A);
    const secondaryColor = Color(0xFFF2B94B);
    const backgroundColor = Color(0xFFF4F7F8);
    const cardColor = Color(0xFFFFFFFF);
    const darkSurface = Color(0xFF0D1F2A);
    const darkCard = Color(0xFF143041);
    const darkBackground = Color(0xFF091A25);

    final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: cardColor,
        surfaceContainerHighest: const Color(0xFFEAF1F4),
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ).copyWith(
        headlineLarge: const TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
        headlineMedium: const TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
        ),
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: Color(0xFF17324A),
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFEAF1F4),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF17324A),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFEAF1F4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        primary: const Color(0xFF56D5C2),
        secondary: secondaryColor,
        surface: darkCard,
        surfaceContainerHighest: const Color(0xFF1F4154),
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        headlineLarge: const TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
        headlineMedium: const TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
        ),
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1D3A4B),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF193446),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF56D5C2), width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF56D5C2),
          foregroundColor: const Color(0xFF071A27),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF56D5C2),
      ),
    );

    return ChangeNotifierProvider(
      create: (_) => CampusProvider(),
      child: Consumer<CampusProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'UENR Campus Guide',
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
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
          leftCornerRadius: 22,
          rightCornerRadius: 22,
          activeColor: theme.colorScheme.primary,
          inactiveColor: theme.colorScheme.onSurface.withAlpha(
            (theme.colorScheme.onSurface.a * 255.0 * 0.62).round(),
          ),
          backgroundColor: theme.colorScheme.surface,
          iconSize: 28,
          onTap: (index) => setState(() => _activeIndex = index),
          splashColor: theme.colorScheme.primary.withAlpha(
            (theme.colorScheme.primary.a * 255.0 * 0.22).round(),
          ),
          shadow: BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ),
      ),
    );
  }
}
