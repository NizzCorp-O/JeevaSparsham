import 'package:bloc/bloc.dart';
import 'package:hello_pratice/features/create_member/application/usecases/create_member.dart';
import 'package:hello_pratice/features/create_member/domain/entities/members.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';


part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final CreateMember createMemberUseCase;

  AdminBloc({required this.createMemberUseCase}) : super(AdminInitial()) {
    on<CreateMemberButtonPressed>((event, emit) async {
      emit(AdminLoading());
      try {
        await createMemberUseCase(event.member);
        emit(CreateMemberSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AdminFailure(message: e.message ?? 'Authentication Error'));
      }
      catch (e) {
        emit(AdminFailure(message: e.toString()));
      }
    });
  }
}