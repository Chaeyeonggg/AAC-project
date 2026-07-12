import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

class SimpleLoginScreen extends ConsumerStatefulWidget {
  const SimpleLoginScreen({super.key});

  @override
  ConsumerState<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends ConsumerState<SimpleLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String resultMessage = '';

  Future<void> _signup() async {
    final authRepo = ref.read(authRepositoryProvider);
    try {
      await authRepo.signup(
        email: emailController.text,
        password: passwordController.text,
      );
      setState(() => resultMessage = '회원가입 성공!');
    } catch (e) {
      setState(() => resultMessage = e.toString());
    }
  }

  Future<void> _login() async {
    final authRepo = ref.read(authRepositoryProvider);
    try {
      await authRepo.login(
        email: emailController.text,
        password: passwordController.text,
      );
      setState(() => resultMessage = '로그인 성공! (토큰 저장됨)');
    } catch (e) {
      setState(() => resultMessage = e.toString());
    }
  }

  Future<void> _loginWithKakao() async {
    final authRepo = ref.read(authRepositoryProvider);
    try {
      await authRepo.loginWithKakao();
      setState(() => resultMessage = '카카오 로그인 성공!');
    } catch (e) {
      setState(() => resultMessage = e.toString());
    }
  }

  Future<void> _loginWithNaver() async {
    final authRepo = ref.read(authRepositoryProvider);
    try {
      await authRepo.loginWithNaver();
      setState(() => resultMessage = '네이버 로그인 성공!');
    } catch (e) {
      setState(() => resultMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인 테스트')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _loginWithKakao,
              child: const Text('카카오 로그인'),
            ),
            ElevatedButton(
              onPressed: _loginWithNaver,
              child: const Text('네이버 로그인'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _signup, child: const Text('회원가입')),
            ElevatedButton(onPressed: _login, child: const Text('로그인')),
            const SizedBox(height: 16),
            Text(resultMessage),
          ],
        ),
      ),
    );
  }
}
