import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:totalx/features/login/data/model/user_model.dart';
import 'package:totalx/features/login/presentation/view/screen/phone_screen.dart';
import 'package:totalx/general/core/common/firebase_constants.dart';
import 'package:totalx/general/core/common/providers/failure.dart';
import 'package:totalx/general/core/common/providers/typedef.dart';


class AuthRepository {
  factory AuthRepository() {
    return AuthRepository._();
  }
  AuthRepository._();
  FirebaseFirestore firebaseFirestore =FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth =FirebaseAuth.instance;
  CollectionReference get _users => firebaseFirestore.collection(Constants.user);

    FutureVoid phoneSignIn(
      String phoneNumber,
      ) async {
    try {
      var user=await firebaseAuth.verifyPhoneNumber(
       phoneNumber: phoneNumber,
       //  Automatic handling of the SMS code
       verificationCompleted: (PhoneAuthCredential credential) {
         // !!! works only on android !!!
         // await _auth.signInWithCredential(credential);
       },
       // Displays a message when verification fails
       verificationFailed: (FirebaseException e) {
         if (e.code == 'invalid-phone-number') {
           if (kDebugMode) {
             print('The provided phone number is not valid.');
           }
         }
       },
       // Displays a dialog box when OTP is sent
       codeSent: ((String verificationId, int? resendToken) async {
         PhoneScreen.verify=verificationId;
       }),
       codeAutoRetrievalTimeout: (String verificationId) {
         // Auto-resolution timed out...
       },
     );
     return right(user) ;

    } catch (e) {
     return left(Failure(e.toString()));
    }
  }

  FutureEither<AuthModel>verifyOtp(
      String code,
      ) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: PhoneScreen.verify,
          smsCode: code);
           UserCredential userCredential;
           userCredential = await firebaseAuth.signInWithCredential(credential);
           DocumentReference reference =_users.doc(userCredential.user!.uid);
             AuthModel authModel;

       // var userDoc= await  reference.get();
      // if(userDoc.exists){
      if(userCredential.additionalUserInfo!.isNewUser){
        authModel = AuthModel(
          id: userCredential.user!.uid, 
        delete: false,
         reference: reference,
          phone: userCredential.user!.phoneNumber.toString(),
           createDate: DateTime.now(),
            updateDate: DateTime.now());
        await reference.set(authModel.toJson());
      }else{
        authModel = await userLogin(uid: userCredential.user!.uid);
        log(userCredential.user!.uid);
      }
      return right(authModel) ;
    } catch (e) {
      log(e.toString());
     return left(Failure(e.toString()));
    }
  }

  Future<AuthModel> userLogin({required String uid,}) async {
      AuthModel userModel=await getData(uid: uid);
      AuthModel user =userModel.copyWith(updateDate: DateTime.now());
      await user.reference.update(user.toJson());
        return userModel;
  }

  Future<AuthModel> getData({required String uid}) async {
   var user= await _users.doc(uid).get();
   AuthModel authModel=AuthModel.fromjson(user.data() as Map<String,dynamic>);
   return authModel;
  }

  // Stream<AuthModel> getUserData(String uid) {
  //   return _users.doc(uid).snapshots().map((event) => AuthModel.fromjson(event.data()));
  // }

  Future<void> logout({required VoidCallback success,required void Function(String msg) failure}) async {
    try {
      await firebaseAuth.signOut();
      success.call();
    } catch (e) {
      log("Error during logout: $e");
      failure.call(
        e.toString(),
      );
    }
  }
 
}