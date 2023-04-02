import 'package:ccp_puno_flutter/features/auth/domain/domain.dart';
import 'package:ccp_puno_flutter/features/auth/infrastructure/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({AuthDatasource? datasource})
      : datasource = datasource ?? AuthDatasourcesImple();

  @override
  Future<Usuario> checkSignIn(String token) {
    return datasource.checkSignIn(token);
  }

  @override
  Future<Usuario> signIn(String dni, String password) {
    return datasource.signIn(dni, password);
  }

  @override
  Future<void> signOut() {
    return datasource.signOut();
  }

  @override
  Future<Usuario> signUp(String dni, String password) {
    return datasource.signIn(dni, password);
  }
}
