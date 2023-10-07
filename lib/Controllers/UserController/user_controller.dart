// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  RxInt totalCoins = 0.obs;

  @override
  void onReady() {}

  createUserDataUsingSignin(String email) async {
    await _db.collection("user").doc(email).set({
      "email": email,
    });
  }
}
