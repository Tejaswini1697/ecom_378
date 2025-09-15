import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final String title, subtitle, image, buttonText;
  const BannerCard(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(image, fit: BoxFit.cover),
        Container(color: Colors.black.withOpacity(0.25)),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.1)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, height: 1.2)),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: cs.primary,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10)),
                  onPressed: () {},
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
