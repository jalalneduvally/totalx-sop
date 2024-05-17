import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:totalx/features/home/data/enum.dart';
import 'package:totalx/features/home/data/model/user_model.dart';
import 'package:totalx/general/core/common/firebase_constants.dart';
import 'package:totalx/general/core/common/providers/failure.dart';
import 'package:totalx/general/core/common/providers/typedef.dart';

class UserRepository {
  factory UserRepository() {
    return UserRepository._();
  }
  UserRepository._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference get _users =>
      firebaseFirestore.collection(Constants.users);

  DocumentSnapshot<Map<String, dynamic>>? lastDocs;
  bool norMoreData = false;

  // FutureEither<List<UserModel>> getAllUsers(AgeType ageType) async {

  // log("LAST DOC${lastDocs}");
  // try {
  //   QuerySnapshot<Object?> ref;
  //   if (ageType == AgeType.all) {
  //     ref = (lastDocs == null)
  //         ? await _users.orderBy("date", descending: true).limit(8).get()
  //         : await _users
  //             .orderBy("date", descending: true)
  //             .startAfterDocument(lastDocs!)
  //             .limit(5)
  //             .get();
  //   } else if (ageType == AgeType.elder) {
  //     ref = (lastDocs == null)
  //         ? await _users
  //             .orderBy("date", descending: true)
  //             .where("age", isLessThan: 60)
  //             .limit(8)
  //             .get()
  //         : await _users
  //             .orderBy("date", descending: true)
  //             .where("age", isLessThan: 60)
  //             .startAfterDocument(lastDocs!)
  //             .limit(5)
  //             .get();
  //   } else {
  //     // log(lastDocs.toString());
  //             log("22222222222");
  //             if(lastDocs!=null){
  //               //  log(lastDocs!.data().toString());
  //             }
  //      if(lastDocs == null){

  //       log("initail called");
  //      ref = await _users
  //             .orderBy("date", descending: true)
  //             // .where("age", isGreaterThanOrEqualTo: 60)
  //             .limit(8)
  //             .get();
  //             log(ref.docs.map((e) => UserModel.fromMap(e.data())).toList().first.name.toString());
  //     }else{
  //       log("More Data called");
  //     ref =   await _users
  //             // .where("age", isGreaterThanOrEqualTo: 60)
  //             .orderBy("date", descending: true)
  //             .startAfterDocument(lastDocs!)
  //             .limit(5)
  //             .get();

  //             log("DATA:${ref.docs.length}");
  //              log(ref.docs.map((e) => UserModel.fromMap(e.data())).toList().first.name.toString());
  //     }
  //         //ref =(lastDocs == null) ? await _users
  //         //     // .orderBy("date", descending: true)
  //         //     .where("age", isGreaterThanOrEqualTo: 60)
  //         //     .limit(8)
  //         //     .get()
  //         // : await _users
  //         //     // .orderBy("date", descending: true)
  //         //     .where("age", isGreaterThanOrEqualTo: 60)
  //         //     .startAfterDocument(lastDocs!)
  //         //     .limit(5)
  //         //     .get();
  //   }
  //   if (ref.docs.isEmpty) {
  //     return left(Failure("no_data"));
  //   } else {
  //     lastDocs = ref.docs.last;
  //     return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
  //   }
  // }on FirebaseException catch(e,s){
  //   log(e.message!);
  //   log(s.toString());
  //   throw e.message!;
  // } catch (e) {

  //   log("Eroor :$e");
  //   return left(Failure(e.toString()));
  // }

  FutureEither<List<UserModel>> getAllUsers(AgeType ageType) async {
    if (norMoreData) return right([]);

    int limit = lastDocs == null ? 8 : 5;
    try {
      Query query = _users;

      //FILTERING

      if (AgeType.elder == ageType) {
        query = query.where('age', isLessThanOrEqualTo: 60);
      } else if (AgeType.younger == ageType) {
        query = query.where('age', isGreaterThanOrEqualTo: 60);
      }

      query=query.orderBy('age', descending: false);

      if (lastDocs != null) {
        log("MORE DATA CALLED");

        query = query.startAfterDocument(lastDocs!);
      }

      final snapshot = await query.limit(limit).get();

      if (snapshot.docs.length < limit || snapshot.docs.isEmpty) {
        norMoreData = true;
      } else {
        lastDocs = snapshot.docs.last as DocumentSnapshot<Map<String, dynamic>>;
      }

      final userList = snapshot.docs
          .map(
            (e) => UserModel.fromMap(e.data() as Map<String, dynamic>),
          )
          .toList();
      return right(userList);
    } catch (ex) {
      log("Error:$ex");
      return left(Failure(ex.toString()));
    }
  }

  void clearData() {
    lastDocs = null;
    norMoreData = false;
  }
}
