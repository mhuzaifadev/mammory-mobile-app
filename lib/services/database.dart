import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mammory_project/controllers/auth_controller.dart';
import 'package:mammory_project/models/user_model.dart';

class DataBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final authCont = Get.find<AuthController>();

  ///for creating user data

  Future<bool> createUser(UserModel user) async {
    try {
      await _firestore.collection("Users").doc(user.id).set({
        "Name": user.name,
        "Email": user.email,
        "Age":user.age,
        "Password": user.password,
 
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
 
  //CHANGE USER DATA

  Future<void> onUpdateUserData(
      String name, String email,String age,String password) async {
    try {
      authCont.isLoading.value = true;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(authCont.userss!.uid)
          .update({
        "Name": name,
          "Age": age,
        // "Email": email,
        "Password": password,
       
      }).then((value) {
        // authCont.userss!.updateEmail(email);
        authCont.userss!.updatePassword(password).then((value) {
          authCont.isLoading.value = false;
          Get.snackbar("Changed", "Your profile is successfully changed",
              backgroundColor: Colors.green, colorText: Colors.white);
        });
      }).then((value) => authCont.getUser());
    } catch (e) {
      Get.snackbar("Please try again", "$e".split("]")[1],
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
