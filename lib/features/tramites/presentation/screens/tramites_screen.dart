import 'package:ccp_puno_flutter/features/shared/shared.dart';
import 'package:flutter/material.dart';

class TramitesScreen extends StatelessWidget {
  const TramitesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey, index: 3),
      appBar: AppBar(
        title: const Text('Pagos'),
      ),
      body: const Center(
        child: Text('Screen Tramites'),
      ),
    );
  }
}
