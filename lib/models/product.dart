class ProductModal {
  late String id, name, price, description, image, category, created_date;
  ProductModal.fromJson(Map<String, dynamic> json) {
    {
      id = json['id'];
      name = json['name'];
      price = json['price'];
      description = json['description'];
      image = json['image'];
      category = json['category'];
      created_date = json['created_date'];
    }
  }
}
