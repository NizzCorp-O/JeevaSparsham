part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

/// GET USER PROFILE

class LoadUserProfile extends ProfileEvent {
  final String userId;

  LoadUserProfile(this.userId);
}
