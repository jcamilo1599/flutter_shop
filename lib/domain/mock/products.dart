import '../models/product/product.dart';

class GetProducts {
  static ProductModel iPhone9(String userId) {
    return ProductModel(
      title: 'iPhone 9',
      description: 'An apple mobile which is nothing like apple',
      price: 549,
      discountPercentage: 12.96,
      rating: 4.69,
      stock: 94,
      brand: 'Apple',
      category: 'smartphones',
      thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      images: <String>[
        'https://i.dummyjson.com/data/products/1/1.jpg',
        'https://i.dummyjson.com/data/products/1/2.jpg',
        'https://i.dummyjson.com/data/products/1/3.jpg',
        'https://i.dummyjson.com/data/products/1/4.jpg',
        'https://i.dummyjson.com/data/products/1/thumbnail.jpg'
      ],
      userId: userId,
    );
  }

  static List<ProductModel> getAll() {
    return <ProductModel>[
      GetProducts.iPhone9('1'),
      GetProducts.iPhone9('2'),
    ];
  }
}
