import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';
import 'package:latlong2/latlong.dart';

class PickLocationUseCase {
  final ICenterRepository repository;

  PickLocationUseCase(this.repository);

  Future<LatLng?> call(String query) async {
    
    return await repository.searchLocation(query);
  }
}
