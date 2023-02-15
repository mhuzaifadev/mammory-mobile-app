import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mammory_project/controllers/auth_controller.dart';
import 'package:mammory_project/views/login/Report/devInfo.dart';
import 'package:mammory_project/views/login/Report/report.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'generate4.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String UseName = '';
  String name = "";
  String level = "Mammogram";
  String img = "";
  XFile? image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  File? imageFile;
  XFile? PFile;

  File? rec;

  /// Get from gallery
  Future _getFromGallery(String name) async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = image;
    });
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GeneratePage(
                  imagename: File(image!.path),
                  className: name,
                )));
  }

  /// Get from Camera
  Future _getFromCamera(String name) async {
    image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      image = image;
      print(image!.path);
    });
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GeneratePage(
                  imagename: File(image!.path),
                  className: name,
                )));
  }

  getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    UseName = pref.getString('name').toString();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  final authCont = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    List title = ['Mammogram', 'Ultrasound'];
    List images = ['images/mammory(1).png', 'images/mammory(2).png'];

    return Scaffold(
      backgroundColor: Color(0xfff3edf9),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
            child: Column(children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.23,
                decoration: BoxDecoration(
                  color: const Color(0xff8440fa),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: const Color(0xff8440fa),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 4),
                        leading: InkWell(
                          onTap: () {
                            print("attribue page");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Devinfo()));
                          },
                          child: const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 231, 210, 235),
                            radius: 30,
                            backgroundImage:
                                ExactAssetImage('images/MammoryLogo.png'),
                          ),
                          // backgroundColor: Color(0xffab8ce5),
                        ),

                        title: Shimmer.fromColors(
                            baseColor: Color(0xfff3edf9),
                            highlightColor: const Color(0xffab8ce5),
                            child: const Text(
                              'Mammory',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        // title: Text(
                        //   'Mammory',
                        //   style: TextStyle(
                        //       fontSize: 25.0,
                        //       fontWeight: FontWeight.w600,
                        //       color: Color(0xfff3edf9)),
                        // ),
                        trailing: const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              ExactAssetImage('images/reg_img.png'),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Good Morning,',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w200,
                            color: Color(0xfff3edf9)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Obx(
                        () => Text(
                          authCont.userInfo.name ?? "",
                          style: const TextStyle(
                            fontSize: 26.0,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detect breast cancer using medical image',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff3f3754),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Column(children: [
                      GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 02,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 200,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                print("object");

                                setState(() {
                                  if (index == 0) {
                                    name = title[0];

                                    print(name);
                                  } else if (index == 1) {
                                    name = title[1];

                                    print(name);
                                  }
                                  selectedPhoto(context, name);
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.004,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xff352c56)
                                            .withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Spacer(),
                                      Text(
                                        title[index],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff3f3754),
                                        ),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        images[index],
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                      ),
                                    ],
                                  )),
                            );
                          })
                    ])
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void selectedPhoto(BuildContext context, String name) => showDialog(
      context: context,
      // int temp = null;
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Center(
                  child: Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              )),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).pop();
                            _getFromGallery(name);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.upload_file,
                                  color: Color(0xff3f3754),
                                  size: 40,
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0xff8440fa).withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Upload file',
                                  style: TextStyle(
                                      color: Color(0xff3f3754),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).pop();
                            _getFromCamera(name);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Color(0xff3f3754),
                                  size: 40,
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0xff8440fa).withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "Camera",
                                  style: TextStyle(
                                      color: Color(0xff3f3754),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]));
      });
}
