import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String apiBaseUrl =
      dotenv.env['API_BASE_URL_DEV'] ?? 'Definir una base url';
}
//API_BASE_URL
//API_BASE_URL_DEV