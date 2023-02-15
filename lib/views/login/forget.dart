import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './sign_in.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xfff3edf9),
      body: SingleChildScrollView(

        child: Padding(
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45,left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               TextFormField(
                      controller:_emailTextController ,
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
               SizedBox(height: 40.0),
               ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff8440fa),
                        minimumSize: Size(310, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onPressed: (() {
                      FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _emailTextController.text,
                             ).
                            then((value) {
                              print('we have send an email');
                              
                          
                        });
                      }),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white,
                          
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 60,),
                    CircleAvatar(
                      radius: 25,
                     backgroundColor: Color(0xff8440fa),
                     child: IconButton(onPressed: (() {
                       Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignIn()));
                     }), icon: Icon(Icons.arrow_back_outlined,color: Colors.white),
                    ),
                    ),
      
            ],
          ),
        ),
      ),
    );
  }
}