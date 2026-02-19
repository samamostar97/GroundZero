import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_zero_core/ground_zero_core.dart';
import '../widgets/product_data_table.dart';

class DesktopProductsScreen extends ConsumerWidget {
  const DesktopProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(searchTermProvider);
    final page = ref.watch(currentPageProvider);
    final params = ProductsParams(page: page, pageSize: 20, searchTerm: search);
    final productsAsync = ref.watch(productsProvider(params));

    return Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text('Products', style: Theme.of(context).textTheme.headlineMedium),
        const Spacer(),
        SizedBox(width: 300, child: TextField(
          decoration: const InputDecoration(hintText: 'Search...', prefixIcon: Icon(Icons.search), isDense: true),
          onSubmitted: (v) { ref.read(searchTermProvider.notifier).state = v.isEmpty ? null : v;
            ref.read(currentPageProvider.notifier).state = 1; },
        )),
        const SizedBox(width: 16),
        FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Add Product')),
      ]),
      const SizedBox(height: 16),
      Expanded(child: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (result) => ProductDataTable(products: result.items, totalPages: result.totalPages, currentPage: page,
          onPageChanged: (p) => ref.read(currentPageProvider.notifier).state = p),
      )),
    ]));
  }
}