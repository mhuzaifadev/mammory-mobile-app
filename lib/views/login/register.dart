import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mammory_project/controllers/auth_controller.dart';
import 'package:mammory_project/views/login/show_loading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mammory_project/views/login/sign_in.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _ageTextController = TextEditingController();
  final TextEditingController _imageTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();
  bool _showPassword = false;
  bool _showPassword1 = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Image logoWidget(String imageName) {
    return Image.asset(
      imageName,
      fit: BoxFit.cover,
      width: 240,
      height: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authCont = Get.find<AuthController>();
    return Obx(
      () => ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Scaffold(
          backgroundColor: const Color(0xfff3edf9),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  25, MediaQuery.of(context).size.height * 0.1, 25, 20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    logoWidget(
                      'images/reg_img.png',
                    ),
                    const Text(
                      'Welcome Onboard!',
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    const Text(
                      'Lets help you find a cure!',
                      style: TextStyle(color: Colors.black, fontSize: 17.0),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    TextFormField(
                      controller: _userNameTextController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 15, bottom: 10),
                        hintText: 'Enter Your  Name',
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
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Required username'),
                      ]),
                    ),
                    const SizedBox(
                      height: 16.0,
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
                          borderSide: const BorderSide(
                            color: Colors.white54,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            (50),
                          ),
                          borderSide: const BorderSide(
                            color: Color(0xff0f4ff),
                          ),
                        ),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Required email'),
                        EmailValidator(errorText: 'Please enter a valid email'),
                      ]),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _ageTextController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 15, bottom: 10),
                        hintText: 'Enter your Age',
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
                          borderSide: const BorderSide(
                            color: Colors.white54,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            (50),
                          ),
                          borderSide: const BorderSide(
                            color: Color(0xff0f4ff),
                          ),
                        ),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Required age'),
                      ]),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _passwordTextController,
                      obscureText: !this._showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 15, bottom: 10),
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
                          borderSide: const BorderSide(
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
                              setState(() =>
                                  this._showPassword = !this._showPassword);
                            }),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Required Password'),
                        MinLengthValidator(6,
                            errorText:
                                'password must be at least 6 digits long'),
                        PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                            errorText:
                                'passwords must have at least one special character'),
                      ]),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _confirmPasswordTextController,
                      obscureText: !this._showPassword1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 15, bottom: 10),
                        hintText: 'Confirm password',
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
                          borderSide: const BorderSide(
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
                              setState(() =>
                                  this._showPassword1 = !this._showPassword1);
                            }),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'Required confirm password'),
                        MinLengthValidator(6,
                            errorText:
                                'password must be at least 6 digits long'),
                      ]),
                    ),
                    const SizedBox(
                      height: 45.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8440fa),
                        minimumSize: const Size(310, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onPressed: (() async {
                        if (_formkey.currentState!.validate()) {
                          //NEW CODE
                          authCont.isLoading.value = true;
                          authCont.onSignUp(
                              _userNameTextController.text,
                              _emailTextController.text,
                              _ageTextController.text,

                              // _imageTextController.text,
                              _passwordTextController.text);

                          ///OLD CODE
                          //   final UserCredential auth  = await  FirebaseAuth.instance.createUserWithEmailAndPassword(
                          //     email: _emailTextController.text,
                          //     password:  _passwordTextController.text );
                          //    // .then((value){
                          //   //debugPrint('Create new account');
                          //   await FirebaseFirestore.instance.collection('users').doc(auth.user!.uid).set({
                          //     'name': _userNameTextController.text,
                          //     'email': _emailTextController.text,
                          //     'password': _passwordTextController.text
                          //   });
                          //   final SharedPreferences pref = await SharedPreferences.getInstance();
                          //   pref.setString('name', _userNameTextController.text);
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  const BottomNav()));
                          // //});
                        }
                      }),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
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
                                    builder: (context) => const SignIn()));
                          }),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xff8440fa),
                              fontSize: 17.0,
                            ),
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
    );
  }
}
