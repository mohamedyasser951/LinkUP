
class MessageModel {
  String? sendId;
  String? reciverId;
  String? dateTime;
  String? text;
  String? chatImg;

  MessageModel({
    this.sendId,
    this.reciverId,
    this.text,
    this.dateTime,
    this.chatImg,
  });

  MessageModel.fromjson(Map<String, dynamic>? json) {
    sendId = json!["sindId"];
    reciverId = json["reciverId"];
    text = json["text"];
    dateTime = json["dateTime"];
    chatImg = json["chatImg"];
  }

  Map<String, dynamic> tojson() {
    return {
      "sendId": sendId,
      "reciverId": reciverId,
      "text": text,
      "dateTime": dateTime,
      "chatImg":chatImg,
    };
  }
}
