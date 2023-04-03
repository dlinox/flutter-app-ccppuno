import 'package:ccp_puno_flutter/features/shared/infrastructure/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ccp_puno_flutter/features/auth/domain/domain.dart';
import 'package:ccp_puno_flutter/features/auth/infrastructure/infrastructure.dart';
import 'package:ccp_puno_flutter/features/shared/infrastructure/services/storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  final storageService = StorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    storageService: storageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final StorageService storageService;

  AuthNotifier({
    required this.authRepository,
    required this.storageService,
  }) : super(AuthState()) {
    checkSingIn();
  }

  void checkSingIn() async {
    final token = await storageService.getValue<String>('token');
    if (token == null) return singOut();

    try {
      final usuario = await authRepository.checkSignIn(token);
      _setCurrenUser(usuario);
    } catch (e) {
      singOut();
    }
  }

  Future<void> singIn(String dni, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final usuario = await authRepository.signIn(dni, password);
      _setCurrenUser(usuario);
    } on AuthError catch (e) {
      singOut(errorMessage: e.message);
    } catch (e) {
      singOut(errorMessage: 'Error inesperado, intente nuevamente');
    }
  }

  void singUp() {}

  Future<void> singOut({String? errorMessage}) async {
    await storageService.removeKey('token');
    state = state.copyWith(
        usuario: null,
        errorMessage: errorMessage,
        authStatus: AuthStatus.noAuthenticated);
  }

  void _setCurrenUser(Usuario usuario) async {
    await storageService.setValue('token', usuario.token);

    state = state.copyWith(
      usuario: usuario,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }
}

enum AuthStatus { checking, authenticated, noAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final Usuario? usuario;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.usuario,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    Usuario? usuario,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          usuario: usuario ?? this.usuario,
          errorMessage: errorMessage ?? this.errorMessage);
}
