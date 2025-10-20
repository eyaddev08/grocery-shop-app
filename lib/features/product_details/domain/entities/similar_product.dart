class SimilarProduct {
  const SimilarProduct(
      {required this.id,
      required this.image,
      required this.title,
      required this.price});
  final String id;
  final String image;
  final String title;
  final String price;
}

// sample data: replace with your real data source
const List<SimilarProduct> sampleSimilarItems = [
  SimilarProduct(
      id: '1',
      image: 'assets/svg/empty_image.svg',
      title: 'Fresh Orange',
      price: r'$4.50'),
  SimilarProduct(
      id: '2',
      image: 'assets/svg/empty_image.svg',
      title: 'Green Apple',
      price: r'$3.20'),
  SimilarProduct(
      id: '3',
      image: 'assets/svg/empty_image.svg',
      title: 'Red Tomato',
      price: r'$2.40'),
  SimilarProduct(
      id: '4',
      image: 'assets/svg/empty_image.svg',
      title: 'Halal Fish',
      price: r'$12.00'),
];
