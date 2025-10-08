import 'package:hello_pratice/features/centers/domain/entities/palliative_center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class EditCenterUsecase {
  final ICenterRepository repository;

  EditCenterUsecase(this.repository);

  Future<void> call({required String centerId, required PalliativeCenter center}) async {
    return await repository.editCenter(centerId: centerId, center: center);
  }
}
