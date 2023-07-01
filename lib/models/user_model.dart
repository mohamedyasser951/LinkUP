class UserModel {
  String? name;
  String? email;
  String? phone;
   String? uId;
  String? image;
  String? cover;
  String? bio;
  String? fcmToken;
  UserModel({
    this.name,
    this.email,
    this.uId,
    this.phone,
    this.bio ,
    this.cover,
    this.image ,
    this.fcmToken,
  });

  UserModel.fromJson(Map<String, dynamic>? Json) {
    name = Json!["name"];
    email = Json["email"];
    phone = Json["phone"];
    uId = Json["uId"];
    bio = Json["bio"];
    cover = Json["cover"];
    image = Json["image"];
    fcmToken = Json["fcmToken"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uId": uId,
      "bio":bio,
      "cover":cover,
      "image":image,
      "fcmToken":fcmToken
    };
  }
}
