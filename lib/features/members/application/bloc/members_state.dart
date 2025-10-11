import 'package:equatable/equatable.dart';
import '../../domain/entities/member.dart';

abstract class MemberState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberLoaded extends MemberState {
  final List<Member> members;
  final String selectedRole;
  final String searchQuery;
  final Member? selectedMember;

  MemberLoaded(
    
    this.members, {
    this.selectedRole = 'All',
    this.searchQuery = '',
    this.selectedMember
  });

   MemberLoaded copyWith({
    List<Member>? members,
    String? selectedRole,
    String? searchQuery,
    Member? selectedMember,
  }) {
    return MemberLoaded(
      members ?? this.members,
      selectedRole: selectedRole ?? this.selectedRole,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedMember: selectedMember ?? this.selectedMember,
    );
  }

  @override
  List<Object?> get props => [members, selectedRole, searchQuery,selectedMember ?? ""];
}

class MemberError extends MemberState {
  final String message;
  MemberError(this.message);

  @override
  List<Object?> get props => [message];
}

