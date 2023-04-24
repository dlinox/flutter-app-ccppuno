import 'package:ccp_puno_flutter/config/constants/environment.dart';
import 'package:ccp_puno_flutter/features/pagos/presentation/providers/pagos_pendientes_provider.dart';
import 'package:ccp_puno_flutter/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PagosScreen extends ConsumerStatefulWidget {
  const PagosScreen({Key? key}) : super(key: key);

  @override
  PagosScreenState createState() => PagosScreenState();
}

class PagosScreenState extends ConsumerState {
  @override
  void initState() {
    super.initState();

    ref.read(pagosPendientesProvider.notifier).loadPagosPendientes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final pagosState = ref.watch(pagosPendientesProvider);
    final String baseUrl = Environment.apiBaseUrl;

    return Scaffold(
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
        index: 1,
      ),
      appBar: AppBar(
        title: const Text('Pagos'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                    '* Aquí se muestran el estado de todos tus registros de pago mediante depósito en cuentas del Colegio de Contadores Públicos de Puno que tienen que ser validados.'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pagosState.pagos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(
                      Icons.payment_outlined,
                      size: 25,
                    ),
                    title: Text(
                      pagosState.pagos[index].concepto,
                    ),
                    subtitle: Text(
                      '${pagosState.pagos[index].fecha}  -  S/. ${pagosState.pagos[index].precio.toString()}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.redAccent,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              tooltip: 'Anterior',
              icon: const Icon(Icons.arrow_back),
              onPressed: pagosState.prevPageUrl == ''
                  ? null
                  : () {
                      String result =
                          pagosState.prevPageUrl.replaceAll(baseUrl, '');
                      ref
                          .read(pagosPendientesProvider.notifier)
                          .loadPagosPendientes(url: result);
                    },
            ),
            Text(
                '${pagosState.page.toString()}  / ${pagosState.lastPage.toString()}'),
            IconButton(
              tooltip: 'Siguiente',
              icon: const Icon(Icons.arrow_forward),
              onPressed: pagosState.nextPageUrl == ''
                  ? null
                  : () {
                      String result =
                          pagosState.nextPageUrl.replaceAll(baseUrl, '');
                      ref
                          .read(pagosPendientesProvider.notifier)
                          .loadPagosPendientes(url: result);
                    },
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Nuevo'),
        elevation: 1.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
