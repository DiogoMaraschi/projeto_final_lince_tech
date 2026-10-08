import '../repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase({required this.repository});

  Future<int> call(int id) async {
    return await repository.softDelete(id);
  }
}
