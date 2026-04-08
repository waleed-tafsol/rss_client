import '../../models/responses/project_list_response.dart';
import '../../services/locator.dart';
import 'base_view_model.dart';

class ProjectViewModel extends BaseViewModel {
  List<Project?> project = [];
  bool loading = false;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> getProjectList() async {
    return await runSafely(() async {
      setLoading(true);
      final user = await locator<ProjectService>().getProjectList();
      if (user.data != null) {
        project = user.data ?? [];
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
