import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImagePickerDatasource {
  final ImagePicker _picker = ImagePicker();

  Future<String?> captureImage() {
    return _pickAndSaveImage(ImageSource.camera);
  }

  Future<String?> pickImageFromGallery() {
    return _pickAndSaveImage(ImageSource.gallery);
  }

  Future<String?> _pickAndSaveImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 1000,
      imageQuality: 80,
    );

    if (pickedFile == null) return null;

    final directory = await getApplicationDocumentsDirectory();
    final extension = p.extension(pickedFile.path);
    final fileName = 'foto_${DateTime.now().microsecondsSinceEpoch}$extension';
    final path = p.join(directory.path, fileName);

    await File(pickedFile.path).copy(path);
    return path;
  }
}
