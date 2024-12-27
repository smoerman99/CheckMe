import 'package:checkit/Assets/NavigationWrapper.dart';
import 'package:checkit/Widgets/Auth/signup.dart';
import 'package:checkit/Widgets/TextFormFieldWithStyling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  State<SignInWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<SignInWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message = '';

  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/img/try21.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(90, 150, 90, 15),
              child: Image(
                  image: AssetImage(
                    'assets/img/mewithoutbackground.png',
                  ),
                  height: 180),
            ),
          ),
          Container(
            // margin: EdgeInsets.fromLTRB(16, 25, 80, 0),
            height: 350,
            width: 350,
            child: Card(
              color: Colors.transparent,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welkom',
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.bodyLarge?.fontFamily,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormFieldWithStyling(
                  taskNameController: emailController,
                  icon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  textInputType: TextInputType.emailAddress,
                  needsExpanding: false,
                  hintText: 'Gebruikersnaam',
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormFieldWithStyling(
                  taskNameController: passwordController,
                  icon: Icon(
                    Icons.password,
                    color: Colors.white,
                  ),
                  textInputType: TextInputType.name,
                  needsExpanding: true,
                  hintText: 'Wachtwoord',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message.isNotEmpty ? message : '',
                      style: TextStyle(fontSize: 13)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text(
                        'Inloggen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(185, 180, 115, 39),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpWidget()));
                      },
                      child: Text("Nog geen account? Doe dat hier",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NavigationWrapper(
                openTaskPage: false,
              )));
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'user-not-found') {
        setState(() {
          message = 'User not found';
        });
      } else if (exception.code == 'wrong-password') {
        setState(() {
          message = 'Password is incorrect';
        });
      } else if (exception.code == 'invalid-email') {
        setState(() {
          message = 'Email is incorrect';
        });
      } else {
        setState(() {
          message = 'Please insert something before submitting';
        });
      }
    }
  }
}
