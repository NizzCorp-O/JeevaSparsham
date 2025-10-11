part of 'admin_bloc.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminLoading extends AdminState {}

final class CreateMemberSuccess extends AdminState {}

final class AdminFailure extends AdminState {
  final String message;

  AdminFailure({required this.message});
}