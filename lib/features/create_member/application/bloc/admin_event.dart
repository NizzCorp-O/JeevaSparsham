part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent {}

class CreateMemberButtonPressed extends AdminEvent {
  final Member member;

  CreateMemberButtonPressed({required this.member});
}