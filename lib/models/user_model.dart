
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id, name,email,age,password;
  UserModel({
    this.password,
    this.id,
    this.name,
    this.email,
    this.age,
  });
  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
   
   
    email=doc["Email"];
   name=doc["Name"];
    age=doc["Age"];
    password = doc["Password"];
    
  }
}
