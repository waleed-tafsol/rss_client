import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../models/responses/project_list_response.dart';
part 'project_api.g.dart';

@RestApi()
abstract class ProjectApi {
  factory ProjectApi(Dio dio, {String? baseUrl}) = _ProjectApi;

  @GET('/projects/list')
  Future<ProjectListResponse> getProjectList();
}
