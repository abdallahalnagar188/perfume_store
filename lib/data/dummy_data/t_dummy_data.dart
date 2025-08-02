import 'package:ecommerce_store/features/shop/models/category_model.dart';

import '../../utils/constants/image_strings.dart';

class TDummyData {
  /// List of all categories
  static final List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Sports',
      image: TImages.sportIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '2',
      name: 'Electronics',
      image: TImages.electronicsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '3',
      name: 'Clothes',
      image: TImages.clothIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '4',
      name: 'Animals',
      image: TImages.animalIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '5',
      name: 'Furniture',
      image: TImages.furnitureIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '6',
      name: 'Shoes',
      image: TImages.shoeIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '7',
      name: 'Cosmetics',
      image: TImages.cosmeticsIcon,
      isFeatured: true,
    ),

    /// Sports subcategories
    CategoryModel(
      id: '8',
      image: TImages.sportIcon,
      name: 'Sport Shoes',
      parentId: '1',
      isFeatured: false,
    ),
    CategoryModel(
      id: '9',
      image: TImages.sportIcon,
      name: 'Track suits',
      parentId: '1',
      isFeatured: false,
    ),
    CategoryModel(
      id: '10',
      image: TImages.sportIcon,
      name: 'Sports Equipments',
      parentId: '1',
      isFeatured: false,
    ),

    /// Furniture subcategories
    CategoryModel(
      id: '11',
      image: TImages.furnitureIcon,
      name: 'Bedroom furniture',
      parentId: '5',
      isFeatured: false,
    ),
    CategoryModel(
      id: '12',
      image: TImages.furnitureIcon,
      name: 'Kitchen furniture',
      parentId: '5',
      isFeatured: false,
    ),
    CategoryModel(
      id: '13',
      image: TImages.furnitureIcon,
      name: 'Office furniture',
      parentId: '5',
      isFeatured: false,
    ),

    /// Electronics subcategories
    CategoryModel(
      id: '14',
      image: TImages.electronicsIcon,
      name: 'Laptop',
      parentId: '2',
      isFeatured: false,
    ),
    CategoryModel(
      id: '15',
      image: TImages.electronicsIcon,
      name: 'Mobile',
      parentId: '2',
      isFeatured: false,
    ),
  ];
}
