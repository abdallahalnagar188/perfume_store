import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  final String id;
  final String image;
  final String name;
  final int? productsCount;
  final bool? isFeatured;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.productsCount,
    this.isFeatured,
  });

  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: data['ProductsCount'],
      isFeatured: data['IsFeatured'],
    );
  }
}
