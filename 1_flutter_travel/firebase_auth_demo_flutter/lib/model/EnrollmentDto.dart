class EnrollmentDto {
  String uId;
  String name;
  String sex;
  String introduce;
  // String img;

  EnrollmentDto({this.uId, this.name, this.sex, this.introduce});

  EnrollmentDto.fromMap(Map snapshot, String name)
      : name = name ?? '',
        sex = snapshot['sex'] ?? '',
        introduce = snapshot['introduce'] ?? '';

  Map<String, String> toJson() {
    return {"uId": uId, "name": name, "sex": sex, "introduce": introduce};
  }
}
