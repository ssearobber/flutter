class EnrollmentDto {
  String id;
  String price;
  String name;
  String img;

  EnrollmentDto({this.id, this.price, this.name, this.img});

  EnrollmentDto.fromMap(Map snapshot, String id)
      : id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        img = snapshot['img'] ?? '';

  Map<String, String> toJson() {
    return {
      "price": price,
      "name": name,
      "img": img,
    };
  }
}
