import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:totalx/features/home/data/model/user_model.dart';
import 'package:totalx/general/core/common/firebase_constants.dart';
import 'package:totalx/general/core/common/providers/failure.dart';
import 'package:totalx/general/core/common/providers/typedef.dart';

class AddUserRepository {
  factory AddUserRepository() {
    return AddUserRepository._();
  }
  AddUserRepository._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference get _users =>
      firebaseFirestore.collection(Constants.users);

  FutureEither<UserModel> addUsers(UserModel userModel) async {
    try {
      final id = _users.doc().id;
      await _users.doc(id).set(userModel.copyWith(id: id).toMap());
      return right(userModel.copyWith(id: id));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
