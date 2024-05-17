import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:totalx/features/home/data/model/user_model.dart';
import 'package:totalx/features/search%20user/repo/search_user_repository.dart';
import 'package:totalx/general/services/show_message.dart';

class GetUserSearchProvider extends ChangeNotifier{
   GetUserSearchProvider() {
    // getSearchUsers();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getSearchUsers();
      }
    });
  }
  final ScrollController scrollController = ScrollController();
  SearchUserRepository searchUserRepository = SearchUserRepository();
  List<UserModel> userlist = [];
  bool isMoreDataLoading = true;  
  bool isLoading = false;  
  TextEditingController searchController=TextEditingController();   

  Future<void> getSearchUsers() async {
    isLoading=true;
    final data = await searchUserRepository.getSearchUsers(searchController.text.trim());
    data.fold((l) {
      if(l.message=="no_data"){
        isMoreDataLoading=false;
        isLoading=false;
        notifyListeners();
      }else{
        log(l.message);
      showMessage(l.message, Colors.red);
      }
    }, (datas) {
      if(datas.length!=8 && datas.length!=5){
        isMoreDataLoading=false;
        log(isMoreDataLoading.toString());
      }
      log(isMoreDataLoading.toString());
      // userlist.addAll(datas);
      userlist = [...userlist,...datas];
      isLoading=false;
    notifyListeners();
    });
    notifyListeners(); 
  }
  
  void clearData(){
    userlist=[];
   searchUserRepository.lastDocs=null;
   isMoreDataLoading=true;
   userlist.clear();
   notifyListeners();
  }
}