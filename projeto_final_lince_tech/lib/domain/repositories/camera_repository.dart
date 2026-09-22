import '../../data/datasources/camera_datasource.dart';

abstract class CameraRepository {
  Future<String?> captureImage();
}

class CameraRepositoryImpl implements CameraRepository {
  final CameraDatasource datasource;

  CameraRepositoryImpl({required this.datasource});

  @override
  Future<String?> captureImage() {
    return datasource.captureImage();
  }
}
