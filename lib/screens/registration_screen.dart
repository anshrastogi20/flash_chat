import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 50.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: kTextFieldDecoration.copyWith(hintText:'Enter your email')
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: kTextFieldDecoration.copyWith(hintText:'Enter your password(6 characters)',)
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async{
                          setState((){
                            showSpinner = true;
                          });
                          try{
                            final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                            if(newUser!=null){
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState((){
                              showSpinner = false;
                            });
                          }
                          catch(e){
                            setState((){
                              showSpinner = false;
                            });
                            final snackBar = SnackBar(
                              content: Text(
                                'Invalid username or password',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20.0,
                                ),
                              ),
                              backgroundColor: Colors.white,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            print(e);
                          }
                        },
                        minWidth: 200.0,
                        height: 50.0,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}