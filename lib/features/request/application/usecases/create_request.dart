import '../../domain/entities/request.dart';
import '../../domain/repositories/request_repository.dart';

class CreateRequest {
  final RequestRepository repo;
  CreateRequest(this.repo);

  Future<void> call(RequestEntity request) => repo.create(request);
}

