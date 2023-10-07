import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Controllers/Authentication/authentication.dart';
import 'package:flutter_shop/Controllers/MainController/main_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authentication = Get.put(Authentication());
  final mainController = Get.put(MainController());
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String imageUrl = "";

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource
            .gallery, // You can also use ImageSource.camera for the camera.
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: _selectedImage == null
                  ? Text("Image preview")
                  : Image.file(_selectedImage!),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Text(
              mainController.plantName.value,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _pickImage,
            child: Container(
              width: Get.width * 0.79,
              height: 50,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 105, 202, 14),
                        Color.fromARGB(255, 4, 121, 53)
                      ]),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Center(
                  child: Text(
                "Choose Image",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              // Reference reference = FirebaseStorage.instance
              //     .ref()
              //     .child("SupportChatImages")
              //     .child("image");

              // UploadTask uploadTask = reference.putFile(_selectedImage!);

              // uploadTask.whenComplete(() async {
              //   try {
              //     imageUrl = await reference.getDownloadURL();
              //   } catch (onError) {
              //     print("Error");
              //   }

              //   print(imageUrl);
              // });

              HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
                HttpLogger(logLevel: LogLevel.BODY),
              ]);

              try {
                String url =
                    "https://codesugata.eu.org/myapi?image=/home/sugata/Downloads/medicinal_plant_detection-main/server/" +
                        _selectedImage!.path.split("/")[7];
                final responce = await http.get(
                  Uri.parse(url),
                );

                if (responce.statusCode == 200) {
                  mainController.plantName.value =
                      json.decode(responce.body)["type"];
                }
              } catch (e) {
                print(e);
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
                        Color.fromARGB(255, 253, 246, 18),
                        Color.fromARGB(255, 181, 169, 3)
                      ]),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Center(
                  child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              )),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.red)))),
              onPressed: () {
                authentication.logOut();
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
