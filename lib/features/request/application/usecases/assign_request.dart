import '../../domain/repositories/request_repository.dart';

class AssignRequest {
  final RequestRepository repo;
  AssignRequest(this.repo);

  Future<void> call(String requestId, String assigneeUid) =>
      repo.assign(requestId, assigneeUid);
}
