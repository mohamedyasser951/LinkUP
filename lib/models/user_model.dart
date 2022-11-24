class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  UserModel(
      {required this.name, required this.email, this.phone, required this.uId});

  UserModel.fromJson(Map<String, dynamic> Json) {
    name = Json["name"];
    email = Json["email"];
    phone = Json["phone"];
    uId = Json["uId"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone":phone,
      "uId": uId,
    };
  }
}
