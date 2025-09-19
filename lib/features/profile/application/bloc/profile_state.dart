part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

//GET USER PROFILE

class UserProfileLoading extends ProfileState {}

class UserProfileLoaded extends ProfileState {
  final UserProfile user;
  UserProfileLoaded(this.user);
}

//ERROR

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
