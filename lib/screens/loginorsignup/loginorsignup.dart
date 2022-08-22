import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/helper/auth/theme_helper.dart';
import 'package:icbapps/screens/homepage/homescreen.dart';
import 'package:icbapps/screens/registerpage/registerscreen.dart';
import 'package:icbapps/screens/widgets/header_widget.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({Key? key}) : super(key: key);

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  FireBase fireBase = FireBase();

  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextField(
                                  controller: username,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'User Name', 'Enter your user name'),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextField(
                                  controller: password,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                  },
                                  child: const Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text(
                                        'Sign In'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final x = await fireBase.signin(
                                          username.text.trim() + "@gmail.com",
                                          password.text.trim());
                                      if (x != null) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()));
                                      }
                                    }),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const RegisterScreen()));

                                },
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  //child: Text('Don\'t have an account? Create'),
                                  child: Text.rich(TextSpan(children: [
                                    const TextSpan(text: "Don't have an account? "),
                                    TextSpan(
                                      
                                      text: 'Create',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ])),
                                ),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
