class EnrollmentDto {
  String name;
  String sex;
  String introduce;
  String img;

  EnrollmentDto({this.name, this.sex, this.introduce, this.img});

  EnrollmentDto.fromMap(Map snapshot, String name)
      : name = name ?? '',
        sex = snapshot['sex'] ?? '',
        introduce = snapshot['introduce'] ?? '',
        img = snapshot['img'] ?? '';

  Map<String, String> toJson() {
    return {
      "name": name,
      "sex": sex,
      "introduce": introduce,
      "img": img,
    };
  }
}
