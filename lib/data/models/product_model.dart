class Products {
  String productName;
  String image;
  String description;
  double price;
  double quantity;

  // Constructor
  Products({
    required this.productName,
    required this.image,
    required this.description,
    required this.price,
    required this.quantity,
  });

  // Method to convert a product to a Map to send data to Firebase
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'image': image,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  // Method to create a product object from Firebase data (Map)
  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      productName: map['productName'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
    );
  }
}
