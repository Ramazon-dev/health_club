import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../core.dart';

class GoogleSignUpConfigure {
  static final instance = FirebaseAuth.instance;
  static final googleSignIn = GoogleSignIn.instance;

  static User? user = instance.currentUser;

  static Future<void> sendPhone(BuildContext context, String phone) async {
    print('object phone number is $phone');
    await instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (phoneAuthCredential) {
        print('object firebase phone verificationCompleted smsCode ${phoneAuthCredential.smsCode}');
        print('object firebase phone verificationCompleted verificationId ${phoneAuthCredential.verificationId}');
        print('object firebase phone verificationCompleted accessToken ${phoneAuthCredential.accessToken}');
        print('object firebase phone verificationCompleted token ${phoneAuthCredential.token}');
        print('object firebase phone verificationCompleted providerId ${phoneAuthCredential.providerId}');
        print('object firebase phone verificationCompleted signInMethod ${phoneAuthCredential.signInMethod}');
      },
      verificationFailed: (error) {
        print('object firebase phone verificationFailed email ${error.email}');
        print('object firebase phone verificationFailed phoneNumber ${error.phoneNumber}');
        print('object firebase phone verificationFailed message ${error.message}');
        print('object firebase phone verificationFailed code ${error.code}');
      },
      codeSent: (verificationId, forceResendingToken) {
        print('object firebase phone codeSent verificationId $verificationId forceResendingToken $forceResendingToken');
        // context.router.push(PinPutRoute(phoneNumber: phone, verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print('object firebase phone verificationId $verificationId');
      },
    );
  }

  static Future<UserCredential?> verifyCode(String verificationId, String code) async {
    print('object firebase verifyCode $code and verification id $verificationId');
    try {
      final cred = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
      print('object firebase verifyCode cred ${cred.verificationId}');

      final userCredential = await instance.signInWithCredential(cred);

      return userCredential;

    } catch (e) {
      print('object firebase verifyCode catch error $e');
      return null;
    }
  }

  static Future<User?> signInWithGoogle() async {
    await googleSignIn.initialize();
    final authenticate = await googleSignIn.authenticate(scopeHint: ['email']);
    final authClient = googleSignIn.authorizationClient;
    final authorization = await authClient.authorizationForScopes(['email']);
    final credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: authenticate.authentication.idToken,
    );
    final userCredential = await instance.signInWithCredential(credential);
    return userCredential.user;

    // final googleAccount = await googleSignIn.authenticate();
    // final googleAuth = googleAccount.authentication;

    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );
    // final userCredential = await instance.signInWithCredential(credential);
    // return userCredential.user;
  }

  static Future<AppleUser?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: AppleIDAuthorizationScopes.values);
      final oAuthProvider = OAuthProvider(
        'apple.com',
      ).credential(idToken: appleCredential.identityToken, accessToken: appleCredential.authorizationCode);
      await instance.signInWithCredential(oAuthProvider);
      return AppleUser(
        email: appleCredential.email,
        familyName: appleCredential.familyName,
        name: appleCredential.givenName,
        appleToken: appleCredential.identityToken ?? '',
      );
    } catch (e) {
      return null;
    }
  }

  static Future<void> googleSignOut() {
    return googleSignIn.signOut();
  }

  static Future<User?> googleSignUp(BuildContext context) async {
    try {
      final user = await signInWithGoogle();
      return user;
    } on FirebaseAuthException {
      if (context.mounted) {
        context.showSnackBar("Google login error");
      }
      return null;
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar("Google login error");
      }
      return null;
    }
  }
}

class AppleUser {
  final String? email;
  final String? name;
  final String? familyName;
  final String appleToken;

  AppleUser({this.email, this.name, this.familyName, required this.appleToken});
}
