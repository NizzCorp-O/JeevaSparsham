import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/request.dart';
import '../usecases/create_request.dart';
import '../usecases/watch_patient_requests.dart';
import '../usecases/watch_pending_requests.dart';
import '../usecases/assign_request.dart';
import '../usecases/update_request_status.dart';
import 'request_event.dart';
import 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final CreateRequest createRequest;
  final WatchPatientRequests watchRequests;
  final WatchPendingRequests watchPending;
  final AssignRequest assignRequest;
  final UpdateRequestStatus updateStatus;

  RequestBloc({
    required this.createRequest,
    required this.watchRequests,
    required this.watchPending,
    required this.assignRequest,
    required this.updateStatus,
  }) : super(RequestInitial()) {
    // Watch patient’s own requests
    on<LoadRequestsForPatient>((event, emit) async {
      emit(RequestLoading());
      await emit.forEach<List<RequestEntity>>(
        watchRequests(event.patientId),
        onData: (requests) => RequestListLoaded(requests),
        onError: (_, __) => RequestError("Failed to load patient requests"),
      );
    });

    // Watch all pending requests (Admin)
    on<LoadPendingRequests>((event, emit) async {
      emit(RequestLoading());
      await emit.forEach<List<RequestEntity>>(
        watchPending(event.centerId),
        onData: (requests) => RequestListLoaded(requests),
        onError: (_, __) => RequestError("Failed to load pending requests"),
      );
    });

    // Create request
    on<CreateRequestEvent>((event, emit) async {
      emit(RequestLoading());
      try {
        await createRequest(event.request);
        emit(RequestSuccess());
      } catch (e) {
        emit(RequestError(e.toString()));
      }
    });

    // Assign request to nurse/volunteer
    on<AssignRequestEvent>((event, emit) async {
      try {
        await assignRequest(event.requestId, event.assigneeUid);
        emit(RequestSuccess());
      } catch (e) {
        emit(RequestError(e.toString()));
      }
    });

    // Update request status
    on<UpdateRequestStatusEvent>((event, emit) async {
      try {
        await updateStatus(event.requestId, event.status);
        emit(RequestSuccess());
      } catch (e) {
        emit(RequestError(e.toString()));
      }
    });
  }
}
