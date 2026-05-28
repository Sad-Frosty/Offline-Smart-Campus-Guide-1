class AssetImages {
  static const defaultBuilding = 'assets/pic2.jpeg';
  static const mainGate = 'assets/WhatsApp Image 2026-05-14 at 2.17.32 AM.jpeg';
  static const uenrClinic =
      'assets/WhatsApp Image 2026-05-14 at 2.17.33 AM.jpeg';
  static const universityHall1 =
      'assets/WhatsApp Image 2026-05-08 at 10.55.31 PM.jpeg';
  static const schoolPark =
      'assets/WhatsApp Image 2026-05-14 at 2.17.35 AM (1).jpeg';
  static const sportOffice =
      'assets/WhatsApp Image 2026-05-14 at 2.17.34 AM (1).jpeg';
  static const ltBlock =
      'assets/WhatsApp Image 2026-05-14 at 2.17.34 AM (2).jpeg';
  static const odumBlock =
      'assets/WhatsApp Image 2026-05-14 at 2.17.35 AM.jpeg';
  static const oldAuditorium =
      'assets/WhatsApp Image 2026-05-14 at 2.17.34 AM.jpeg';
  static const schoolCafeteria =
      'assets/WhatsApp Image 2026-05-14 at 2.17.33 AM (1).jpeg';
  static const drivingSchool =
      'assets/WhatsApp Image 2026-05-08 at 10.55.31 PM.jpeg';
  static const itDepartment =
      'assets/WhatsApp Image 2026-05-08 at 10.55.31 PM.jpeg';

  static const Map<String, String?> buildingImageMap = {
    // Core unique mappings (enforce exclusivity per request)
    'main_gate': mainGate,
    'school_of_sciences': defaultBuilding, // pic2.jpeg assigned exclusively
    'sh_block': odumBlock, // odum image belongs only to SH Block
    'odum_block': uenrClinic, // Odum block uses UENR Clinic image
    'university_hall1': universityHall1,
    'rcees_building': schoolPark,
    'school_cafeteria': schoolCafeteria,
    'old_auditorium': oldAuditorium,
    'administration_block': sportOffice,
    'lib_block': ltBlock,
  };

  static String? forBuildingId(String id) {
    return buildingImageMap[id];
  }
}
