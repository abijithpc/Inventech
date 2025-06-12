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
      name: map['name']?.toString() ?? '',
      brand: map['brand']?.toString() ?? '',
      model: map['model']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      images: map['images'] != null ? (map['images'] as String).split(',') : [],
      createdAt:
          map['createdAt'] != null
              ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
              : DateTime.now(),
    );
  }
}
