import '../../models/responses/project_list_response.dart';
import '../../models/responses/property_detail_response.dart';
import '../../models/responses/user_history_response.dart';
import '../../services/locator.dart';
import 'base_view_model.dart';

class ProjectViewModel extends BaseViewModel {
  int totalPages = 0;
  int page = 1;
  int limit = 12;
  List<Project?> project = [];
  bool loading = false;

  List<HistoryData?> historyProjectData = [];
  PropertyDetailResponse propertyDetailData = PropertyDetailResponse();

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setPage(int value) {
    page = value;
  }

  int? _selectedPropertyId;
  int? get selectedPropertyId => _selectedPropertyId;

  void setSelectedPropertyId(int? value) {
    _selectedPropertyId = value;
    locator<StorageService>().saveSelectedPropertyId(value?.toString());
    notifyListeners();
  }

  Future<void> getProjectList() async {
    return await runSafely(() async {
      setLoading(true);
      final projectListResponse = await locator<ProjectService>()
          .getProjectList(page: page, limit: limit);
      if (projectListResponse.data != null) {
        project = projectListResponse.data ?? [];
        totalPages = projectListResponse.totalPages ?? 0;
      }
      setLoading(false);
    });
  }

  Future<void> getHistoryProjectList() async {
    return await runSafely(() async {
      setLoading(true);
      final projectListResponse = await locator<ProjectService>()
          .getUserHistory();
      if (projectListResponse.isNotEmpty) {
        historyProjectData = projectListResponse;
      }
      setLoading(false);
    });
  }

  Future<void> getPropertyDetail() async {
    return await runSafely(() async {
      setLoading(true);
      final propertDetail = await locator<ProjectService>().getPropertyDetail(
        id: _selectedPropertyId ?? 0,
      );
      if (propertDetail.success!) {
        propertyDetailData = propertDetail;
      }
      setLoading(false);
    });
  }

  @override
  handleError(message) {
    loading = false;
    notifyListeners();
    super.handleError(message);
  }
}
