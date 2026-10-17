import './datasources/camera_datasource.dart';

abstract class ImagePickerRepository {
  Future<String?> captureImage();
  Future<String?> pickImageFromGalery();
}

class ImagePickerRepositoryImpl implements ImagePickerRepository {
  final ImagePickerDatasource datasource;

  ImagePickerRepositoryImpl({required this.datasource});

  @override
  Future<String?> captureImage() {
    return datasource.captureImage();
  }

  @override
  Future<String?> pickImageFromGalery() {
    return datasource.pickImageFromGallery();
  }
}
