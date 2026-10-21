import '../../../entities/profile.dart';
import '../repository.dart';

class UpdateProfileUsecase {
  final ProfileRepository repository;

  UpdateProfileUsecase({required this.repository});

  Future<int> call(Profile profile) async{

    final id =  repository.update(profile);
    print('id $id');
    return id;
  }
}