import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_repository.dart';
import '../models/product_model.dart';

final productDetailProvider =
    FutureProvider.family<ProductModel, int>((ref, productId) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.getProductById(productId);
});
