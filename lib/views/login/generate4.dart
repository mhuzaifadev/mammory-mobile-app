import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mammory_project/controllers/auth_controller.dart';
import 'package:mammory_project/views/login/Report/report.dart';
import 'package:mammory_project/views/login/userprofile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'home.dart';
import 'package:http/http.dart' as http;
import 'Mainrepo/mainreport.dart';
import 'dart:io';

class GeneratePage extends StatefulWidget {
  GeneratePage({super.key, this.imagename, this.className});
  final imagename;
  final className;
  @override
  State<GeneratePage> createState() => _GeneratePageState(image: null);
}

class _GeneratePageState extends State<GeneratePage> {
  _GeneratePageState({
    Key? key,
    required this.image,
  });
  Widget? _child;
  bool loading = false;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  XFile? image;
  Future<Map<String, dynamic>> uploadImage(
      String fullName, String email, String dateOfBirth, File image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          // ignore: prefer_interpolation_to_compose_strings
          'https://mammoryapi.azurewebsites.net/api/' +
              widget.className.toLowerCase() +
              '?full_name=${fullName.replaceAll(" ", "%20")}&email=${email.replaceAll("@", "%40")}&date_of_birth=$dateOfBirth'),
    );
    // request.fields['full_name'] = fullName;
    print(fullName);
    print(dateOfBirth);
    print(email);
    // request.fields['email'] = email;
    // request.fields['date_of_birth'] = dateOfBirth;
    var pic = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(pic);
    var response = await request.send();
    var responseStream = await http.Response.fromStream(response);
    var responseData = json.decode(responseStream.body);

    print("XXX   ${response.statusCode}");
    print("XXX   ${responseStream}");
    print("XXX   ${responseData}");
    // print("XXX   ${responseString}");
    return responseData;
    // return jsonDecode(response);
  }

  final authCont = Get.put(AuthController());

  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    // Call the uploadImage function to make the API request
    uploadImage(authCont.userInfo.name ?? "", authCont.userInfo.email ?? "", '12-01-2000',
            File(widget.imagename.path))
        .then((value) {
      setState(() {
        loading = false;
      });
      // Navigate to the ReportPage with the data returned from the API
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReportPage(
            accountId: value['Account ID'],
            riskFactor: value['Risk Factor'],
            message: value['Message'],
            lesion: value['Lesion'],
            classType: value['Class Type'],
            reportUrl: value['Report_URL'],
          ),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3edf9),
      appBar: AppBar(
        backgroundColor: Color(0xff8440fa),
        centerTitle: true,
        title: Text(
          // ignore: prefer_interpolation_to_compose_strings
          "Testing " + widget.className,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              const SizedBox(
                height: 80.0,
              ),
              Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.28,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: FileImage(widget.imagename),
                          fit: BoxFit.fill,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
              ),
              loading
                  ? CircularProgressIndicator(
                      color: Color.fromARGB(255, 165, 48, 237),
                      strokeWidth: 5,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = UserProfile();
          break;
        case 1:
          _child = SearchPage();
          break;
        case 2:
          _child = MainRepo();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 1000),
        child: _child,
      );
    });
  }
}
