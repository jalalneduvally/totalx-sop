// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool? readOnly;
  final double w;
  final double h;
  const SearchTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly,
    required this.w,
    required this.h,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
             return SizedBox(
                    height: h * 0.055,
                    width: w,
                    child: TextFormField(
                      controller: controller,
                      onTap: onTap,
                      readOnly: readOnly??false,
                      onChanged:onChanged,
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: w * 0.02, vertical: w * 0.02),
                        hintText: hintText,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F4F8),
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                          color: Color(0xFF57636C),
                        ),
                        // suffixIcon:
                        // ref.watch(searchUserProvider).isNotEmpty
                        //     ? IconButton(
                        //   icon: const Icon(Icons.clear),
                        //   onPressed: () {
                        //     searchController.clear();
                        //     ref.read(searchUserProvider.notifier).update((state) => "");
                        //   },
                        // )
                        //     : const Icon(
                        //   Icons.shop,
                        //   color: Colors.transparent,
                        // ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF1D2429),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
  }
}
