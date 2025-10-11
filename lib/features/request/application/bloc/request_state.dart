import '../../domain/entities/request.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestListLoaded extends RequestState {
  final List<RequestEntity> items;
  RequestListLoaded(this.items);
}

class RequestSuccess extends RequestState {}

class RequestError extends RequestState {
  final String message;
  RequestError(this.message);
}
