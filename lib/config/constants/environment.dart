import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String baseUrlApi =
      dotenv.env['BASE_URL_API'] ?? 'Definir una base url';
}
