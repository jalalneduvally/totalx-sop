import 'package:flutter/material.dart';
import 'package:totalx/features/home/data/enum.dart';
import 'package:totalx/features/home/presentation/provider/get_user_provider.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({
    super.key,
    required this.h,
    required this.w, required this.state,
  });

  final double h;
  final double w;
  final GetUserProvider state;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.35,
      width: w,
      padding: EdgeInsets.only(
          top: h * 0.02, left: w * 0.03),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            "  Sort",
            style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: h * 0.01,
          ),
          RadioListTile(
              value: AgeType.all,
              activeColor: Colors.blue,
              groupValue: state.ageType,
              title: const Text("All"),
              onChanged: (value) {
                state.clearData();
                state.ageChange(AgeType.all);
                state.getUser();
                Navigator.pop(context);
              }),
          RadioListTile(
              value: AgeType.elder,
              activeColor: Colors.blue,
              groupValue: state.ageType,
              title: const Text("Age: Elder"),
              onChanged: (value) {
                state.clearData();
                state.ageChange(AgeType.elder);
                state.getUser();
                Navigator.pop(context);
              }),
          RadioListTile(
              value: AgeType.younger,
              activeColor: Colors.blue,
              groupValue: state.ageType,
              title: const Text("Age: Younger"),
              onChanged: (value) {
                state.clearData();
                state.ageChange(AgeType.younger);
                state.getUser();
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}