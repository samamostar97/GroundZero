class PagedResult<T> {
  final List<T> items;
  final int totalCount;
  final int page;
  final int pageSize;
  final int totalPages;
  final bool hasPreviousPage;
  final bool hasNextPage;

  const PagedResult({required this.items, required this.totalCount, required this.page,
    required this.pageSize, required this.totalPages, required this.hasPreviousPage, required this.hasNextPage});

  factory PagedResult.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) => PagedResult(
    items: (json['items'] as List).map((e) => fromJsonT(e as Map<String, dynamic>)).toList(),
    totalCount: json['totalCount'] ?? 0, page: json['page'] ?? 1, pageSize: json['pageSize'] ?? 10,
    totalPages: json['totalPages'] ?? 1, hasPreviousPage: json['hasPreviousPage'] ?? false, hasNextPage: json['hasNextPage'] ?? false);
}