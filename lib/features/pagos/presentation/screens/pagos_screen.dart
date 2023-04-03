import 'package:ccp_puno_flutter/features/shared/shared.dart';
import 'package:flutter/material.dart';

class PagosScreen extends StatelessWidget {
  const PagosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

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
      body: const Center(
        child: Text('Screen Pagos'),
      ),
    );
  }
}
