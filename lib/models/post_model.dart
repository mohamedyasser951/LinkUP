class PostModel {
  String? name;
  String? uId;
  String? image;
  String? text;
  String? postImage;
  String? dateTime;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.postImage,
    this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic>? Json) {
    name = Json!["name"];
    uId = Json["uId"];
    image = Json["image"];
    text = Json["text"];
    postImage = Json["postImage"];
    dateTime = Json["dateTime"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "uId": uId,
      "image": image,
      "text": text,
      "postImage": postImage,
      "dateTime": dateTime,
    };
  }
}
