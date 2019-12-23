class EnrollmentDto {
  String name;
  String sex;
  String introduce;
  // String img;

  EnrollmentDto({this.name, this.sex, this.introduce});

  EnrollmentDto.fromMap(Map snapshot, String name)
      : name = name ?? '',
        sex = snapshot['sex'] ?? '',
        introduce = snapshot['introduce'] ?? '';

  Map<String, String> toJson() {
    return {"name": name, "sex": sex, "introduce": introduce};
  }
}
