import 'package:flutter/material.dart';
import 'package:ccp_puno_flutter/features/shared/shared.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey, index: 4),
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: const Center(
        child: Text('Screen Profile'),
      ),
    );
  }
}
