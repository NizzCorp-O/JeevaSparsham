import 'package:hello_pratice/features/centers/domain/entities/palliative_center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class CreateCenterUsecase {
  final ICenterRepository repository;

  CreateCenterUsecase(this.repository);

  Future<void> call(PalliativeCenter center) async {
    return await repository.createCenter(center);
  }
}
