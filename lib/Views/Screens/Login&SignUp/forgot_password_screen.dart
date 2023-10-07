import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Controllers/Authentication/authentication.dart';
import 'package:flutter_shop/Controllers/Authentication/signupController.dart';
import 'package:flutter_shop/Views/Componants/glossy_card.dart';
import 'package:flutter_shop/Views/Screens/Login&SignUp/signup_screen.dart';

import 'package:get/get.dart';

class ForgetPass extends StatelessWidget {
  const ForgetPass({super.key});

  @override
  Widget build(BuildContext context) {
    final fromKey = GlobalKey<FormState>();
    final singupController = Get.put(SignupController());
    final authentication = Get.put(Authentication());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "Assets/CURRENT.png",
              ),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                child: GlossyCard(
                  borderWith: 0.4,
                  height: Get.height * 0.75,
                  width: Get.width * 0.89,
                  borderRadius: 15.0,
                  child: SizedBox(
                    width: Get.width * 0.79,
                    child: Form(
                      key: fromKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 45.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Please enter your email",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller:
                                  singupController.forgotPassemailController,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? "Enter a valid email"
                                  : null,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.none),
                              autofillHints: const [AutofillHints.email],
                              decoration: const InputDecoration(
                                fillColor: Colors.transparent,
                                hintText: "example@gmail.com",
                                hintStyle: TextStyle(color: Colors.black87),
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  color: Colors.black87,
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.red)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: Colors.black87)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {
                                final from = fromKey.currentState!;
                                if (from.validate()) {
                                  authentication.resetPassword(singupController
                                      .forgotPassemailController.text);
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
                                          Color.fromARGB(255, 255, 119, 28),
                                          Color.fromARGB(255, 185, 142, 26)
                                        ]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Center(
                                    child: Text(
                                  "Reset Password",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                )),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * .27,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account ?",
                                    style: TextStyle(color: Colors.black87)),
                                TextButton(
                                    onPressed: () {
                                      Get.off(const SignUp(),
                                          transition:
                                              Transition.cupertinoDialog);
                                      ;
                                    },
                                    child: Text(
                                      "Signup",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 185, 112, 3)),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Terms & Conditions",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Support",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Customer Care",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
