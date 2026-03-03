import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_repository.dart';
import '../models/recommended_product_model.dart';

final recommendationsProvider =
    FutureProvider<List<RecommendedProductModel>>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.getUserRecommendations(limit: 10);
});
