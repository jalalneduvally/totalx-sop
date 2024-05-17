import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:totalx/features/home/data/model/user_model.dart';
import 'package:totalx/general/core/common/firebase_constants.dart';
import 'package:totalx/general/core/common/providers/failure.dart';
import 'package:totalx/general/core/common/providers/typedef.dart';


class SearchUserRepository {
  factory SearchUserRepository() {
    return SearchUserRepository._();
  }
  SearchUserRepository._();
  FirebaseFirestore firebaseFirestore =FirebaseFirestore.instance;
  CollectionReference get _users => firebaseFirestore.collection(Constants.users);

  QueryDocumentSnapshot? lastDocs;
  FutureEither <List<UserModel>> getSearchUsers(String search)async{
    try{
     final ref =(lastDocs==null)?
       await _users.orderBy("date",descending: true).where("search",arrayContains:search.toLowerCase().replaceAll(" ", "")).limit(8).get():
       await _users.orderBy("date",descending: true).where("search",arrayContains:search.toLowerCase().replaceAll(" ", "")).startAfterDocument(lastDocs!).limit(5).get();
       if(ref.docs.isEmpty){
        return left(Failure("no_data"));
       }else{
        lastDocs=ref.docs.last;
        return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
       }  
    }catch (e){
       return left(Failure(e.toString()));
    }
    }
}