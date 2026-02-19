import 'package:flutter/material.dart';
import 'package:ground_zero_core/ground_zero_core.dart';

class ProductDataTable extends StatelessWidget {
  final List<ProductModel> products;
  final int totalPages;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const ProductDataTable({super.key, required this.products, required this.totalPages,
    required this.currentPage, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(children: [
      Expanded(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: SingleChildScrollView(child:
        DataTable(
          headingRowColor: WidgetStateProperty.all(Theme.of(context).colorScheme.surfaceContainerHighest),
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Price'), numeric: true),
            DataColumn(label: Text('Stock'), numeric: true),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: products.map((p) => DataRow(cells: [
            DataCell(Text(p.name)),
            DataCell(Text('\$${p.price.toStringAsFixed(2)}')),
            DataCell(Text('${p.stockQuantity}')),
            DataCell(_StatusChip(status: p.status)),
            DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.edit, size: 20), onPressed: () {}),
              IconButton(icon: const Icon(Icons.delete, size: 20, color: Colors.red), onPressed: () {}),
            ])),
          ])).toList(),
        ),
      ))),
      Padding(padding: const EdgeInsets.all(8), child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null, icon: const Icon(Icons.chevron_left)),
        Text('Page $currentPage of $totalPages'),
        IconButton(onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null, icon: const Icon(Icons.chevron_right)),
      ])),
    ]));
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});
  @override Widget build(BuildContext context) {
    final color = switch (status.toLowerCase()) { 'active' => Colors.green, 'draft' => Colors.orange, 'outofstock' => Colors.red, _ => Colors.grey };
    return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)));
  }
}