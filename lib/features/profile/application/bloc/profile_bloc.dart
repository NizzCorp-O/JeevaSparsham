import 'package:bloc/bloc.dart';
import 'package:hello_pratice/features/profile/application/usecases/get_user_profile_usecase.dart';
import 'package:hello_pratice/features/profile/domain/entities/user_profile.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUsecase getUserProfileUsecase;

  ProfileBloc(this.getUserProfileUsecase) : super(ProfileInitial()) {
    on<LoadUserProfile>((event, emit) async {
      try {
        emit(UserProfileLoading());
        final userProfile = await getUserProfileUsecase.call(event.userId);
        emit(UserProfileLoaded(userProfile));
      } catch (e) {
        emit(ProfileError( e.toString()));
      }
    });
  }
}
