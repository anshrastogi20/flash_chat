import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  void snackBarAction() {

  }

  @override
  void dispose() {
    //snackBar.dispose();
    super.dispose();
  }

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
                    decoration: kTextFieldDecoration.copyWith(hintText:'Enter your password')
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async{
                          setState((){
                            showSpinner = true;
                          });
                          try{
                            final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                            if(user!=null){
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
                            SnackBar snackBar = SnackBar(
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
                          'Log In',
                          style: TextStyle(
                              fontSize: 20.0
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