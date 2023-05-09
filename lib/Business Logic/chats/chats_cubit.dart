import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Business%20Logic/chats/chats_states.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/shared/componenet/constant.dart';

class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() : super(ChatIntialStates());

  void sendMessage({
    String? recieverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
        sendId: uId, reciverId: recieverId, text: text, dateTime: dateTime);

    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .collection("chats")
        .doc(recieverId)
        .collection("Messages")
        .add(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    });

    FirebaseFirestore.instance
        .collection("Users")
        .doc(recieverId)
        .collection("chats")
        .doc(uId)
        .collection("Messages")
        .add(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    });
  }

Stream<QuerySnapshot<Map<String, dynamic>>>  getMessages({
    required String? recieverId,
  }) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .collection("chats")
        .doc(recieverId)
        .collection("Messages")
        .orderBy("dateTime",descending: true)
        .snapshots();
  }
}
