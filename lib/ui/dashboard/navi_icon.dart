import 'package:flutter/material.dart';

class NavIcon extends StatelessWidget {
  final IconData icon;
  const NavIcon({required this.icon});
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(icon, size: 26));
  }
}
