import 'package:bloc/bloc.dart';
import 'package:hello_pratice/features/auth/application/usecases/check_user_role_usecase.dart';
import 'package:hello_pratice/features/auth/application/usecases/login_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final CheckUserRoleUsecase checkUserRoleUsecase;

  AuthBloc({required this.loginUsecase, required this.checkUserRoleUsecase})
    : super(AuthInitial()) {
    //LOG IN
    on<LoginRequested>((event, emit) async {
      try {
        emit(LoginLoading());
        final userId = await loginUsecase.call(
          email: event.email,
          password: event.password,
        );
        final userRole = await checkUserRoleUsecase.call(userId!);
        emit(LoginSuccess("Login successful.", userId: userId, role: userRole));
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });

    //LogOut

    on<LogoutRequested>((event, emit) async {
      emit(LoginLoading());
      try {
       // await repository.logout();
        emit(AuthUnauthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
