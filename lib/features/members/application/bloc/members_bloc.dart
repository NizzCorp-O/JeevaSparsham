import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/members/domain/entities/member.dart';
import 'package:url_launcher/url_launcher.dart';
import 'members_event.dart';
import 'members_state.dart';
import '../../domain/repositories/member_repository.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final MemberRepository repository;
  List<Member> _allMembers = [];
  TextEditingController? searchController;

  MemberBloc({required this.repository}) : super(MemberInitial()) {
    // on<LoadMembers>((event, emit) => _loadMembers(emit));
    on<FilterMembers>((event, emit) => _applyFilters(emit, role: event.role));
    on<SearchMembers>((event, emit) => _applyFilters(emit, query: event.query));
    on<CallMember>(_callMember);
    on<EmailMember>(_emailMember);
    on<AddSkillEvent>(_onAddSkill);
    on<RemoveSkillEvent>(_onRemoveSkill);
    on<LoadMemberDetail>(_loadMemberDetail);
     on<UpdateMemberNotes>(_onUpdateMemberNotes);
    on<LoadMembers>(_loadMembers);

     

  
    // on<LoadMemberDetail>((event, emit) => _loadMemberDetail(emit, event.memberId));
  }

  Future<void> _loadMembers(LoadMembers event,Emitter<MemberState> emit) async {
    emit(MemberLoading());
    try {
      _allMembers = await repository.getAllMembers();
      emit(MemberLoaded(_allMembers,selectedRole: event.role ?? 'All'));
    } catch (e) {
      emit(MemberError("Failed to fetch members: ${e.toString()}"));
    }
  }

  Future<void> _loadMemberDetail(LoadMemberDetail event, Emitter<MemberState> emit) async {
    emit(MemberLoading());
    try {
      _allMembers = await repository.getAllMembers();
      final member = await repository.getMemberById(event.memberId);
      if (member != null) {
        emit(MemberLoaded(_allMembers, selectedMember: member));
      } else {
        emit(MemberError("Member not found"));
      }
    } catch (e) {
      emit(MemberError("Error: $e"));
    }
  }

  void _applyFilters(Emitter<MemberState> emit, {String? role, String? query}) {
    if (state is! MemberLoaded) return;

    final currentState = state as MemberLoaded;

    final selectedRole = role ?? currentState.selectedRole;
    final searchQuery = (query ?? currentState.searchQuery).trim();

    var filtered = _allMembers;

    // Filter by role
    if (selectedRole != 'All') {
      filtered = filtered
          .where((m) => m.role.toLowerCase() == selectedRole.toLowerCase())
          .toList();
    }

    // Filter by search
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((m) {
        final name = m.name.toLowerCase();
        final phone = m.phone.toLowerCase();
        return name.contains(searchQuery.toLowerCase()) ||
            phone.contains(searchQuery.toLowerCase());
      }).toList();
    }

    emit(
      MemberLoaded(
        filtered,
        selectedRole: selectedRole,
        searchQuery: searchQuery,
      ),
    );
  }

  Future<void> _callMember(CallMember event, Emitter<MemberState> emit) async {
    final Uri launchUri = Uri(scheme: 'tel', path: event.phone);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      emit(MemberError("Could not launch ${event.phone}"));
    }
  }

Future<void> _emailMember(
  EmailMember event,
  Emitter<MemberState> emit,
) async {
  final subject = Uri.encodeComponent("Hello Dr.");
  final body = Uri.encodeComponent("Hi ${event.name},");

  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: event.email,
    query: "subject=$subject&body=$body",
  );

  try {
    await launchUrl(launchUri, mode: LaunchMode.externalApplication);
  } catch (e) {
    emit(MemberError("Could not send email to ${event.email}"));
  }
}

 // inside _onAddSkill and _onRemoveSkill we reload & emit MemberLoaded correctly

Future<void> _onAddSkill(AddSkillEvent event, Emitter<MemberState> emit) async {
  if (state is MemberLoaded) {
    final currentState = state as MemberLoaded;

    try {
      await repository.addSkill(event.memberId, event.skill);
      final updatedMember = await repository.getMemberById(event.memberId);

      if (updatedMember != null) {
        _allMembers = _allMembers.map((m) => m.id == event.memberId ? updatedMember : m).toList();
        emit(currentState.copyWith(
          members: _allMembers,
          selectedMember: updatedMember,
        ));
      }
    } catch (e) {
      emit(MemberError("Failed to add skill: $e"));
    }
  }
}


  Future<void> _onRemoveSkill(RemoveSkillEvent event, Emitter<MemberState> emit) async {
    if (state is MemberLoaded) {
      emit(MemberLoading());
      try {
        await repository.removeSkill(event.memberId, event.skill);
        final updatedMember = await repository.getMemberById(event.memberId);
        _allMembers = _allMembers.map((m) => m.id == event.memberId ? updatedMember! : m).toList();
        emit(MemberLoaded(_allMembers, selectedMember: updatedMember));
      } catch (e) {
        emit(MemberError("Failed to remove skill: $e"));
      }
    }


  }

Future<void> _onUpdateMemberNotes(
  UpdateMemberNotes event,
  Emitter<MemberState> emit,
) async {
  if (state is MemberLoaded) {
    emit(MemberLoading());
    try {
      await repository.updateNotes(event.memberId, event.notes);
      final updatedMember = await repository.getMemberById(event.memberId);

      if (updatedMember != null) {
        // update local list with the updated member
        _allMembers = _allMembers.map((m) {
          return m.id == event.memberId ? updatedMember : m;
        }).toList();

        emit(MemberLoaded(
          _allMembers,
          selectedMember: updatedMember,
        ));
      } else {
        emit(MemberError("Member not found after updating notes"));
      }
    } catch (e) {
      emit(MemberError("Failed to update notes: $e"));
    }
  }
}





  // Future<void> _loadMemberDetail(
  //   Emitter<MemberState> emit,
  //   String memberId,
  // ) async {
  //   emit(MemberLoading());
  //   try {
  //     final member = await repository.getMemberById(memberId);
  //     if (member != null) {
  //       emit(
  //         MemberLoaded(_allMembers, member: member),
  //       ); // keep list + single member
  //     } else {
  //       emit(MemberError("Member not found"));
  //     }
  //   } catch (e) {
  //     emit(MemberError("Error: ${e.toString()}"));
  //   }
  // }
}





// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:palliative_sample/features/members/application/bloc/members_event.dart';
// import 'package:palliative_sample/features/members/application/bloc/members_state.dart';
// import '../../domain/repositories/member_repository.dart';

// class MemberBloc extends Bloc<MemberEvent, MemberState> {
//   final MemberRepository repository;


//   MemberBloc({required this.repository}) : super(MemberInitial()) {
//     on<LoadMembers>((event, emit) => _loadMembers(emit));
//     on<FilterMembers>((event, emit) => _loadMembers(emit, role: event.role));
//   }

//   Future<void> _loadMembers(Emitter<MemberState> emit, {String? role}) async {
//     emit(MemberLoading());
//     try {
//       final members = role == null || role == 'All'
//           ? await repository.getAllMembers()
//           : await repository.getMembersByRole(role);

//       // Pass selectedRole to the loaded state
//       emit(MemberLoaded(members, selectedRole: role ?? 'All'));
//     } catch (e) {
//       emit(MemberError("Failed to fetch members: ${e.toString()}"));
//     }
//   }
// }


