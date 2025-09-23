import 'package:hello_pratice/features/centers/domain/entities/center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class AddCenterUseCase {
  final ICenterRepository repository;

  AddCenterUseCase(this.repository);

  Future<void> call(Center center) async {
    return await repository.addCenter(center);
  }
}
