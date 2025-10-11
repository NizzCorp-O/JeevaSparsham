import 'package:hello_pratice/features/centers/domain/entities/palliative_center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class GetAllCentersUsecase {
  final ICenterRepository repository;

  GetAllCentersUsecase(this.repository);
  Future<List<PalliativeCenter>> call() async {
    try {
      return await repository.getAllPalliativeCenters();
    } catch (e) {
      rethrow;
    }
  }
}
