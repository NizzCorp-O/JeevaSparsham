import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

class PickImageUseCase {
  final ICenterRepository repository;

  PickImageUseCase(this.repository);

  Future<String?> call() {
    return repository.pickImageFromGallery();
  }
}
