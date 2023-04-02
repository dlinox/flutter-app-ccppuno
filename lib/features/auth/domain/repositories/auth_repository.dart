import 'package:ccp_puno_flutter/features/auth/domain/entities/usuario.dart';

abstract class AuthRepository {
  Future<Usuario> signIn(String dni, String password);
  Future<Usuario> signUp(
      String dni, String password); //implementacion del registro;

  Future<Usuario> checkSignIn(String token);

  Future<void> signOut();
}
