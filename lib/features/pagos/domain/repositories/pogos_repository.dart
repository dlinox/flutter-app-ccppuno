import 'package:ccp_puno_flutter/features/pagos/domain/entities/pago.dart';

abstract class PagosRepository {
  Future<List<Pago>> getPagos({int limit = 10, int offset = 0});
  Future<PagoResponse> getPagosPendientes(
      {String url = '/agremiado/pagos-pendientes'});
}
