import 'package:flutter/material.dart';
import 'package:machine_test/models/homemodel.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final double width;

  const ProductCard({super.key, required this.product, this.width = 160});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image + Favorite Icon ──
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: widget.product.image != null
                      ? Image.network(
                          widget.product.image!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                          },
                          errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
                        )
                      : Container(color: Colors.grey[200]),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () => setState(() => _isFavorite = !_isFavorite),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: _isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Category Label ──
                Text(
                  widget.product.category ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
                const SizedBox(height: 2),

                // ── Product Name ──
                Text(
                  widget.product.name ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),

                // ── Prices ──
                Row(
                  children: [
                    Text(
                      "₹ ${widget.product.price ?? ""}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    if (widget.product.price != null && widget.product.price!.isNotEmpty)
                      Text(
                        "₹ ${widget.product.price}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // ── Add to Cart Button ──
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
            child: SizedBox(
              width: double.infinity,
              height: 36,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: handle add to cart
                },
                icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                label: const Text(
                  "Add",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
