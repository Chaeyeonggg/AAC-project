import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  static String get baseUrl {
    try {
      return dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:3000';
    } catch (_) {
      return 'http://10.0.2.2:3000';
    }
  }

  static Dio create() {
    // 주의: Android 에뮬레이터에서는 localhost 대신 10.0.2.2를 써야
    // 여러분 컴퓨터(로컬 서버)에 접근할 수 있습니다.
    // iOS 시뮬레이터는 localhost 그대로 써도 됩니다.
    // 실제 폰으로 테스트할 땐 컴퓨터의 IP 주소(예: 192.168.0.x)를 써야 해요.
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
  }
}
