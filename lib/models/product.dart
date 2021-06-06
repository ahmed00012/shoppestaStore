import 'dart:io';

class Product {
  String name;
  String id;
  List<File> images;
  String category;
  String gender;
  double price;
  List<String> sizes;
  String mainImage;
  int likesCounter;

  Product(
      {this.name,
      this.id,
      this.images,
      this.category,
      this.gender,
      this.price,
      this.sizes,
      this.mainImage,
      this.likesCounter});
}
