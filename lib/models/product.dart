class Product {
  final int id;
  final String title;
  final String category;
  final double price;
  final double rating;
  final String image;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.image,
  });
}

final List<Product> initialProducts = [
  Product(
    id: 1,
    title: 'Face Cream',
    category: 'Skincare',
    price: 4500,
    rating: 4.8,
    image: 'assets/images/cream.jpg',
  ),
  Product(
    id: 2,
    title: 'Perfume',
    category: 'Fragrance',
    price: 12000,
    rating: 4.9,
    image: 'assets/images/perfume.jpg',
  ),
  Product(
    id: 3,
    title: 'Lipstick',
    category: 'Makeup',
    price: 3500,
    rating: 4.5,
    image: 'assets/images/lipstick.jpg',
  ),
  Product(
    id: 4,
    title: 'Face Serum',
    category: 'Skincare',
    price: 6000,
    rating: 4.7,
    image: 'assets/images/serum.jpg',
  ),
  Product(
    id: 5,
    title: 'Mascara',
    category: 'Makeup',
    price: 2800,
    rating: 4.4,
    image: 'assets/images/mascara.jpg',
  ),
  Product(
    id: 6,
    title: 'Body Lotion',
    category: 'Body Care',
    price: 4000,
    rating: 4.6,
    image: 'assets/images/lotion.jpg',
  ),
];