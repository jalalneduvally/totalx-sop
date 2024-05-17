import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/features/home/data/model/user_model.dart';
import 'package:totalx/features/home/presentation/view/widgets/search_textfield.dart';
import 'package:totalx/features/home/presentation/view/widgets/userlist_widget.dart';
import 'package:totalx/features/search%20user/presentation/provider/user_search_provider.dart';
import 'package:totalx/general/core/common/loader.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Consumer<GetUserSearchProvider>(
          builder: (context, data, child) {
            return SearchTextField(
              controller: data.searchController,
              autofocus: true,
              hintText: 'search by name & no.',
              w: w,
              h: h,
              onChanged: (value) {
                EasyDebounce.debounce(
                    'my-debouncer', 
                  const  Duration(milliseconds: 500), 
                    () {
                  if (value.isNotEmpty) {
                    data.clearData();
                    data.getSearchUsers();
                  } else {
                    data.clearData();
                  }
                } // <-- The target method
                    );
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Column(
          children: [
            Consumer<GetUserSearchProvider>(
              builder: (context, userData, child) {
                return userData.isLoading
                    ? const Loader()
                    : userData.userlist.isEmpty
                        ? Center(
                            child: Text(
                              userData.searchController.text.isNotEmpty
                                  ? "No Data.!"
                                  : "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              controller: userData.scrollController,
                              itemCount: userData.userlist.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                UserModel user = userData.userlist[index];
                                return Column(
                                  children: [
                                    UserListWidget(user: user, w: w, h: h),
                                    if (index == userData.userlist.length - 1 &&
                                        userData.isMoreDataLoading)
                                      const Loader()
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: h * 0.01,
                                );
                              },
                            ),
                          );
              },
            )
          ],
        ),
      ),
    );
  }
}
