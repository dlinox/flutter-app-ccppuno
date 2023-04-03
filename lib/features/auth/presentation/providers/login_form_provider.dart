import 'package:ccp_puno_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:ccp_puno_flutter/features/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final signInCallback = ref.watch(authProvider.notifier).singIn;

  return LoginFormNotifier(signInCallback: signInCallback);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) signInCallback;

  LoginFormNotifier({required this.signInCallback}) : super(LoginFormState());

  onDniChange(String value) {
    final newDni = Dni.dirty(value);
    state = state.copyWiht(
        dni: newDni, isValid: Formz.validate([newDni, state.password]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWiht(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.dni]));
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWiht(isLoading: true);

    await signInCallback(state.dni.value, state.password.value);

    state = state.copyWiht(isLoading: false);
  }

  _touchEveryField() {
    final dni = Dni.dirty(state.dni.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWiht(
        isSubmit: true,
        dni: dni,
        password: password,
        isValid: Formz.validate([dni, password]));
  }
}

class LoginFormState {
  final bool isLoading;
  final bool isSubmit;
  final bool isValid;
  final Password password;
  final Dni dni;

  LoginFormState({
    this.isLoading = false,
    this.isSubmit = false,
    this.isValid = false,
    this.password = const Password.pure(),
    this.dni = const Dni.pure(),
  });

  LoginFormState copyWiht({
    bool? isLoading,
    bool? isSubmit,
    bool? isValid,
    Password? password,
    Dni? dni,
  }) =>
      LoginFormState(
        isLoading: isLoading ?? this.isLoading,
        isSubmit: isSubmit ?? this.isSubmit,
        isValid: isValid ?? this.isValid,
        password: password ?? this.password,
        dni: dni ?? this.dni,
      );

  @override
  String toString() {
    return '''
    LoginFormState;
      isLogget: $isLoading
      isSubmit: $isSubmit
      isValid: $isValid
      password: $password
      dni: $dni
    ''';
  }
}
