import 'package:hello_pratice/features/centers/domain/entities/center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class GetAllCentersUsecase {
  final ICenterRepository repository;

  GetAllCentersUsecase(this.repository);
  Future<List<Center>> call() async {
    return await repository.getAllPalliativeCenters();
  }
}
