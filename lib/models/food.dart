class Food {
  Food({
    required this.name,
    required this.price,
    required this.veg,
    required this.type,
    required this.foodId,
    this.image,
    this.about,
    this.discPrice,
    this.discPer,
    this.rating,
  });

  final String name;
  final int price;
  final bool veg;
  final String type;
  final String foodId;
  final int? discPrice;
  final int? discPer;
  final double? rating;
  final String? about;
  final String? image;
}
