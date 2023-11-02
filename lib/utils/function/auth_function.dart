import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rive/rive.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:type1dm_rl_flutter/services/auth_service.dart';

class AuthFunction {
  final BuildContext context;

  AuthFunction(this.context);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required AuthService authService,
    required SMITrigger check,
    required SMITrigger error,
    required SMITrigger confetti,
    required Function(bool) setLoadingState,
  }) async {
    setLoadingState(true);
    try {
      final email = emailController.text;
      final password = passwordController.text;
      final user =
      await authService.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        check.fire();
        Future.delayed(Duration(seconds: 2), () {
          setLoadingState(false);
          confetti.fire();
          Navigator.pushReplacementNamed(context, '/demographicsSettingPage');
        });
      } else {
        error.fire();
        Future.delayed(Duration(seconds: 2), () {
          setLoadingState(false);
        });
      }
    } catch (e) {
      error.fire();
      Future.delayed(Duration(seconds: 2), () {
        setLoadingState(false);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> signIn({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required SMITrigger check,
    required SMITrigger error,
    required SMITrigger confetti,
    required Function(bool) setLoadingState,
  }) async {
    setLoadingState(true);
    try {
      final email = emailController.text;
      final password = passwordController.text;
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      check.fire();
      Future.delayed(Duration(seconds: 2), () {
        setLoadingState(false);
        confetti.fire();
        Navigator.pushReplacementNamed(context, '/rootPage');
      });
    } catch (e) {
      error.fire();
      Future.delayed(Duration(seconds: 2), () {
        setLoadingState(false);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
        await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null && !user.isAnonymous) {
          DocumentSnapshot userData = await FirebaseFirestore.instance
              .collection('demographics')
              .doc(user.uid)
              .get();

          if (!userData.exists) {
            Navigator.pushReplacementNamed(context, '/demographicsSettingPage');
          } else {
            Navigator.pushReplacementNamed(context, '/rootPage');
          }
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    print("User signed out of Google account");
  }

  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final authCredential = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      final authResult =
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      final User? user = authResult.user;

      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userData.exists) {
          Navigator.pushReplacementNamed(context, '/demographicsSettingPage');
        } else {
          Navigator.pushReplacementNamed(context, '/rootPage');
        }
      }
    } catch (error) {
      print(error);
    }
  }
}
