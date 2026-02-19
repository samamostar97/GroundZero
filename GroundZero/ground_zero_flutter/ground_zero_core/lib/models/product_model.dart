class ProductModel {
  final String id;
  final String name;
  final String? description;
  final double price;
  final int stockQuantity;
  final String? imageUrl;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ProductModel({required this.id, required this.name, this.description, required this.price,
    required this.stockQuantity, this.imageUrl, required this.status, required this.createdAt, this.updatedAt});

  factory ProductModel.fromJson(Map<String, dynamic> j) => ProductModel(
    id: j['id'], name: j['name'], description: j['description'],
    price: (j['price'] as num).toDouble(), stockQuantity: j['stockQuantity'],
    imageUrl: j['imageUrl'], status: j['status'],
    createdAt: DateTime.parse(j['createdAt']),
    updatedAt: j['updatedAt'] != null ? DateTime.parse(j['updatedAt']) : null);

  Map<String, dynamic> toCreateJson() => {'name': name, 'description': description, 'price': price,
    'stockQuantity': stockQuantity, 'imageUrl': imageUrl, 'status': status};
}