import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/features/add%20user/presentation/provider/add_user_provider.dart';
import 'package:totalx/features/add%20user/presentation/view/widgets/add_button.dart';
import 'package:totalx/general/core/common/text_field.dart';
import 'package:totalx/general/services/show_dialog.dart';
import 'package:totalx/general/services/show_message.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final addUserProvider = Provider.of<AddUserController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.01,
                ),
                Text(
                  "Add A New User",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: w * 0.05),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Consumer<AddUserController>(
                    builder: (context, value, child) {
                      return value.imageUrl.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                addUserProvider.userImage();
                              },
                              child: Container(
                                height: h * 0.15,
                                width: w * 0.35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: FileImage(File(value.imageUrl)),
                                        fit: BoxFit.fill)),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                addUserProvider.userImage();
                              },
                              child: CircleAvatar(
                                radius: w * 0.2,
                                backgroundColor: Colors.grey.shade200,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: w * 0.25,
                                ),
                              ),
                            );
                    },
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                const Text(
                  "Name",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                TextFieldCustom(
                    controller: addUserProvider.nameController,
                    validator: (value) {
                      var val = value ?? '';
                      if (val.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                    hintText: "Enter Name"),
                SizedBox(
                  height: h * 0.015,
                ),
                const Text(
                  "Age",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                TextFieldCustom(
                  controller: addUserProvider.ageController,
                  validator: (value) {
                    var val = value ?? '';
                    if (val.isEmpty) {
                      return 'Please enter Age';
                    }
                    return null;
                  },
                  hintText: "Enter Age",
                  type: TextInputType.number,
                ),
                SizedBox(
                  height: h * 0.015,
                ),
                const Text(
                  "Phone No.",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                TextFieldCustom(
                  controller: addUserProvider.numberController,
                  validator: (value) {
                    if (value?.length != 10) {
                      return 'Please enter valid No';
                    }
                    return null;
                  },
                  hintText: "Enter Phone Number",
                  maxLength: 10,
                  type: TextInputType.number,
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AddButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      test: "Cancel",
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(
                      width: w * 0.03,
                    ),
                    Consumer<AddUserController>(
                      builder: (context, value, child) {
                        return AddButton(
                            onTap: () {
                              if (_formKey.currentState!.validate() &&
                                  value.imageUrl.isNotEmpty) {
                                showDialogCustom(
                                    context: context,
                                    title: "Are you sure Upload?",
                                    onPressed: () {
                                      addUserProvider.addUsers(
                                          context: context);
                                      Navigator.pop(context);
                                      if (value.isLoading) {
                                        showDialogLoading(
                                            context: context, w: w, h: h);
                                      }
                                    },
                                    w: w,
                                    h: h,
                                    action: 'Upload');
                              } else {
                                value.imageUrl.isEmpty
                                    ? showMessage(
                                        "Please Select Image", Colors.red)
                                    : null;
                              }
                            },
                            test: "Save",
                            color: Colors.blue);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
