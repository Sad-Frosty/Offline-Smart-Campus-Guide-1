import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/campus_data.dart';
import '../models/building.dart';

class CampusProvider extends ChangeNotifier {
  String _searchQuery = '';
  bool _darkMode = false;
  bool _onboardingComplete = false;
  bool _isReady = false;
  final List<String> _favoriteIds = [];
  final List<String> _recentSearchIds = [];
  CampusBuilding? _selectedBuilding;

  CampusProvider() {
    _loadPreferences();
  }

  bool get isReady => _isReady;
  bool get isDarkMode => _darkMode;
  bool get onboardingComplete => _onboardingComplete;
  String get searchQuery => _searchQuery;
  CampusBuilding? get selectedBuilding => _selectedBuilding;

  List<CampusBuilding> get favorites => _favoriteIds
      .map((id) => findBuildingById(id))
      .whereType<CampusBuilding>()
      .toList();

  List<CampusBuilding> get recentSearches => _recentSearchIds
      .map((id) => findBuildingById(id))
      .whereType<CampusBuilding>()
      .toList();

  List<String> get categories {
    final categories =
        campusBuildings.map((building) => building.category).toSet().toList();
    categories.sort();
    return categories;
  }

  Map<String, List<CampusBuilding>> get buildingsByCategory {
    final grouped = <String, List<CampusBuilding>>{};
    for (final building in campusBuildings) {
      grouped.putIfAbsent(building.category, () => []).add(building);
    }
    return grouped;
  }

  List<CampusBuilding> get quickAccessBuildings {
    const ids = [
      'lib_block',
      'school_cafeteria',
      'administration_block',
      'lt_block',
      'old_auditorium',
    ];

    return ids
        .map((id) => findBuildingById(id))
        .whereType<CampusBuilding>()
        .toList();
  }

  List<CampusBuilding> get searchResults {
    if (_searchQuery.isEmpty) {
      return campusBuildings;
    }
    return searchBuildings(_searchQuery);
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool('darkMode') ?? false;
    _onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
    _favoriteIds.clear();
    _favoriteIds.addAll(prefs.getStringList('favoriteBuildings') ?? []);
    _recentSearchIds.clear();
    _recentSearchIds.addAll(prefs.getStringList('recentSearches') ?? []);
    _isReady = true;
    notifyListeners();
  }

  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void selectBuilding(CampusBuilding building) {
    _selectedBuilding = building;
    notifyListeners();
  }

  void clearSelectedBuilding() {
    _selectedBuilding = null;
    notifyListeners();
  }

  void toggleDarkMode() {
    _darkMode = !_darkMode;
    _saveBool('darkMode', _darkMode);
    notifyListeners();
  }

  void setOnboardingComplete() {
    _onboardingComplete = true;
    _saveBool('onboardingComplete', true);
    notifyListeners();
  }

  void resetOnboarding() {
    _onboardingComplete = false;
    _saveBool('onboardingComplete', false);
    notifyListeners();
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggleFavorite(CampusBuilding building) {
    if (isFavorite(building.id)) {
      removeFavorite(building.id);
    } else {
      addFavorite(building.id);
    }
  }

  void addFavorite(String id) {
    if (_favoriteIds.contains(id)) return;
    _favoriteIds.insert(0, id);
    _saveStringList('favoriteBuildings', _favoriteIds);
    notifyListeners();
    HapticFeedback.lightImpact();
  }

  void removeFavorite(String id) {
    if (_favoriteIds.remove(id)) {
      _saveStringList('favoriteBuildings', _favoriteIds);
      notifyListeners();
      HapticFeedback.selectionClick();
    }
  }

  void addRecentSearch(CampusBuilding building) {
    _recentSearchIds.remove(building.id);
    _recentSearchIds.insert(0, building.id);
    if (_recentSearchIds.length > 10) {
      _recentSearchIds.removeLast();
    }
    _saveStringList('recentSearches', _recentSearchIds);
    notifyListeners();
  }

  void clearRecentSearches() {
    _recentSearchIds.clear();
    _saveStringList('recentSearches', _recentSearchIds);
    notifyListeners();
  }

  CampusBuilding? findBuildingById(String id) {
    for (final building in campusBuildings) {
      if (building.id == id) {
        return building;
      }
    }
    return null;
  }
}
