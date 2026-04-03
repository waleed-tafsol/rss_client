enum UserType { surveyors, clients }

enum CrudType {
  stock('Stock'),
  attributes('Attributes'),
  hhsrs('HHSRS'),
  sorCodes('SOR Codes');

  final String label;

  const CrudType(this.label);
}

enum InspectionStatus { inProgress, upcoming, completed }

enum PropertyDetailFilter { inspectionChecklist, modulesOverview, costSummary }

enum SettingsType { profile, password }
