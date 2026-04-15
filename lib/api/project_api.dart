import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../models/responses/project_list_response.dart';
import '../models/responses/user_history_response.dart';
part 'project_api.g.dart';

@RestApi()
abstract class ProjectApi {
  factory ProjectApi(Dio dio, {String? baseUrl}) = _ProjectApi;

  @GET('/projects/list')
  Future<ProjectListResponse> getProjectList(
     @Query('page')
  int? page,
  @Query('limit')
  int? limit,
  );
  @GET("/users/get-user-history")
  Future<UserHistoryResponse> getProjectListByUser(@Query('id') int? id);
}
