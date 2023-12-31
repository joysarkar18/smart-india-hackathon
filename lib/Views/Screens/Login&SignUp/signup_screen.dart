import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Controllers/Authentication/authentication.dart';
import 'package:flutter_shop/Controllers/Authentication/signupController.dart';
import 'package:flutter_shop/Controllers/UserController/user_controller.dart';
import 'package:flutter_shop/Views/Componants/glossy_card.dart';
import 'package:flutter_shop/Views/Screens/Login&SignUp/login_screen.dart';

import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool equalOrnot = true;
  final Authentication authentication = Get.put(Authentication());
  final signupController = Get.put(SignupController());
  final userController = Get.put(UserController());
  bool _isVisible1 = false;
  bool _isVisible2 = false;
  final fromKey = GlobalKey<FormState>();
  void updateStatus1() {
    setState(() {
      _isVisible1 = !_isVisible1;
    });
  }

  void updateStatus2() {
    setState(() {
      _isVisible2 = !_isVisible2;
    });
  }

  @override
  void dispose() {
    authentication.errorMsgup!.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/CURRENT.png"),
                    fit: BoxFit.cover)),
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: GlossyCard(
                    borderWith: 0.4,
                    height: Get.height * 0.75,
                    width: Get.width * 0.89,
                    borderRadius: 15.0,
                    child: SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                          width: Get.width * 0.79,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Signup",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Just some details to get you in!",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Form(
                                  key: fromKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller:
                                            signupController.emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        autofillHints: const [
                                          AutofillHints.email
                                        ],
                                        validator: (email) => email != null &&
                                                !EmailValidator.validate(email)
                                            ? "Enter a valid email"
                                            : null,
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            decoration: TextDecoration.none),
                                        decoration: const InputDecoration(
                                          fillColor: Colors.transparent,
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.black87),
                                          prefixIcon: Icon(
                                            Icons.email_rounded,
                                            color: Colors.black87,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Colors.black87)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Colors.green)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: signupController
                                            .passwordController1,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: !_isVisible1,
                                        validator: (value) =>
                                            validatePassword(value),
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            decoration: TextDecoration.none),
                                        decoration: InputDecoration(
                                          fillColor: Colors.transparent,
                                          hintText: "password",
                                          hintStyle: const TextStyle(
                                              color: Colors.black87),
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Colors.black87,
                                          ),
                                          suffixIcon: IconButton(
                                              color: Colors.black87,
                                              onPressed: () => updateStatus1(),
                                              icon: Icon(_isVisible1
                                                  ? Icons.visibility
                                                  : Icons.visibility_off)),
                                          errorBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  borderSide: BorderSide(
                                                      color: Colors.black87)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  borderSide: BorderSide(
                                                      color: Colors.green)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: signupController
                                            .passwordController2,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: !_isVisible2,
                                        validator: (value) =>
                                            validatePassword(value),
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            decoration: TextDecoration.none),
                                        decoration: InputDecoration(
                                          fillColor: Colors.transparent,
                                          hintText: "Confirm password",
                                          hintStyle: const TextStyle(
                                              color: Colors.black87),
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Colors.black87,
                                          ),
                                          suffixIcon: IconButton(
                                              color: Colors.black87,
                                              onPressed: () => updateStatus2(),
                                              icon: Icon(_isVisible2
                                                  ? Icons.visibility
                                                  : Icons.visibility_off)),
                                          errorBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: equalOrnot
                                                      ? Colors.black87
                                                      : Colors.red)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: equalOrnot
                                                      ? Colors.green
                                                      : Colors.red)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Obx(() => Text(
                                            authentication.errorMsgup!.value,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final from = fromKey.currentState!;
                                          if (from.validate()) {
                                            if (signupController
                                                    .passwordController1.text ==
                                                signupController
                                                    .passwordController2.text) {
                                              // authentication.is_loading.value =
                                              //     true;

                                              authentication.is_loading.value =
                                                  true;
                                              signupController.registerUser(
                                                  signupController
                                                      .emailController.text,
                                                  signupController
                                                      .passwordController1.text,
                                                  signupController
                                                      .referalController.text);
                                              userController
                                                  .createUserDataUsingSignin(
                                                      signupController
                                                          .emailController
                                                          .text);
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Get.width * 0.79,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 105, 202, 14),
                                                    Color.fromARGB(
                                                        255, 4, 121, 53)
                                                  ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: const Center(
                                              child: Text(
                                            "Signup",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          )),
                                        ),
                                      )
                                    ],
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(children: <Widget>[
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10.0, right: 20.0),
                                        child: const Divider(
                                          color: Colors.black87,
                                          height: 36,
                                        )),
                                  ),
                                  const Text(
                                    "or",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, right: 10.0),
                                        child: const Divider(
                                          color: Colors.black87,
                                          height: 36,
                                        )),
                                  ),
                                ]),
                              ]),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have account ?",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.off(const Login(),
                                          transition:
                                              Transition.cupertinoDialog);
                                    },
                                    child: const Text(
                                      "  Login",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 155, 95, 5)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              SizedBox(
                                width: Get.width * 0.79,
                                child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Terms & Conditions",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      Text(
                                        "Support",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      Text(
                                        "Customer Care",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ]),
                              )
                            ],
                          )),
                    )),
              ),
            ),
          ),
          Obx(
            () => authentication.is_loading.value
                ? Container(
                    color: const Color.fromARGB(39, 158, 158, 158),
                    height: Get.height,
                    width: Get.width,
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: Colors.purple,
                      backgroundColor: Color.fromARGB(255, 9, 113, 198),
                    )),
                  )
                : const Text(""),
          ),
        ],
      ),
    );
  }
}

String? validatePassword(String? pass) {
  if (pass == null || pass.isEmpty) {
    return "please enter the password";
  }

  if (pass.length < 5) {
    return "password can't be to short";
  }

  return null;
}

String? validatePhone(String? pass) {
  if (pass == null || pass.isEmpty) {
    return "please enter the phone no";
  }

  if (pass.length < 10) {
    return "wrong number please check!";
  }
  if (pass.length > 10) {
    return "wrong number please check!";
  }

  return null;
}
