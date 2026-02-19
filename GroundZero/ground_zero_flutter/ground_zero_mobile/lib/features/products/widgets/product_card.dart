import 'package:flutter/material.dart';
import 'package:ground_zero_core/ground_zero_core.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(margin: const EdgeInsets.only(bottom: 12), child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
      Container(width: 64, height: 64, decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
        child: product.imageUrl != null
          ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(product.imageUrl!, fit: BoxFit.cover))
          : Icon(Icons.inventory_2, color: theme.colorScheme.primary)),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(product.name, style: theme.textTheme.titleMedium),
        if (product.description != null) Text(product.description!, maxLines: 2, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodySmall),
        const SizedBox(height: 4),
        Text('\$${product.price.toStringAsFixed(2)}',
          style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
      ])),
    ])));
  }
}