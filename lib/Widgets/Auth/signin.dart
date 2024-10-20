import 'package:checkit/Assets/NavigationWrapper.dart';
import 'package:checkit/Widgets/Auth/signup.dart';
import 'package:checkit/Widgets/TextFormFieldWithStyling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

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
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('assets/img/try19.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            // color: Color.fromARGB(255, 206, 206, 206),
            child: Container(
              child: Indexer(children: [
                Indexed(
                    index: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(90.0),
                            child: Image(
                                image: AssetImage(
                                    'assets/img/mewithoutbackground.png'),
                                height: 180),
                          ),
                        ],
                      ),
                    )),
                Indexed(
                  index: 2,
                  child: Positioned(
                    top: MediaQuery.of(context).size.height / 3.2,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(16, 25, 80, 0),
                      height: 250,
                      width: 400,
                      child: Card(
                        color: Color.fromARGB(235, 185, 173, 157),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Welkom',
                              style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.fontFamily,
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
                            height: 20,
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
                            height: 20,
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
                        ]),
                      ),
                    ),
                  ),
                ),
                Indexed(
                  index: 3,
                  child: Positioned(
                    left: 100,
                    bottom: 170,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text('Inloggen'),
                          onPressed: signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(188, 231, 143, 12),
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
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NavigationWrapper()));
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
