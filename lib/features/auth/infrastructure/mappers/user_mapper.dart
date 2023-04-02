import 'package:ccp_puno_flutter/features/auth/domain/domain.dart';

class UsuarioMapper {
  static Usuario usuarioJsonToEntity(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        nombre: json['nombre'],
        correo: json['correo'],
        matricula: json['matricula'],
        direccion: json['direccion'],
        dni: json['dni'],
        movil: json['movil'],
        habil: json['habil'],
        token: json['token'],
      );
}
