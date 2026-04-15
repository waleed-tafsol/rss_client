part of 'locator.dart';

class ProjectService {
  ProjectService._();

  Future<ProjectListResponse> getProjectList({
    required int page,
    required int limit,
  }) async {
    final response = await locator<ProjectApi>().getProjectList(page, limit);

    if (!response.success!) {
      throw const AppException('Something went wrong!');
    }
    return response;
  }

  Future<List<HistoryData>> getUserHistory() async {
    final user = await locator<StorageService>().getUser();
    final response = await locator<ProjectApi>().getProjectListByUser(
      user?.profile?.userId,
    );
   
    if (response.success != true || response.data == null) {
      throw AppException(
        response.message ?? 'Something went wrong!',
      );
    }
    return response.data!;
  }
}
