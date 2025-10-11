import '../../domain/entities/request.dart';

abstract class RequestEvent {}

class LoadRequestsForPatient extends RequestEvent {
  final String patientId;
  LoadRequestsForPatient(this.patientId);
}

class LoadPendingRequests extends RequestEvent {
  final String centerId;
  LoadPendingRequests(this.centerId);
}

class CreateRequestEvent extends RequestEvent {
  final RequestEntity request;
  CreateRequestEvent(this.request);
}

class RequestsUpdated extends RequestEvent {
  final List<RequestEntity> items;
  RequestsUpdated(this.items);
}

class AssignRequestEvent extends RequestEvent {
  final String requestId;
  final String assigneeUid;
  AssignRequestEvent(this.requestId, this.assigneeUid);
}

class UpdateRequestStatusEvent extends RequestEvent {
  final String requestId;
  final String status;
  UpdateRequestStatusEvent(this.requestId, this.status);
}
