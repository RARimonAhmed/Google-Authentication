import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_authentication/sign_out.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  dynamic snackBar;
  UserCredential? firebaseUser;
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
      firebaseUser =
          (await FirebaseAuth.instance.signInWithCredential(credential));
      if (firebaseUser != null) {
        snackBar = const SnackBar(content: Text('Sign in successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => SignOut(
                      fAuthUserDetail: firebaseUser,
                    ))));
      } else {
        snackBar = const SnackBar(content: Text('Sign in Loading'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

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
