import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
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
                firebaseAuth.currentUser!.delete();
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
    ));
  }
}
