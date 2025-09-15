import 'package:flutter/material.dart';

class NavIcon extends StatelessWidget {
  final IconData icon;
  VoidCallback onTap;
  NavIcon({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onTap, icon: Icon(icon, size: 26));
  }
}
