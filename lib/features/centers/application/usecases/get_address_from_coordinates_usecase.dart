import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class GetAddressFromCoordinatesUseCase {
  final ICenterRepository repository;

  GetAddressFromCoordinatesUseCase(this.repository);

  Future<String?> call({required double lat, required double lon}) async {
    try {
      final address = await repository.getAddressFromCoordinates(
        lat: lat,
        lon: lon,
      );
      return address;
    } catch (e) {
      rethrow;
    }
  }
}
