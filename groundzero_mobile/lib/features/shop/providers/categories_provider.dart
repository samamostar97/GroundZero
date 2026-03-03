import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_repository.dart';
import '../models/category_model.dart';

final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.getCategories();
});
