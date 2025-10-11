import 'package:hello_pratice/features/centers/domain/entities/palliative_center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class SearchCentersUsecase {
  final ICenterRepository repository;

  SearchCentersUsecase(this.repository);

  Future<List<PalliativeCenter>> call(String query) async {
    try {
       return await repository.searchCenters(query);
    } catch (e) {
      rethrow;
    }
   
  }
}
