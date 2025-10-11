import '../entities/request.dart';

abstract class RequestRepository {
  Future<void> create(RequestEntity request);
  Stream<List<RequestEntity>> watchByPatient(String patientId);
  Stream<List<RequestEntity>> watchAllPending(String centerId); // for Admin
  Future<void> assign(String requestId, String assigneeUid);
  Future<void> updateStatus(String requestId, String status);
}
