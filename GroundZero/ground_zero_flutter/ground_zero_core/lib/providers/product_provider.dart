import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/paged_result.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';

final productsProvider = FutureProvider.family.autoDispose<PagedResult<ProductModel>, ProductsParams>((ref, params) =>
    ref.read(productRepositoryProvider).getProducts(page: params.page, pageSize: params.pageSize,
      searchTerm: params.searchTerm, sortBy: params.sortBy, sortDescending: params.sortDescending));

final productDetailProvider = FutureProvider.family.autoDispose<ProductModel, String>((ref, id) =>
    ref.read(productRepositoryProvider).getById(id));

final searchTermProvider = StateProvider<String?>((ref) => null);
final currentPageProvider = StateProvider<int>((ref) => 1);

class ProductsParams {
  final int page; final int pageSize; final String? searchTerm; final String? sortBy; final bool sortDescending;
  const ProductsParams({this.page = 1, this.pageSize = 10, this.searchTerm, this.sortBy, this.sortDescending = false});
  @override bool operator ==(Object o) => identical(this, o) || o is ProductsParams &&
      page == o.page && pageSize == o.pageSize && searchTerm == o.searchTerm && sortBy == o.sortBy && sortDescending == o.sortDescending;
  @override int get hashCode => Object.hash(page, pageSize, searchTerm, sortBy, sortDescending);
}