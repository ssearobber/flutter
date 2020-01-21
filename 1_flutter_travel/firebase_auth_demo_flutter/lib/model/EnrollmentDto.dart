class EnrollmentDto {
  String uId;
  String name;
  String sex;
  String introduce;
  String img;
  String img2;
  String img3;
  // String img;

  EnrollmentDto(
      {this.uId,
      this.name,
      this.sex,
      this.introduce,
      this.img,
      this.img2,
      this.img3});

  EnrollmentDto.fromMap(Map snapshot, String name)
      : name = name ?? '',
        sex = snapshot['sex'] ?? '',
        introduce = snapshot['introduce'] ?? '';

  Map<String, String> toJson() {
    return {
      "uId": uId,
      "name": name,
      "sex": sex,
      "introduce": introduce,
      "img": img,
      "img2": img2,
      "img3": img3,
    };
  }
}
