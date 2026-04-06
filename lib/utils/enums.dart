enum UserType { client, surveyor, admin }

enum CrudType {
  stock('Stock'),
  attributes('Attributes'),
  hhsrs('HHSRS'),
  sorCodes('SOR Codes');

  final String label;

  const CrudType(this.label);
}

enum InspectionStatus { inProgress, upcoming, completed }

enum PropertyDetailFilter { modulesOverview, costSummary }

enum SettingsType { profile, password }

enum AuthView { login, forgotPassword, otp, resetPassword }
