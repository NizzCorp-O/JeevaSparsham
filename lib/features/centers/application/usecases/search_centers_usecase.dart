import 'package:hello_pratice/features/centers/domain/entities/center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class SearchCentersUsecase {
  final ICenterRepository repository;

  SearchCentersUsecase(this.repository);

  Future<List<Center>> call(String query) async {
    return await repository.searchCenters(query);
  }
}
