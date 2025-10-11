import 'package:equatable/equatable.dart';

abstract class MemberEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMembers extends MemberEvent {
  final String? role;
  LoadMembers({this.role});
}

class FilterMembers extends MemberEvent {
  final String role;
  FilterMembers(this.role);

  @override
  List<Object?> get props => [role];
}

class SearchMembers extends MemberEvent {
  final String query;
  SearchMembers(this.query);

  @override
  List<Object?> get props => [query];
}

class CallMember extends MemberEvent {
  final String phone;
  CallMember(this.phone);

  @override
  List<Object?> get props => [phone];
}

class EmailMember extends MemberEvent {
  final String email;
  final String name;
  EmailMember(this.email, this.name);

  @override
  List<Object?> get props => [email, name];
}

class AddSkillEvent extends MemberEvent {
  final String memberId;
  final String skill;
  AddSkillEvent(this.memberId, this.skill);

  @override
  List<Object?> get props => [memberId, skill];
}

class RemoveSkillEvent extends MemberEvent {
  final String memberId;
  final String skill;
  RemoveSkillEvent(this.memberId, this.skill);

  @override
  List<Object?> get props => [memberId, skill];
}

class LoadMemberDetail extends MemberEvent {
  final String memberId;
  LoadMemberDetail(this.memberId);

  @override
  List<Object?> get props => [memberId];
}

class UpdateMemberNotes extends MemberEvent {
  final String memberId;
  final String notes;

  UpdateMemberNotes(this.memberId, this.notes);
}



