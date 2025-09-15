import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String image;
  final List<Color> colors;
  const Product(
      {required this.name,
      required this.price,
      required this.image,
      required this.colors});
}
