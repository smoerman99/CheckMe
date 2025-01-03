import 'package:checkit/Widgets/Auth/signin.dart';
import 'package:checkit/Widgets/textFormFieldWithStyling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message = '';

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
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('assets/img/try21.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
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
                // margin: EdgeInsets.fromLTRB(16, 0, 16, 0),

                // margin: EdgeInsets.all(5),
                height: 420,
                width: 350,
                child: Card(
                  color: Colors.transparent,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Welkom,',
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 0, 22),
                      child: Text(
                        'Vull in dit formulier en je bent klaar om de app te gaan gebruiken!',
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyLarge?.fontFamily,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                        softWrap: true,
                      ),
                    ),
                    TextFormFieldWithStyling(
                      controller: fullNameController,
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      textInputType: TextInputType.name,
                      needsExpanding: false,
                      hintText: 'Voor + achternaam',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormFieldWithStyling(
                      controller: passwordController,
                      icon: Icon(
                        Icons.web_outlined,
                        color: Colors.white,
                      ),
                      textInputType: TextInputType.name,
                      needsExpanding: true,
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormFieldWithStyling(
                      controller: emailController,
                      icon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      textInputType: TextInputType.emailAddress,
                      needsExpanding: false,
                      hintText: 'Email',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(message.isNotEmpty ? message : '',
                          style:
                              TextStyle(fontSize: 13, color: Colors.redAccent)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text(
                            'Meld je aan',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(185, 180, 115, 39),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          )),
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      setState(() {
        fullNameController.text = '';
        emailController.text = '';
        passwordController.text = '';
      });

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignInWidget()));
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

        // setState(() {
        //   message = 'Please insert something before submitting';
        // });
      }
    }
  }
}
