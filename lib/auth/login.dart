// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:park_it/compo/Button.dart';
import 'package:park_it/compo/TextField.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // This widget is the root of your application.
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil('HomePage', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 14, 30, 91),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      child: Image.asset(
                        'images/logo.png',
                        width: screenWidth / 1.7,
                        height: screenHeight / 4,
                        //fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  const Text(
                    'Login to continue using the app',
                    style: TextStyle(color: Color.fromARGB(255, 228, 217, 217)),
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextForm(
                    hint: 'Enter your email',
                    mycontroller: email,
                    validator: (val) {
                      if (val == '') {
                        return 'Can\'t to be empty';
                      }
                    },
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    'Passwrd',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextForm(
                    hint: 'Enter your password',
                    mycontroller: password,
                    validator: (val) {
                      if (val == '') {
                        return 'Can\'t to be empty';
                      }
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      if (email.text == "") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'الرجاء كتابه البريد الالكتروني اولا',
                        ).show();
                        return;
                      }
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Note!',
                        desc:
                            '  لقد تم ارسال لينك اعاده تعين كلمه مرورك ! الرجاء تفقد بريدك الاكتروني \nملاحظه! اذا لم تصلك رساله اعاده التعين تاكد من انك ادخلت البريد الالكتروني بشكل صحيح  ',
                      ).show();
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: const Text(
                        ' Forget Passwrd ?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Button(
              title: 'Login',
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );

                    if (credential.user!.emailVerified) {
                      Navigator.of(context).pushReplacementNamed('HomePage');
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc:
                            'الرجاء التوجه الي بريدك الاكتروني والضغط علي لينك التحقق',
                      ).show();
                    }
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Please enter a correct email and password')),
                    );

                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'Please enter a correct email and password',
                    ).show();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter email and password')),
                  );
                }
              },
            ),
            Container(
              height: 20,
            ),
            MaterialButton(
              color: const Color.fromARGB(255, 178, 109, 18),
              textColor: Colors.white,
              height: 45,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              onPressed: () {
                signInWithGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Login with Google      '),
                  Image.asset(
                    'images/Google_Icons-09-512.webp',
                    width: 30,
                    height: 30,
                  )
                ],
              ),
            ),
            Container(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('SignUp');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?     ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'SignUp',
                    style: TextStyle(
                        color: Color.fromARGB(255, 6, 179, 41),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
