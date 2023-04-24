import 'package:ccp_puno_flutter/features/pagos/presentation/providers/pagos_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccp_puno_flutter/features/pagos/domain/domain.dart';

final pagosPendientesProvider =
    StateNotifierProvider<PagosPendientesNotifier, PagosPenedientesState>(
        (ref) {
  final pagosRepository = ref.watch(pagosRepositoryProvider);

  return PagosPendientesNotifier(pagosRepository: pagosRepository);
});

class PagosPendientesNotifier extends StateNotifier<PagosPenedientesState> {
  final PagosRepository pagosRepository;

  PagosPendientesNotifier({required this.pagosRepository})
      : super(PagosPenedientesState()) {
    //loadPagosPendientes();
  }

  Future loadPagosPendientes(
      {String url = '/agremiado/pagos-pendientes'}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (state.isLoadding) return;
    state = state.copyWith(isLoadding: true);

    final pagoResponse = await pagosRepository.getPagosPendientes(url: url);

    state = state.copyWith(
      isLoadding: false,
      page: pagoResponse.page,
      total: pagoResponse.total,
      lastPage: pagoResponse.lastPage,
      nextPageUrl: pagoResponse.nextPageUrl ?? '',
      prevPageUrl: pagoResponse.prevPageUrl ?? '',
      pagos: [...pagoResponse.pagos],
    );
  }
}

class PagosPenedientesState {
  final int page;
  final int total;
  final int lastPage;
  final String nextPageUrl;
  final String prevPageUrl;
  final bool isLoadding;
  final List<Pago> pagos;

  PagosPenedientesState({
    this.page = 1,
    this.total = 1,
    this.lastPage = 1,
    this.nextPageUrl = '',
    this.prevPageUrl = '',
    this.isLoadding = false,
    this.pagos = const [],
  });

  PagosPenedientesState copyWith({
    int? page,
    int? total,
    int? lastPage,
    String? nextPageUrl,
    String? prevPageUrl,
    bool? isLoadding,
    List<Pago>? pagos,
  }) =>
      PagosPenedientesState(
        page: page ?? this.page,
        total: total ?? this.total,
        lastPage: lastPage ?? this.lastPage,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        isLoadding: isLoadding ?? this.isLoadding,
        pagos: pagos ?? this.pagos,
      );
}
