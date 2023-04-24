import 'package:ccp_puno_flutter/config/constants/environment.dart';
import 'package:ccp_puno_flutter/features/pagos/domain/domain.dart';
import 'package:ccp_puno_flutter/features/pagos/infrastructure/mappers/pagos_mapper.dart';
import 'package:dio/dio.dart';

class PagosDatasourceImpl extends PagosDatasource {
  late final Dio dio;
  final String token;

  PagosDatasourceImpl({required this.token})
      : dio = Dio(BaseOptions(baseUrl: Environment.apiBaseUrl, headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'applcation/json'
        }));

  @override
  Future<List<Pago>> getPagos({int limit = 10, int offset = 0}) async {
    final res = await dio.get('/agremiado/pagos-pendientes');

    final List<Pago> pagos = [];
    for (final pago in res.data['data'] ?? []) {
      pagos.add(PagoMapper.jsonToEntity(pago));
    }
    return pagos;
  }

  @override
  Future<PagoResponse> getPagosPendientes(
      {String url = '/agremiado/pagos-pendientes'}) async {
    final res = await dio.get(url);
    final PagoResponse pagoResponse = PagoResponseMapper.jsonToEntity(res.data);
    return pagoResponse;
  }
}
