enum UserType { client, surveyor, admin }

enum CrudType {
  stock('Stock'),
  attributes('Attributes'),
  hhsrs('HHSRS'),
  sorCodes('SOR Codes');

  final String label;

  const CrudType(this.label);


}

enum Status {
  inprogress,
  upcoming,
  completed;

  static Status? fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'inprogress':
        return Status.inprogress;
      case 'completed':
        return Status.completed;
      default:
        return null;
    }
  }

  String get label {
    switch (this) {
      case Status.inprogress:
        return 'In Progress';
      case Status.completed:
        return 'Completed';
      case Status.upcoming:
        return 'Upcoming';
    }
  }
}

enum InspectionStatus { inprogress, upcoming, completed }

enum PropertyDetailFilter { modulesOverview, costSummary }

enum SettingsType { profile, password }

enum AuthView { login, forgotPassword, otp, resetPassword }
