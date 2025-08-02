class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  /// Empty variation (useful for default or fallbacks)
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  /// Create model from JSON (e.g., Firebase document)
  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: json['Id'] ?? '',
      sku: json['SKU'] ?? '',
      image: json['Image'] ?? '',
      description: json['Description'] ?? '',
      price: (json['Price'] ?? 0.0).toDouble(),
      salePrice: (json['SalePrice'] ?? 0.0).toDouble(),
      stock: json['Stock'] ?? 0,
      attributeValues: Map<String, String>.from(json['AttributeValues'] ?? {}),
    );
  }
}
