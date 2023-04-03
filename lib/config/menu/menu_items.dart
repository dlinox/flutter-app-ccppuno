import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: 'Home',
      subTitle: 'Introducción a riverpod',
      link: '/',
      icon: Icons.add),
  MenuItem(
      title: 'Pagos',
      subTitle: 'Varios botones en Flutter',
      link: '/pagos',
      icon: Icons.smart_button_outlined),
  MenuItem(
      title: 'Certificados',
      subTitle: 'Un contenedor estilizado',
      link: '/certificados',
      icon: Icons.credit_card),
  MenuItem(
      title: 'Tramites',
      subTitle: 'Generales y controlados',
      link: '/tramites',
      icon: Icons.refresh_rounded),
  MenuItem(
      title: 'Perfil',
      subTitle: 'Indicadores en pantalla',
      link: '/profile',
      icon: Icons.info_outline),
];
