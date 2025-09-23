import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class SearchLocationUsecase {
  final ICenterRepository repository;

  SearchLocationUsecase(this.repository);

  Future<List<String>> call(String query) async {
    return await repository.fetchPlaceSuggestions(query);
  }
}
