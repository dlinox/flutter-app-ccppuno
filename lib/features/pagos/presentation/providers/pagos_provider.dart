import 'package:ccp_puno_flutter/features/pagos/presentation/providers/pagos_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccp_puno_flutter/features/pagos/domain/domain.dart';

final pagosProvider = StateNotifierProvider<PagosNotifier, PagosState>((ref) {
  final pagosRepository = ref.watch(pagosRepositoryProvider);

  return PagosNotifier(pagosRepository: pagosRepository);
});

class PagosNotifier extends StateNotifier<PagosState> {
  final PagosRepository pagosRepository;

  PagosNotifier({required this.pagosRepository}) : super(PagosState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (state.isLoadding) return;
    state = state.copyWith(isLoadding: true);
    final pagos = await pagosRepository.getPagos();
    state = state.copyWith(
      isLoadding: false,
      page: 1,
      pagos: [...state.pagos, ...pagos],
    );
  }
}

class PagosState {
  final int page;
  final bool isLoadding;
  final List<Pago> pagos;

  PagosState({
    this.page = 1,
    this.isLoadding = false,
    this.pagos = const [],
  });

  PagosState copyWith({
    int? page,
    bool? isLoadding,
    List<Pago>? pagos,
  }) =>
      PagosState(
        page: page ?? this.page,
        isLoadding: isLoadding ?? this.isLoadding,
        pagos: pagos ?? this.pagos,
      );
}
