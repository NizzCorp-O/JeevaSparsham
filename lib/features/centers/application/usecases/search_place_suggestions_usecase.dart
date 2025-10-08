import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class SearchPlaceSuggestionsUseCase {
  final ICenterRepository repository;
  SearchPlaceSuggestionsUseCase(this.repository);
  Future<List<String>> call(String query) async {
    try {
      return await repository.searchPlacesByQuery(query);
    } catch (e) {
      rethrow;
    }
  }
}
