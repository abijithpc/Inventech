class ProductModel {
  final int? id;
  final String name;
  final String brand;
  final String model;
  final String description;
  final List<String> images;
  final DateTime createdAt;

  ProductModel({
    this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.description,
    required this.images,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'description': description,
      'images': images.join(','),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      brand: map['brand'] as String,
      model: map['model'] as String,
      description: map['description'] as String,
      images: (map['images'] as String).split(','),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
