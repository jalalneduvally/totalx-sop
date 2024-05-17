import 'package:image_picker/image_picker.dart';

Future pickImage() async {
  // ignore: invalid_use_of_visible_for_testing_member, deprecated_member_use
  final imageFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  return imageFile;
}