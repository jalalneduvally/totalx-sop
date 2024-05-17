import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/features/add%20user/presentation/view/screen/add_user_screen.dart';
import 'package:totalx/features/home/data/model/user_model.dart';
import 'package:totalx/features/home/presentation/provider/get_user_provider.dart';
import 'package:totalx/features/home/presentation/view/widgets/search_textfield.dart';
import 'package:totalx/features/home/presentation/view/widgets/sort_bottom_sheet.dart';
import 'package:totalx/features/home/presentation/view/widgets/userlist_widget.dart';
import 'package:totalx/features/login/presentation/provider/auth_provider.dart';
import 'package:totalx/features/search%20user/presentation/view/screen/search_user_screen.dart';
import 'package:totalx/general/core/common/loader.dart';
import 'package:totalx/general/services/show_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    log("RESart");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetUserProvider>().initFunction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final authProvider=Provider.of<AuthController>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        title: const Text(
          "Nilambur",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialogCustom(
                    context: context,
                    title: "Are you sure..?",
                    action: "LogOut",
                    onPressed: () {
                      authProvider.logout(context);
                    },
                    w: w,
                    h: h);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddUserScreen(),
              ));
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SearchTextField(
                    hintText: 'search by name & no.',
                    w: w,
                    h: h,
                    readOnly: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchUserScreen(),
                          ));
                    },
                  ),
                ),
                SizedBox(
                  width: w * 0.03,
                ),
                Expanded(
                    flex: 1,
                    child: Consumer<GetUserProvider>(
                      builder: (context, state, child) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(w * 0.06),
                                      topRight: Radius.circular(w * 0.06))),
                              builder: (context) {
                                return SortBottomSheet(h: h, w: w,state: state,);
                              },
                            );
                          },
                          child: Container(
                              height: h * 0.05,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.circular(w * 0.03)),
                              child: const Icon(
                                Icons.sort,
                                color: Colors.white,
                              )),
                        );
                      },
                    ))
              ],
            ),
            SizedBox(
              height: h * 0.015,
            ),
            Row(
              children: [
                Text(
                  "Users Lists",
                  style: TextStyle(
                      fontSize: w * 0.04, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Consumer<GetUserProvider>(
              builder: (context, userData, child) {
                return   (userData.userlist.isEmpty&&userData.isLoading)? const Loader()   : userData.userlist.isEmpty
                    ? const Center(
                        child: Text(
                          "No Data.!",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                                    userData.isLoading)
                                  const Loader()
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
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


