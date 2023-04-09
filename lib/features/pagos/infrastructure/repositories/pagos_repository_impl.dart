import 'package:ccp_puno_flutter/features/pagos/domain/domain.dart';

class PagosRepositoryImpl extends PagosRepository {
  final PagosDatasource datasource;

  PagosRepositoryImpl(this.datasource);

  @override
  Future<List<Pago>> getPagos({int limit = 10, int offset = 0}) {
    return datasource.getPagos(limit: limit, offset: offset);
  }

  @override
  Future<List<Pago>> getPagosPendientes({int limit = 10, int offset = 0}) {
    return datasource.getPagosPendientes(limit: limit, offset: offset);
  }
}
