import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_authentication/sign_out.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    Future googleSignIn() async {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? firebaseAuthUser = firebaseUser.user;
      print(firebaseAuthUser);
      if (firebaseAuthUser != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const SignOut())));
      }
    }

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    dynamic snackBar;
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (() {
                  // firebaseAuth.currentUser!.delete();
                  googleSignIn();
                  snackBar =
                      const SnackBar(content: Text('Sign in successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }),
                child: const Text(
                  'Sign in With Google',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
