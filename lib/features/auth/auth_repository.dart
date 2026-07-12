import 'package:dio/dio.dart';
import '../../core/api_client.dart';
import '../../core/secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'dart:developer' as developer;
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class AuthRepository {
  late final Dio _dio = ApiClient.create();

  // 회원가입
  Future<void> signup({required String email, required String password}) async {
    try {
      await _dio.post(
        '/auth/signup',
        data: {'email': email, 'password': password},
      );
    } on DioException catch (e) {
      // 백엔드가 보내는 에러 메시지를 그대로 꺼내서 던짐 (예: "이미 가입된 이메일입니다.")
      final message = e.response?.data['error'] ?? '회원가입에 실패했습니다.';
      throw Exception(message);
    }
  }

  // 이메일 로그인
  Future<void> login({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final token = response.data['token'];
      await SecureStorage.saveToken(token); // 토큰 저장까지 여기서 처리
    } on DioException catch (e) {
      final message = e.response?.data['error'] ?? '로그인에 실패했습니다.';
      throw Exception(message);
    }
  }

  // 카카오 로그인
  Future<void> loginWithKakao() async {
    try {
      // 1. 카카오톡 설치 여부 확인 후 로그인 방식 분기
      bool installed = await isKakaoTalkInstalled();
      OAuthToken kakaoToken = installed
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      // 2. 카카오에서 받은 accessToken을 우리 백엔드로 전송
      final response = await _dio.post(
        '/auth/kakao',
        data: {'accessToken': kakaoToken.accessToken},
      );

      // 3. 우리 백엔드가 발급한 JWT를 저장
      final ourToken = response.data['token'];
      await SecureStorage.saveToken(ourToken);
    } catch (e) {
      throw Exception('카카오 로그인에 실패했습니다: $e');
    }
  }

  // 네이버 로그인
  Future<void> loginWithNaver() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: '${ApiClient.baseUrl}/auth/naver/start',
        callbackUrlScheme: 'com.example.aac',
      );

      final uri = Uri.parse(result);
      final ourToken = uri.queryParameters['token'];

      if (ourToken == null) {
        throw Exception('네이버 로그인에 실패했습니다.');
      }

      await SecureStorage.saveToken(ourToken);
    } catch (e) {
      throw Exception('네이버 로그인에 실패했습니다: $e');
    }
  }

  // 로그아웃
  Future<void> logout() async {
    await SecureStorage.deleteToken();
  }
}
