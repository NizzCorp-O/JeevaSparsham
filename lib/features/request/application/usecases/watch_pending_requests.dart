import '../../domain/entities/request.dart';
import '../../domain/repositories/request_repository.dart';

class WatchPendingRequests {
  final RequestRepository repo;
  WatchPendingRequests(this.repo);

  Stream<List<RequestEntity>> call(String centerId) =>
      repo.watchAllPending(centerId);
}
