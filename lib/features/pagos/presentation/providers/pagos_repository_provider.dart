//Establecer la ntancia de Pagos repositories implementation
import 'package:ccp_puno_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:ccp_puno_flutter/features/pagos/infrastructure/datasources/pagos_datasource_impl.dart';
import 'package:ccp_puno_flutter/features/pagos/infrastructure/repositories/pagos_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccp_puno_flutter/features/pagos/domain/domain.dart';

class PagosRepositoryProvider {}

final pagosRepositoryProvider = Provider<PagosRepository>((ref) {
  final token =
      ref.watch(authProvider).usuario!.token; // op: storageService get token

  final pagosRepository =
      PagosRepositoryImpl(PagosDatasourceImpl(token: token));
  return pagosRepository;
});
