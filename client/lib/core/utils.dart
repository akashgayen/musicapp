import 'package:client/index.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
}

Future<File?> pickAudio() async {
  try {
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<File?> pickImage() async {
  try {
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
