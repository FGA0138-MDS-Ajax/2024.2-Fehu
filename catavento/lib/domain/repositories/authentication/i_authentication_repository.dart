import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IAuthenticationRepository {
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<User?> getCurrentUser();
}
