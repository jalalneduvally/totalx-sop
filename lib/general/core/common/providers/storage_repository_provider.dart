import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:totalx/general/core/common/providers/typedef.dart';
import 'dart:io';
import 'failure.dart';


class StorageRepository {
  factory StorageRepository() {
    return StorageRepository._();
  }
  StorageRepository._();
  FirebaseStorage firebaseStorage =FirebaseStorage.instance;

  FutureEither<String> storeFile({
    required String path,
    required String? file
  })async{
    try{
      final ref=firebaseStorage.ref().child(path);
      UploadTask uploadTask=ref.putFile(File(file!));
      final snapshot =await uploadTask;
      return right(await snapshot.ref.getDownloadURL());
    }catch(e){
     return left(Failure(e.toString()));
    }
  }
}