import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mammory_project/controllers/auth_controller.dart';
import './register.dart';
import './forget.dart';
import 'show_loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _showPassword = false;
  final _key = GlobalKey<FormState>();
  final authCont = Get.find<AuthController>();
  Image logoWidget(String imageName) {
    return Image.asset(
      imageName,
      fit: BoxFit.cover,
      width: 260,
      height: 160,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Scaffold(
          backgroundColor: const Color(0xfff3edf9),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  25, MediaQuery.of(context).size.height * 0.2, 25, 20),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    logoWidget('images/sign_in.png'),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 15, bottom: 10),
                        hintText: 'Enter your Email',
                        hintStyle: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff3f3754),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            (50),
                          ),
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            (50),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xff0f4ff),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _passwordTextController,
                      obscureText: !this._showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 15, bottom: 10),
                        hintText: 'Enter password',
                        hintStyle: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff3f3754),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            (50),
                          ),
                          borderSide: const BorderSide(color: Colors.white54),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            (50),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xff0f4ff),
                          ),
                        ),
                         suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._showPassword
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(
                                  () => this._showPassword = !this._showPassword);
                            }),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    TextButton(
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      }),
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Color(0xffab8ce5),
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff8440fa),
                        minimumSize: Size(310, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onPressed: () {
                        authCont.isLoading.value = true;
                        authCont.onSignIn(_emailTextController.text,
                            _passwordTextController.text);
                      },
                      //OLD CODE
                      // onPressed: (() async {
                      //   // await FirebaseAuth.instance
                      //   //     .signInWithEmailAndPassword(
                      //   //         email: _emailTextController.text,
                      //   //         password: _passwordTextController.text)
                      //   //     .then((value) {
                      //   //   Navigator.push(context,
                      //   //       MaterialPageRoute(builder: (context) => BottomNav()));
                      //   // });
                      // }),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dont have an account?',
                          style: TextStyle(
                            color: Color(0xff3f3754),
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                          ),
                        ),
                        TextButton(
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          }),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xff8440fa),
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
