import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:totalx/features/home/data/enum.dart';
import 'package:totalx/features/home/data/model/user_model.dart';
import 'package:totalx/features/home/repo/user_repository.dart';
import 'package:totalx/general/services/show_message.dart';

class GetUserProvider extends ChangeNotifier{
  AgeType ageType = AgeType.all;
  void ageChange(AgeType value) {
    ageType = value;
    notifyListeners();
  }

  final ScrollController scrollController = ScrollController();

  UserRepository userRepository = UserRepository();
  List<UserModel> userlist = [];
  bool isLoading = false;

  void initFunction(){
    clearData();
    getUser();
    scrollController.addListener(() { 
      if(scrollController.position.pixels ==
          scrollController.position.maxScrollExtent&&isLoading==false){
            getUser();
          }
    });
  }

  Future<void> getUser() async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
    final data = await userRepository.getAllUsers(ageType);
    data.fold((l) {
      if (l.message == "no_data") {
        isLoading = false;
        notifyListeners();
      } else {
        log(l.message);
        isLoading = false;
        notifyListeners();
        showMessage(l.message, Colors.red);
      }
    }, (datas) {
      userlist = [...userlist, ...datas];
      isLoading = false;
      notifyListeners();
    });
  }

  void addLocalusers(UserModel user) {
    userlist.insert(0, user);
    notifyListeners();
  }

  void clearData() {
    userRepository.clearData();
    isLoading = false;
    userlist.clear();
    notifyListeners();
  }
}
