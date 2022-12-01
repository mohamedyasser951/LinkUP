class MessageModel {
  String? sendId;
  String? reciverId;
  String? dateTime;
  String? text;

  MessageModel({
    this.sendId,
    this.reciverId,
    this.text,
    this.dateTime,
  });

  MessageModel.fromJson(Map<String, dynamic>? Json) {
    sendId = Json!["sindId"];
    reciverId = Json["reciverId"];
    text = Json["text"];
    dateTime = Json["dateTime"];
  }

  Map<String, dynamic> toJson() {
    return {
      "sendId": sendId,
      "reciverId": reciverId,
      "text": text,
      "dateTime": dateTime,
    };
  }
}
