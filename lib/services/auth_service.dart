import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 現在のユーザー情報を取得するメソッド
  User? get currentUser => _auth.currentUser;

  // メールアドレスとパスワードで新規登録するメソッド
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // サインインするメソッド
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // ログアウトするメソッド
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Googleアカウントでサインインするメソッド
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult = await _auth.signInWithCredential(credential);
        return authResult.user;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    return null;
  }

  // Googleアカウントでサインアウトするメソッド
  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  // // Facebookアカウントでサインインするメソッド
  // Future<User?> signInWithFacebook() async {
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login(); // LoginResultを使用
  //     if (loginResult.status == LoginStatus.success) {
  //       final AccessToken? accessToken = loginResult.accessToken; // accessTokenを取得
  //       if (accessToken != null) {
  //         final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.token);  // ここを修正
  //         final UserCredential authResult = await _auth.signInWithCredential(facebookAuthCredential);
  //         return authResult.user;
  //       }
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  //   return null;
  // }
  //
  // // Facebookアカウントでサインアウトするメソッド
  // Future<void> signOutFacebook() async {
  //   await FacebookAuth.instance.logOut();
  // }
}
