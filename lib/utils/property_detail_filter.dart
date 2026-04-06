import 'enums.dart';

extension PropertyDetailFilterExtension on PropertyDetailFilter {
  String get label {
    switch (this) {
      
      case PropertyDetailFilter.modulesOverview:
        return 'Modules Overview';
      case PropertyDetailFilter.costSummary:
        return 'Cost Summary';
    }
  }
}
    
  