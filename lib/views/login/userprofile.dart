import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mammory_project/controllers/auth_controller.dart';
import 'package:mammory_project/services/database.dart';
import 'package:mammory_project/views/login/Report/devInfo.dart';
import 'package:mammory_project/views/login/show_loading.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _userNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _ageTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
 
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');
  final authCont = Get.find<AuthController>();
  void getUserData() async {
    _userNameTextController.text = authCont.userInfo.name ?? "";
    _emailTextController.text = authCont.userInfo.email ?? "";
    _ageTextController.text = authCont.userInfo.age ?? "";
    // _imageTextController.text = authCont.userInfo.image ?? "";
    _passwordTextController.text = authCont.userInfo.password ?? "";

  }

  XFile? image;

  Future getImagefromGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery,

    );

    setState(() {
      image = image;
    });
  }

  Future uploadimage() async {
    final path = 'profile/${image!.name}';
    final file = File(image!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
      print(file);
      print(path);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Scaffold(
          backgroundColor: Color(0xfff3edf9),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                child: Column(children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.arrow_back))),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Color(0xff8440fa),
                    child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                        leading: InkWell(
                          onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Devinfo()));
                          },
                          child: CircleAvatar(
                                  backgroundColor: Color.fromARGB(255, 231, 210, 235),
                            radius: 30,
                            backgroundImage:
                              ExactAssetImage('images/MammoryLogo.png'),
                        ),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            print("Starting.....");
                               getImagefromGallery();
                            
                            
                         
                                 print("Successsed");
                              showDialog(context: context,
                            builder: (BuildContext context) {
                                return AlertDialog(
                                content: Text("Profile Image Successfully Updated."),
                               
                                actions: [
                                  ElevatedButton(
                                onPressed: () {
                                   Navigator.of(context).pop();
                                  uploadimage();
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              )
                                ],
                                );
                               });
                               
                          
                            
                          },
             
                          child: CircleAvatar(
                            radius: 30,
                            child: (image != null)

                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                       
                                               image: FileImage(File(image!.path)),
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                    )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: BoxDecoration(
                                      color: Color(0xffab8ce5),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Icon(Icons.person),
                                  ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3f3754)),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextField(
                    controller: _userNameTextController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 22, top: 15, bottom: 15),
                      suffixIcon: Icon(
                        Icons.create_outlined,
                        color: Color(0xff8440fa),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    enabled: false,
                    controller: _emailTextController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 22, top: 15, bottom: 15),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _ageTextController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 22, top: 15, bottom: 15),
                      suffixIcon: Icon(
                        Icons.create_outlined,
                        color: Color(0xff8440fa),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      controller: _passwordTextController,
                      obscureText: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 22, top: 15, bottom: 15),
                        suffixIcon: Icon(
                          Icons.create_outlined,
                          color: Color(0xff8440fa),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(310, 50),
                        backgroundColor: Color(0xff8440fa),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () => 
                     
                    DataBase().onUpdateUserData(
                  
                      _userNameTextController.text,
                      _emailTextController.text,
                      _ageTextController.text,
                      // _imageTextController.text ,
                      _passwordTextController.text,
                      // uploadImage(),
                    ),
                    //OLD CODE
                    // onPressed: (() {
                    //   // FirebaseFirestore.instance
                    //   //     .collection('users')
                    //   //     .doc(auth.currentUser!.uid)
                    //   //     .update({
                    //   //   'name': _userNameTextController,
                    //   //   'email': _emailTextController,
                    //   //   'password': _passwordTextController
                    //   // });
                    // }),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 50),
                          backgroundColor: Color(0xff8440fa),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () => authCont.onSignOut(),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
