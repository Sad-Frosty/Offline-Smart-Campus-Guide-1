class AssetImages {
  static const defaultBuilding = 'assets/images/MAIN GATE.jpeg';
  static const mainGate = 'assets/images/MAIN GATE.jpeg';
  static const uenrClinic = 'assets/images/MAIN GATE.jpeg';
  static const universityHall1 = 'assets/images/UNIVERSITY HALL!.jpeg';
  static const sportOffice = 'assets/images/MAIN GATE.jpeg';
  static const ltBlock = 'assets/images/LT BLOCK.jpeg';
  static const odumBlock = 'assets/images/ODUM BLOCK.jpeg';
  static const oldAuditorium = 'assets/images/OLD AUDITORIUM.jpeg';
  static const schoolCafeteria = 'assets/images/CAFETERIA.jpeg';
  static const leoBlock = 'assets/images/LEO BLOCK.png';
  static const itDepartment = 'assets/images/IT DEPARTMENT.png';
  static const AdministrationBlock = 'assets/images/ADMINISTRATION BLOCK.jpeg';
  static const SyndicateHall = 'assets/images/SYNDICATE HALL.png';
  static const RCEESBuilding = 'assets/images/RCEES.jpeg';
  static const SchoolOfSciences = 'assets/images/SCHOOL OF SCIENCES.jpeg';
  static const lib = 'assets/images/LIB.jpeg';
  static const schoolpark = 'assets/images/SCHOOL PARK.jpeg';
  static const appLab = 'assets/images/APP LAB.png';
  static const NursingSkillLab = 'assets/images/NURSING SKILLS LAB.png';

  static const Map<String, String?> buildingImageMap = {
    // Core unique mappings (enforce exclusivity per request)
    'main_gate': mainGate,
    'school_of_sciences':
        SchoolOfSciences, // School of Sciences has its own unique image
    'syndicate_hall': SyndicateHall, // Syndicate Hall image
    'odum_block': odumBlock, // Odum block uses Odum Block image
    'university_hall1': universityHall1,
    'rcees_building': RCEESBuilding,
    'school_cafeteria': schoolCafeteria,
    'old_auditorium': oldAuditorium,
    'administration_block': AdministrationBlock,
    'lib_block': lib,
    'school_park': schoolpark,
    'uenrClinic': uenrClinic,
    'sportOffice': sportOffice,
    'leo_block': leoBlock,
    'it_department': itDepartment,
    'lt_block': ltBlock,
    'app_lab': appLab,
    'nursing_skill_lab': NursingSkillLab,
  };

  static String? forBuildingId(String id) {
    return buildingImageMap[id];
  }
}
