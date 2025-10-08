import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class SearchLocationUsecase {
  final ICenterRepository repository;

  SearchLocationUsecase(this.repository);

  Future<LatLng?> call(String query) async {
    try {
      return await repository.searchLocation(query);
    } catch (e) {
      rethrow;
    }
  }
}
