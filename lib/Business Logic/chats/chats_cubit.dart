import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/Business%20Logic/chats/chats_states.dart';
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
    var pickedImage = await picker.pickImage(source: ImageSource.gallery,imageQuality:50 ,);
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
}
