import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_zero_core/ground_zero_core.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../widgets/product_card.dart';

class MobileProductsScreen extends ConsumerWidget {
  const MobileProductsScreen({super.key});

  @override Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(searchTermProvider);
    final page = ref.watch(currentPageProvider);
    final params = ProductsParams(page: page, searchTerm: search);
    final products = ref.watch(productsProvider(params));

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: TextField(
          decoration: InputDecoration(hintText: 'Search products...', prefixIcon: const Icon(Icons.search),
            suffixIcon: search != null ? IconButton(icon: const Icon(Icons.clear), onPressed: () {
              ref.read(searchTermProvider.notifier).state = null; ref.read(currentPageProvider.notifier).state = 1;
            }) : null),
          onSubmitted: (v) { ref.read(searchTermProvider.notifier).state = v.isEmpty ? null : v;
            ref.read(currentPageProvider.notifier).state = 1; },
        )),
        Expanded(child: products.when(
          loading: () => const LoadingWidget(message: 'Loading...'),
          error: (e, _) => AppErrorWidget(message: '$e', onRetry: () => ref.invalidate(productsProvider(params))),
          data: (result) {
            if (result.items.isEmpty) return const Center(child: Text('No products found.'));
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(productsProvider(params)),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: result.items.length,
                itemBuilder: (_, i) => ProductCard(product: result.items[i]),
              ),
            );
          },
        )),
      ]),
    );
  }
}