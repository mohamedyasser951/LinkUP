// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/shared/componenet/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutIntialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() async {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      print("getuserDatamethod..........");
      userModel = UserModel.fromJson(value.data());
      print("usermodel value...........${userModel!.uId}");
      emit(SocialGetUserSucessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState());
    });
  }

  List<UserModel> users = [];

  getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection("Users").get().then((value) {
        value.docs.forEach(
          (element) {
            if (element.data()['uId'] != userModel!.uId) {
              users.add(UserModel.fromJson(element.data()));
            }
          },
        );
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState());
      });
    }
  }

  int currentIndex = 0;

  changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }

    if (index == 2) {
      emit(SocialNewPostAtate());
    } else {
      currentIndex = index;
      emit(HomeChangeBottomNavState());
    }
  }

  var picker = ImagePicker();
  File? profileImage;
  getProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccesState());
    } else {
      print("No image Selected");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  getCoverImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccesState());
    } else {
      emit(SocialCoverImagePickedErrorState());
      print("error When picked cover..");
    }
  }

  uploadProfileImag({
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("user/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        updateUserData(name: name, bio: bio, phone: phone, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageSuccessState());
      });
    }).catchError((e) {
      emit(SocialUploadProfileImageSuccessState());
    });
  }

  uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("user/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //   emit(SocialUploadCoveImageSuccessState());
        updateUserData(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((e) {
        emit(SocialUploadCoveImageErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadCoveImageErrorState());
    });
  }

  updateUserData({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  }) async {
    UserModel model = UserModel(
        name: name,
        bio: bio,
        phone: phone,
        cover: cover ?? userModel!.cover,
        image: image ?? userModel!.image,
        email: userModel!.email,
        uId: userModel!.uId);

    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel!.uId)
        .update(model.toJson())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserDataErrorState());
    });
  }

  File? postImage;
  getPostImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPickedPostImageSuccessState());
    } else {
      print("no file picked");
      emit(SocialPickedPostImageErrorState());
    }
  }

  //create new post

  void createNewPost({
    required String postText,
    required String dateTime,
    String? postImage,
  }) async {
    PostModel postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      postImage: postImage ?? '',
      text: postText,
      dateTime: dateTime,
    );
    emit(SocialCreateNewPostLoadingState());
    FirebaseFirestore.instance
        .collection("Posts")
        .add(postModel.toJson())
        .then((value) {
      //comment here and i removed it
      emit(SocialCreateNewPostSuccessState());
    }).catchError((error) {
      emit(SocialCreateNewPostErrorState());
    });
  }

  void uplaodPostImage({
    required String postText,
    required String dateTime,
  }) async {
    emit(SocialUploadNewPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref("post")
        .child(Uri.file(postImage!.path).pathSegments.last)
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(postText: postText, dateTime: dateTime, postImage: value);
        emit(SocialUploadNewPostImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadNewPostImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadNewPostImageErrorState());
    });
  }

  removePostImage() {
    postImage = null;
    emit(SocialDeletePostImageState());
  }

  List<String> postsId = [];
  List<int> likes = [];

  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    // List<PostModel> posts = [];

    // emit(SocialGetPostsLoadingState());

    // FirebaseFirestore.instance
    //     .collection("Posts")
    //     .orderBy("dateTime")
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((element) {
    //     element.reference.collection("Likes").get().then((value) {
    //       postsId.add(element.id);
    //       posts.add(PostModel.fromJson(element.data()));
    //       likes.add(value.docs.length);
    //     }).catchError((error) {});

    //     emit(SocialGetPostsSuccessState(posts: posts));
    //   });
    // }).catchError((error) {
    //   emit(SocialGetPostsErrorState());
    // });
    // return posts;

    return FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("dateTime", descending: true)
        .snapshots();
  }

  void likePost({required String posId}) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(posId)
        .collection("Likes")
        .doc(userModel!.uId)
        .set({'like': 'true'}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }
}
