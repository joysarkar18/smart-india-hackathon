import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Controllers/UserController/user_controller.dart';
import 'package:flutter_shop/Views/Componants/NavBar/nav_bar.dart';
import 'package:flutter_shop/Views/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_shop/Views/Screens/Login&SignUp/login_screen.dart';
import 'package:flutter_shop/Views/Screens/Login&SignUp/signup_screen.dart';
import 'package:get/get.dart';

class Authentication extends GetxController {
  static Authentication get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  RxString? errorMsg = "".obs;
  RxString? errorMsgup = "".obs;
  RxString userEmail = "".obs;
  // ignore: non_constant_identifier_names
  var is_loading = false.obs;
  final userController = Get.put(UserController());

  @override
  void onReady() {
    // Get called after widget is rendered on the screen
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitScreen);
  }

  _setInitScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const SignUp());
    } else {
      userEmail.value = _auth.currentUser!.email.toString();
      Timer(
        Duration(seconds: 2),
        () {
          Get.offAll(() => MainScreen());
        },
      );
    }
  }

  Future<void> createUserWithEmailPassword(
      String email, String password, String referal) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await userController.createUserDataUsingSignin(email);
        is_loading.value = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        errorMsgup!.value = "Already have account! Login";
      } else if (e.code == "wrong-password") {
        errorMsgup!.value = "Wrong password";
      } else {
        errorMsgup!.value = "An error occourd";
      }
      is_loading.value = false;
    }
  }

  Future<void> loginUserWithEmailPassword(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        is_loading.value = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        errorMsg!.value = "user not exits! Sign Up";
      } else if (e.code == "wrong-password") {
        errorMsg!.value = "Wrong password";
      } else {
        errorMsg!.value = "An error occourd";
      }
      is_loading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        print("email sent");
        Get.dialog(
          AlertDialog(
            backgroundColor: Color.fromARGB(255, 245, 117, 13),

            // title: const Text(""),
            content: const Text(
              'An email has been sent please reset the password and try again!',
              style: TextStyle(color: Colors.white70, fontSize: 20),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "ok",
                  style: TextStyle(
                      color: Color.fromARGB(255, 160, 2, 239), fontSize: 20),
                ),
                onPressed: () => Get.to(Login()),
              ),
            ],
          ),
        );
        // Get.off(Login());
      });
    } catch (e) {
      print("error happens");
    }
  }

  Future<void> logOut() async => await _auth.signOut().then((value) {
        is_loading.value = false;
      });
}
