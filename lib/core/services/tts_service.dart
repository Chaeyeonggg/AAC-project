import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// flutter_tts를 감싸는 서비스.
/// 카드를 누르면 문구를 한국어 음성으로 읽어주는 데 사용합니다.
class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  Future<void> _init() async {
    if (_isInitialized) return;
    await _flutterTts.setLanguage('ko-KR');
    await _flutterTts.setSpeechRate(0.5); // 천천히, 또박또박
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    _isInitialized = true;
  }

  /// 주어진 텍스트를 음성으로 읽습니다.
  /// 이전에 재생 중이던 음성이 있으면 멈추고 새로 시작합니다.
  Future<void> speak(String text) async {
    await _init();
    await _flutterTts.stop();
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  void dispose() {
    _flutterTts.stop();
  }
}

/// 앱 전역에서 하나의 TtsService 인스턴스를 공유하기 위한 provider.
final ttsServiceProvider = Provider<TtsService>((ref) {
  final service = TtsService();
  ref.onDispose(() => service.dispose());
  return service;
});
