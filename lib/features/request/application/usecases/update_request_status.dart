import '../../domain/repositories/request_repository.dart';

class UpdateRequestStatus {
  final RequestRepository repo;
  UpdateRequestStatus(this.repo);

  Future<void> call(String requestId, String status) =>
      repo.updateStatus(requestId, status);
}
