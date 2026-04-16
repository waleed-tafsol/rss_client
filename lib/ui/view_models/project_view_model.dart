import 'dart:developer';

import '../../models/responses/project_list_response.dart';
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

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setPage(int value) {
    page = value;
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
        log("historyData List ----------${historyProjectData}");
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
