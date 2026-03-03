import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/cart_badge.dart';
import '../../../shared/widgets/category_chip.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/product_card.dart';
import '../../../shared/widgets/skeletons.dart';
import '../../orders/providers/cart_provider.dart';
import '../providers/categories_provider.dart';
import '../providers/products_provider.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(productsNotifierProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(productsNotifierProvider.notifier).setSearch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsNotifierProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final cartItemCount = ref.watch(
      cartNotifierProvider.select((cart) => cart.itemCount),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header + Search + Cart
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Text('Shop', style: AppTextStyles.heading1),
                  const Spacer(),
                  CartBadge(
                    itemCount: cartItemCount,
                    onTap: () => context.push('/cart'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                style: AppTextStyles.input,
                decoration: InputDecoration(
                  hintText: 'Pretraži proizvode...',
                  hintStyle: AppTextStyles.inputHint,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.textHint,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppColors.textHint,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            ref
                                .read(productsNotifierProvider.notifier)
                                .setSearch(null);
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Category chips
            categoriesAsync.when(
              loading: () => const SizedBox(height: 40),
              error: (_, _) => const SizedBox.shrink(),
              data: (categories) => SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categories.length + 1,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CategoryChip(
                        label: 'Sve',
                        isSelected: productsState.categoryId == null,
                        onTap: () => ref
                            .read(productsNotifierProvider.notifier)
                            .setCategoryId(null),
                      );
                    }
                    final category = categories[index - 1];
                    return CategoryChip(
                      label: category.name,
                      isSelected:
                          productsState.categoryId == category.id,
                      onTap: () => ref
                          .read(productsNotifierProvider.notifier)
                          .setCategoryId(category.id),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Product grid
            Expanded(
              child: RefreshIndicator(
                color: AppColors.accent,
                onRefresh: () async {
                  ref
                      .read(productsNotifierProvider.notifier)
                      .loadInitial();
                },
                child: _buildProductGrid(productsState),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(ProductsState state) {
    if (state.isLoading && state.products.isEmpty) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.62,
        ),
        itemCount: 6,
        itemBuilder: (_, _) => const ProductCardSkeleton(),
      );
    }

    if (state.products.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 100),
          EmptyState(
            icon: Icons.storefront_outlined,
            message: 'Nema proizvoda za prikaz.',
          ),
        ],
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemCount: state.products.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.products.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(
                color: AppColors.accent,
                strokeWidth: 2,
              ),
            ),
          );
        }

        final product = state.products[index];
        return ProductCard(
          id: product.id,
          name: product.name,
          categoryName: product.categoryName,
          price: product.price,
          imageUrl: product.imageUrl,
          onTap: () => context.push('/shop/${product.id}'),
        );
      },
    );
  }
}
