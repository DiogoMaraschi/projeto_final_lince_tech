import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class Camera {
  final ImagePicker _picker = ImagePicker();

  Future<String?> captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      imageQuality: 80,
    );
    if (pickedFile == null) {
      return null;
    }

    final directory = await getApplicationDocumentsDirectory();

    final extensao = p.extension(pickedFile.path);

    final fileName = 'foto_${DateTime.now().microsecondsSinceEpoch}$extensao';

    final String path = p.join(directory.path, fileName);

    await File(pickedFile.path).copy(path);

    return path;
  }
}
