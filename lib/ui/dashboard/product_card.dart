import 'package:flutter/material.dart';

import '../../data/remote/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  const ProductCard({required this.product});
  @override
  State<ProductCard> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  bool fav = false;
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image + heart
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Image.network(p.image!, fit: BoxFit.cover),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () => setState(() => fav = !fav),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2))
                      ],
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      fav ? Icons.favorite : Icons.favorite_border,
                      color: fav ? cs.primary : Colors.black54,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(p.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('\$${p.price}',
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
          ),
          const SizedBox(height: 6),
          /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: List.generate(
                p.colors.length.clamp(0, 5),
                (i) => GestureDetector(
                  onTap: () => setState(() => selectedColor = i),
                  child: Container(
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: i == selectedColor
                            ? cs.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: p.colors[i],
                    ),
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
