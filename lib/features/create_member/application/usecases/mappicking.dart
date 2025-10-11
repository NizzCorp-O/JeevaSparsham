
import 'package:hello_pratice/features/create_member/domain/entities/repositories/member_repository.dart';

class GetAddressFromCoordinates {
  final LocationRepository repo;

  GetAddressFromCoordinates(this.repo);

  Future<String?> call(double lat, double lon) {
    return repo.getAddressFromCoordinates(lat: lat, lon: lon);
  }
}