import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  final _supabase = Supabase.instance.client;

  Future<AuthResponse> logIn(String icNo, String password) async {
    return await _supabase.auth.signInWithPassword(
        password: "KOROBORI$password", email: "$icNo@nonexistent.com");
  }
}
