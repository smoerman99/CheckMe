import 'package:checkit/Widgets/Auth/signin.dart';
import 'package:checkit/Widgets/TextFormFieldWithStyling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message;

  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color.fromARGB(255, 206, 206, 206),
        child: Container(
          child: Indexer(children: [
            Indexed(
                index: 1,
                child: Container(
                  color: Color.fromARGB(255, 121, 62, 62),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(90.0),
                        child: Image(
                            image: AssetImage(
                                'assets/img/mewithoutbackground.png'),
                            height: 125),
                      ),
                    ],
                  ),
                )),
            Indexed(
              index: 2,
              child: Positioned(
                top: MediaQuery.of(context).size.height / 3.2,
                left: 50,
                child: Container(
                  margin: EdgeInsets.all(5),
                  height: 330,
                  width: 250,
                  child: Card(
                    color: Colors.white,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Welcome,'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 0, 0, 22),
                        child: Text(
                          'Fill in this form and you are ready to use the app!',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 25,
                          child: TextField(
                            expands: false,
                            controller: fullNameController,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Fullname',
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              focusColor: Color(0x00115C2E),
                              border: InputBorder.none,
                              errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 25,
                          child: TextField(
                            expands: false,
                            controller: passwordController,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.web_outlined),
                              hintText: 'Password',
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              focusColor: Color(0x00115C2E),
                              border: InputBorder.none,
                              errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 25,
                          child: TextField(
                            expands: false,
                            controller: emailController,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              focusColor: Color(0x00115C2E),
                              border: InputBorder.none,
                              errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            message != null && message.isNotEmpty
                                ? message
                                : '',
                            style: TextStyle(
                                fontSize: 13, color: Colors.redAccent)),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            Indexed(
              index: 3,
              child: Positioned(
                left: 140,
                bottom: 190,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('Sign Up'),
                      onPressed: signUp,
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 121, 62, 62)),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (exception) {
      print(exception.code);
      if (exception.code == 'email-already-in-use') {
        setState(() {
          message = 'The provided email adress is already in use.';
        });
      } else if (exception.code == 'invalid-email') {
        setState(() {
          message = 'The provided email adres is invalid.';
        });
      } else if (exception.code == 'operation-not-allowed') {
        setState(() {
          message = "You can't use username email setup.";
        });
      } else if (exception.code == 'weak-password') {
        setState(() {
          message = "The provided password is to weak.";
        });
      } else {
        print('object');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignInWidget()));
        // setState(() {
        //   message = 'Please insert something before submitting';
        // });
      }
    }
  }
}
