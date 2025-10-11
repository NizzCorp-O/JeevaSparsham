import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class DeleteCenterUsecase {
  ICenterRepository repository;
  DeleteCenterUsecase(this.repository);
  Future<void> call(String centerId) async {
    await repository.deleteCenter(centerId);
  }
}
