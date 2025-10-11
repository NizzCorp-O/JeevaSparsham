import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class MakePhoneCallUseCase {
  final ICenterRepository repository;
  MakePhoneCallUseCase(this.repository);
  Future<void> call(String phoneNumber) {
    try {
      return repository.makePhoneCall(phoneNumber);
    } catch (e) {
      rethrow;
    }
  }
}
