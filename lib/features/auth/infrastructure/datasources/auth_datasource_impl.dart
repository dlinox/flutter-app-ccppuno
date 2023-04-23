import 'package:ccp_puno_flutter/config/constants/environment.dart';
import 'package:ccp_puno_flutter/features/auth/domain/domain.dart';
import 'package:ccp_puno_flutter/features/auth/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';

class AuthDatasourcesImple extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiBaseUrl,
  ));

  @override
  Future<Usuario> checkSignIn(String token) async {
    //  await Future.delayed(const Duration(milliseconds: 5000));

    try {
      final response = await dio.get('/auth/check-token',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'applcation/json'
          }));

      final usuario = UsuarioMapper.usuarioJsonToEntity(response.data);
      return usuario;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthError('Token no valido');
      }
      if (e.type == DioErrorType.connectionTimeout) {
        throw AuthError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Usuario> signIn(String dni, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'dni': dni,
        'password': password,
      });

      final usuario = UsuarioMapper.usuarioJsonToEntity(response.data);
      return usuario;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthError(e.response?.data[0] ?? 'Credenciales incorrectas');
      }

      if (e.response?.statusCode == 400) {
        throw AuthError(
            e.response?.data[0] ?? 'El DNI no se encuentra registrado.');
      }
      if (e.type == DioErrorType.connectionTimeout) {
        throw AuthError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Usuario> signUp(String dni, String password) {
    throw UnimplementedError();
  }
}
