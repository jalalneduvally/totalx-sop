import 'package:flutter/material.dart';

void showDialogCustom({
  required BuildContext context,
  required String title,
  required String action,
  required VoidCallback onPressed,
  required double w,
  required double h,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      contentTextStyle: TextStyle(
          fontWeight: FontWeight.w700, color: Colors.black, fontSize: w * 0.05),
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.white,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * 0.05)),
      actionsPadding: EdgeInsets.only(bottom: h * 0.05),
      content: SizedBox(
        height: h * 0.07,
        width: w * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(w * 0.1, h * 0.06),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(h * 0.02),
                side: const BorderSide(color: Colors.white)),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
                fontSize: w * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(w * 0.1, h * 0.06),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(h * 0.02),
                side: const BorderSide(color: Colors.white)),
          ),
          child: Text(
            action,
            style: TextStyle(
                fontSize: w * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

void showDialogLoading({
  required BuildContext context,
  required double w,
  required double h,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      contentTextStyle: TextStyle(
          fontWeight: FontWeight.w700, color: Colors.black, fontSize: w * 0.05),
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.white,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * 0.05)),
      actionsPadding: EdgeInsets.only(bottom: h * 0.05),
      content: SizedBox(
        height: h * 0.05,
        width: w * 0.25,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 10,
            ),
            Text("Please wait loading")
          ],
        ),
      ),
    ),
  );
}
