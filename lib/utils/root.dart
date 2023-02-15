
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mammory_project/views/login/bottomnav.dart';
import 'package:mammory_project/views/login/sign_in.dart';
import '../controllers/auth_controller.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(),permanent: true);
    // Get.put(ButtonsController());
    return GetX<AuthController>(initState: (_) async {
      Get.put<AuthController>(AuthController(),permanent: true);
    }, builder: (_) {
      if (Get.find<AuthController>().user != null) {
        _.getUser();
        // Get.put<AuthController>(AuthController());
        return const BottomNav();
      } else {
        return const SignIn();
      }
    });
  }
}
