part of 'locator.dart';


class ProjectService {
  ProjectService._();

  Future<ProjectListResponse> getProjectList() async {
    final response = await locator<ProjectApi>().getProjectList();
   
    if (!response.success!) {
      throw const AppException('Something went wrong!');
    }
    return response;
  }
}
