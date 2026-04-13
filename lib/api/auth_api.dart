import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../models/requests/email_request.dart';
import '../models/requests/login_request.dart';
import '../models/requests/reset_password_request.dart';
import '../models/requests/verify_otp_request.dart';
import '../models/responses/auth_response.dart';
import '../models/responses/base_response.dart';
import '../models/responses/get_me_response.dart';
import '../models/responses/verify_otp_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  @POST('/login')
  Future<AuthResponse> login(@Body() LoginRequest body);

  @POST('/logout')
  Future<BaseResponse> logout();

  @POST('/forgot-password')
  Future<BaseResponse> forgotPassword(@Body() EmailRequest request);

  @POST('/verify-otp')
  Future<VerifyOtpResponse> verifyOtp(@Body() VerifyOtpRequest request);

  @POST('/reset-password')
  Future<BaseResponse> resetPassword(@Body() ResetPasswordRequest request);

  @GET('/user/me')
  Future<GetMeResponse> getMe();

  @MultiPart()
  @POST('/profile/update')
  Future<BaseResponse> updateUser({
    @Part() String? name,
    @Part(name: 'contact_number') String? contactNumber,
    @Part(name: 'profile_image') List<int>? profileImage,
  });
}
