import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_it/compo/Button.dart';
import 'package:park_it/compo/TextField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  // This widget is the root of your application.
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
                    'SignUp',
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
                    'SignUp to continue using the app',
                    style: TextStyle(color: Color.fromARGB(255, 228, 217, 217)),
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    'Username',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextForm(
                    hint: 'Enter your username',
                    mycontroller: userName,
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
              title: 'SignUp',
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  try {
                    // ignore: unused_local_variable
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    Navigator.of(context).pushReplacementNamed('Login');
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The password provided is too weak.',
                      ).show();
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The account already exists for that email.',
                      ).show();
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
            ),
            Container(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('Login');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?     ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Login',
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
