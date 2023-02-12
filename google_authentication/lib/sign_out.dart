import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_authentication/sign_in.dart';

class SignOut extends StatelessWidget {
  final UserCredential? fAuthUserDetail;
  const SignOut({super.key, required this.fAuthUserDetail});

  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      await fAuthUserDetail!.user!.delete();
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => SignIn())));
    }

    dynamic snackBar;
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${fAuthUserDetail!.user!.email}'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (() {
                signOut();
                snackBar =
                    const SnackBar(content: Text('Deleted Successfully.'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }),
              child: const Text(
                'Sign Out',
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
