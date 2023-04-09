import 'package:ccp_puno_flutter/features/pagos/presentation/providers/pagos_provider.dart';
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

    ref.read(pagosProvider.notifier).loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final pagosState = ref.watch(pagosProvider);

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
      body: Padding(
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
    );
  }
}
