import 'package:hello_pratice/features/centers/domain/entities/center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class GetCenterDetailsUsecase {
  final ICenterRepository repository;

  GetCenterDetailsUsecase(this.repository);

  Future<Center> call(String centerId) async {
    return await repository.getCenterDetails(centerId);
  }
}
