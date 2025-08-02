import 'dart:ffi';

import 'package:ecommerce_store/features/shop/models/banner_model.dart';
import 'package:ecommerce_store/features/shop/models/category_model.dart';
import 'package:ecommerce_store/features/shop/models/product_attribut_model.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:ecommerce_store/features/shop/models/product_varation_model.dart';
import 'package:ecommerce_store/routes/routes.dart';

import '../../features/shop/models/brand_model.dart';
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

  ///List of Brands
  static final List<BrandModel> brands = [
    BrandModel(
      id: '1',
      image: 'assets/images/nike_logo.png',
      name: 'Nike',
      // Changed from "Mike" to "Nike"
      productsCount: 265,
      isFeatured: true,
    ),
    BrandModel(
      id: '2',
      image: 'assets/images/adidas_logo.png',
      name: 'Adidas',
      productsCount: 95,
      isFeatured: true,
    ),
    BrandModel(
      id: '8',
      image: 'assets/images/kemwood_logo.png',
      name: 'Kemwood',
      productsCount: 36,
      isFeatured: false,
    ),
    BrandModel(
      id: '9',
      image: 'assets/images/ikea_logo.png',
      name: 'IKEA',
      productsCount: 36,
      isFeatured: false,
    ),
    BrandModel(
      id: '5',
      image: 'assets/images/apple_logo.png',
      name: 'Apple',
      productsCount: 16,
      isFeatured: true,
    ),
    BrandModel(
      id: '10',
      image: 'assets/images/acer_logo.png',
      name: 'Acer',
      productsCount: 36,
      isFeatured: false,
    ),
    BrandModel(
      id: '3',
      image: 'assets/images/jordan_logo.png',
      name: 'Jordan',
      productsCount: 36,
      isFeatured: true,
    ),
    BrandModel(
      id: '4',
      image: 'assets/images/puma_logo.png',
      name: 'Puma',
      productsCount: 65,
      isFeatured: true,
    ),
    BrandModel(
      id: '6',
      image: 'assets/images/zara_logo.png',
      name: 'ZARA',
      productsCount: 36,
      isFeatured: true,
    ),
    BrandModel(
      id: '7',
      image: 'assets/images/samsung_logo.png',
      name: 'Samsung',
      productsCount: 36,
      isFeatured: false,
    ),
  ];

  /// List of Banners
  static final List<BannerModel> banners = [
    BannerModel(
      imageUrl: TImages.banner1,
      targetScreen: TRoutes.order,
      active: false,
    ),
    BannerModel(
      imageUrl: TImages.banner2,
      targetScreen: TRoutes.cart,
      active: true,
    ),
    BannerModel(
      imageUrl: TImages.banner3,
      targetScreen: TRoutes.favorite,
      active: true,
    ),
    BannerModel(
      imageUrl: TImages.banner4,
      targetScreen: '/search',
      active: false,
    ),
    BannerModel(
      imageUrl: TImages.banner5,
      targetScreen: TRoutes.settings,
      active: true,
    ),
    BannerModel(
      imageUrl: TImages.banner5,
      targetScreen: TRoutes.userAddress,
      active: true,
    ),
    BannerModel(
      imageUrl: TImages.banner6,
      targetScreen: TRoutes.checkout,
      active: true,
    ),
  ];

  /// List of Products
  static final List<ProductModel> products = [
    ProductModel(
      id: "001",
      title: 'Green Nike Sport Shoes',
      stock: 15,
      price: 135,
      thumbnail: TImages.productImage1,
      isFeatured: true,
      brand: BrandModel(
        id: '1',
        image: TImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        TImages.productImage1,
        TImages.productImage23,
        TImages.productImage21,
        TImages.productImage9,
      ],
      salePrice: 30,
      sku: 'ABR457',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productType: 'ProductType.variable',
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 34,
          price: 134,
          image: TImages.productImage1,
          description: 'Green variation of Nike shoes',
          attributeValues: {'Color': 'Green', 'Size': 'EU 30'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 132,
          image: TImages.productImage23,
          description: 'Black variation of Nike shoes',
          attributeValues: {'Color': 'Black', 'Size': 'EU 30'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 9,
          price: 136,
          image: TImages.productImage21,
          description: 'Red variation of Nike shoes',
          attributeValues: {'Color': 'Red', 'Size': 'EU 30'},
        ),
      ],
    ),

    /// Adidas Sneakers
    ProductModel(
      id: "002",
      title: 'Adidas Classic Sneakers',
      stock: 20,
      price: 120,
      thumbnail: TImages.productImage2,
      isFeatured: false,
      brand: BrandModel(
        id: '2',
        image: TImages.adidasLogo,
        name: 'Adidas',
        productsCount: 180,
        isFeatured: false,
      ),
      images: [
        TImages.productImage2,
        TImages.productImage3,
      ],
      salePrice: 25,
      sku: 'ADS320',
      categoryId: '2',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['White', 'Blue']),
        ProductAttributeModel(name: 'Size', values: ['EU 38', 'EU 40']),
      ],
      productType: 'ProductType.variable',
      productVariations: [
        ProductVariationModel(
          id: '4',
          stock: 10,
          price: 115,
          image: TImages.productImage2,
          description: 'White Adidas sneaker',
          attributeValues: {'Color': 'White', 'Size': 'EU 38'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 10,
          price: 118,
          image: TImages.productImage3,
          description: 'Blue Adidas sneaker',
          attributeValues: {'Color': 'Blue', 'Size': 'EU 40'},
        ),
      ],
    ),

    /// Puma Running Shoes
    ProductModel(
      id: "003",
      title: 'Puma Running Shoes',
      stock: 30,
      price: 110,
      thumbnail: TImages.productImage4,
      isFeatured: true,
      brand: BrandModel(
        id: '3',
        image: TImages.pumaLogo,
        name: 'Puma',
        productsCount: 140,
        isFeatured: true,
      ),
      images: [
        TImages.productImage4,
        TImages.productImage5,
      ],
      salePrice: 20,
      sku: 'PMR501',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Grey', 'Yellow']),
        ProductAttributeModel(name: 'Size', values: ['EU 39', 'EU 41']),
      ],
      productType: 'ProductType.variable',
      productVariations: [
        ProductVariationModel(
          id: '6',
          stock: 15,
          price: 108,
          image: TImages.productImage4,
          description: 'Grey Puma running shoe',
          attributeValues: {'Color': 'Grey', 'Size': 'EU 39'},
        ),
        ProductVariationModel(
          id: '7',
          stock: 15,
          price: 110,
          image: TImages.productImage5,
          description: 'Yellow Puma running shoe',
          attributeValues: {'Color': 'Yellow', 'Size': 'EU 41'},
        ),
        ProductVariationModel(
          id: '7',
          stock: 15,
          price: 110,
          image: TImages.productImage5,
          description: 'Yellow Puma running shoe',
          attributeValues: {'Color': 'Yellow', 'Size': 'EU 41'},
        ),
      ],
    ),

    /// Reebok Training Shoes
    ProductModel(
      id: "004",
      title: 'Reebok Training Shoes',
      stock: 18,
      price: 99,
      thumbnail: TImages.productImage6,
      isFeatured: false,
      brand: BrandModel(
        id: '4',
        image: TImages.productImage7,
        name: 'Reebok',
        productsCount: 95,
        isFeatured: false,
      ),
      images: [
        TImages.productImage6,
      ],
      salePrice: 10,
      sku: 'RBK221',
      categoryId: '4',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black']),
        ProductAttributeModel(name: 'Size', values: ['EU 40']),
      ],
      productType: 'ProductType.variable',
      productVariations: [
        ProductVariationModel(
          id: '8',
          stock: 18,
          price: 89,
          image: TImages.productImage6,
          description: 'Black Reebok training shoe',
          attributeValues: {'Color': 'Black', 'Size': 'EU 40'},
        ),
      ],
    ),

    /// New Balance Sneakers
    ProductModel(
      id: "005",
      title: 'New Balance Everyday Sneakers',
      stock: 22,
      price: 125,
      thumbnail: TImages.productImage7,
      isFeatured: true,
      brand: BrandModel(
        id: '5',
        image: TImages.nikeLogo,
        name: 'New Balance',
        productsCount: 110,
        isFeatured: true,
      ),
      images: [
        TImages.productImage7,
        TImages.productImage8,
      ],
      salePrice: 20,
      sku: 'NB450',
      categoryId: '5',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Blue', 'Gray']),
        ProductAttributeModel(name: 'Size', values: ['EU 39', 'EU 41']),
      ],
      productType: 'ProductType.variable',
      productVariations: [
        ProductVariationModel(
          id: '9',
          stock: 12,
          price: 123,
          image: TImages.productImage7,
          description: 'Blue New Balance everyday sneaker',
          attributeValues: {'Color': 'Blue', 'Size': 'EU 39'},
        ),
        ProductVariationModel(
          id: '10',
          stock: 10,
          price: 121,
          image: TImages.productImage8,
          description: 'Gray New Balance sneaker',
          attributeValues: {'Color': 'Gray', 'Size': 'EU 41'},
        ),
      ],
    ),

    /// Asics Trail Runners
    ProductModel(
      id: "006",
      title: 'Asics Trail Running Shoes',
      stock: 14,
      price: 140,
      thumbnail: TImages.productImage10,
      isFeatured: false,
      brand: BrandModel(
        id: '6',
        image: TImages.adidasLogo,
        name: 'Asics',
        productsCount: 75,
        isFeatured: false,
      ),
      images: [TImages.productImage10],
      salePrice: 15,
      sku: 'ASC900',
      categoryId: '6',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Orange']),
        ProductAttributeModel(name: 'Size', values: ['EU 42']),
      ],
      productType: 'ProductType.variable',
      productVariations: [
        ProductVariationModel(
          id: '11',
          stock: 14,
          price: 125,
          image: TImages.productImage10,
          description: 'Asics trail runner - Orange, EU 42',
          attributeValues: {'Color': 'Orange', 'Size': 'EU 42'},
        ),
      ],
    ),

    /// Under Armour Training Shoes
    ProductModel(
      id: "007",
      title: 'Under Armour Training Shoes',
      stock: 19,
      price: 130,
      thumbnail: TImages.productImage11,
      isFeatured: true,
      brand: BrandModel(
        id: '7',
        image: TImages.jordanLogo,
        name: 'Under Armour',
        productsCount: 88,
        isFeatured: true,
      ),
      images: [
        TImages.productImage11,
        TImages.productImage12,
      ],
      salePrice: 18,
      sku: 'UA231',
      categoryId: '7',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black', 'White']),
        ProductAttributeModel(name: 'Size', values: ['EU 40', 'EU 42']),
      ],
      productType: 'ProductType.variable',
      productVariations: [
        ProductVariationModel(
          id: '12',
          stock: 10,
          price: 129,
          image: TImages.productImage11,
          description: 'Black Under Armour shoe',
          attributeValues: {'Color': 'Black', 'Size': 'EU 40'},
        ),
        ProductVariationModel(
          id: '13',
          stock: 9,
          price: 127,
          image: TImages.productImage12,
          description: 'White Under Armour shoe',
          attributeValues: {'Color': 'White', 'Size': 'EU 42'},
        ),
      ],
    ),

    /// Converse High Tops
    ProductModel(
      id: "008",
      title: 'Converse Chuck Taylor High Tops',
      stock: 25,
      price: 85,
      thumbnail: TImages.productImage13,
      isFeatured: false,
      brand: BrandModel(
        id: '8',
        image: TImages.zaraLogo,
        name: 'Converse',
        productsCount: 130,
        isFeatured: false,
      ),
      images: [TImages.productImage13],
      salePrice: 10,
      sku: 'CVS301',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Red']),
        ProductAttributeModel(name: 'Size', values: ['EU 41']),
      ],
      productType: 'ProductType.variable',
      productVariations: [
        ProductVariationModel(
          id: '14',
          stock: 25,
          price: 75,
          image: TImages.productImage13,
          description: 'Red Converse Chuck Taylor High Top',
          attributeValues: {'Color': 'Red', 'Size': 'EU 41'},
        ),
      ],
    ),
  ];

}
