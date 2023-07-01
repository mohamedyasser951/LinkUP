import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/modules/chats/ChatCubit/chats_states.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/shared/componenet/constant.dart';

class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() : super(ChatIntialStates());

  void sendMessage({
    String? recieverId,
    String? text,
    String? chatImg,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
        sendId: uId,
        reciverId: recieverId,
        text: text,
        dateTime: dateTime,
        chatImg: chatImg);

    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .collection("chats")
        .doc(recieverId)
        .collection("Messages")
        .add(messageModel.tojson())
        .then((value) {
      emit(SendMessageSuccessState());
    });

    FirebaseFirestore.instance
        .collection("Users")
        .doc(recieverId)
        .collection("chats")
        .doc(uId)
        .collection("Messages")
        .add(messageModel.tojson())
        .then((value) {
      emit(SendMessageSuccessState());
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String? recieverId,
  }) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .collection("chats")
        .doc(recieverId)
        .collection("Messages")
        .orderBy("dateTime", descending: true)
        .snapshots();
  }

  var picker = ImagePicker();
  File? imageMessage;
  pickImageMessage() async {
    var pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      imageMessage = File(pickedImage.path);
    }
  }

  sendChatImages({
    required File imgFile,
    required String recieverId,
  }) async {
    emit(SendChatImageLoadingState());
    FirebaseStorage.instance
        .ref("chatsImage")
        .child(Uri.file(imgFile.path).pathSegments.last)
        .putFile(imgFile)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        sendMessage(
            dateTime: DateTime.now().toString(),
            chatImg: value,
            recieverId: recieverId);

        emit(SendChatImageSuccessState());
      });
    });
  }

  sendFCM({
    required String reciverToken,
    required String message,
    required String title,
  }) {
    try {
      Dio().post(
        "https://fcm.googleapis.com/fcm/send",
        data: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': message,
              'title': title,
              "sound": "default"
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": reciverToken,
          },
        ),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAicvUbDo:APA91bGRKmnhjBV62iE0qXAxsPP9wdw72L01T_rgvW7mfOANpLuL64w23LifFC4bKp8K_2o4BsxuJb1nrp3Ar_TDpO0XM2JQz4AdUuqcvwm9ztHm_piHnnWZTPIWNjNpU_sdFOZziq6X',
          },
        ),
      );
    } catch (e) {
      print("error when send message $e");
    }
  }
}
