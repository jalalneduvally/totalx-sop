import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:totalx/features/add%20user/repo/add_user_repository.dart';
import 'package:totalx/features/home/data/model/user_model.dart';
import 'package:totalx/features/home/presentation/provider/get_user_provider.dart';
import 'package:totalx/general/core/common/providers/storage_repository_provider.dart';
import 'package:totalx/general/core/common/search.dart';
import 'package:totalx/general/services/show_message.dart';


class AddUserController extends ChangeNotifier {
  AddUserRepository addUserRepository = AddUserRepository();
  StorageRepository storageRepository =StorageRepository();

  TextEditingController nameController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  TextEditingController numberController=TextEditingController();
  String imageUrl='';
  bool isLoading=true;


  addUsers({
    required BuildContext context,
  }) async {
    isLoading=true;
    final imageRes = await storageRepository.storeFile(
      path: 'users/${nameController.text.trim()}',
      file: imageUrl,
    );

    imageRes.fold((l) =>showMessage(l.toString(), Colors.red),
   (r) async {
      final user = await addUserRepository.addUsers(
        UserModel(
        name: nameController.text.trim(), age: int.tryParse(ageController.text.trim())??0,
          image: r, phoneNumber: numberController.text.trim(),
          date: Timestamp.now(),delete: false,id: "",
          search: keywordsBuilder(nameController.text.trim())));

      user.fold((l) => showMessage(l.toString(), Colors.red), (r) {
        context.read<GetUserProvider>().addLocalusers(r);
        showMessage("User Created successfully..!", Colors.green);
        Navigator.of(context).pop();
        imageUrl="";
        nameController.clear();
        ageController.clear();
        numberController.clear();
        isLoading=false;
        notifyListeners();
      });
    });
  }

  Future<void> userImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageUrl = image.path;
      log(imageUrl);
      notifyListeners();
    }
  }
}