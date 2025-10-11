import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/members/application/bloc/members_bloc.dart';
import 'package:hello_pratice/features/members/application/bloc/members_event.dart';
import 'package:hello_pratice/features/members/application/bloc/members_state.dart';

import '../../domain/entities/member.dart';

class SpecializationSection extends StatelessWidget {
  final Member member;
  const SpecializationSection({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberBloc, MemberState>(
      builder: (context, state) {
        Member currentMember = member;

        // update state after add/remove
        if (state is MemberLoaded &&
            state.selectedMember != null &&
            state.selectedMember!.id == member.id) {
          currentMember = state.selectedMember!;
        }

        if (state is MemberLoading && state is! MemberLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Specialization",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final bloc = context
                            .read<MemberBloc>(); // save reference
                        final skill = await _showAddSkillDialog(context);
                        if (skill != null &&
                            skill.isNotEmpty &&
                            !member.skill.contains(skill)) {
                          bloc.add(AddSkillEvent(member.id, skill));
                        }
                      },
                      child: const Text(
                        "+ Add Skill",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Skills list
                if (currentMember.skill.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: currentMember.skill.map((skill) {
                      return SkillChip(
                        label: skill,
                        memberId: currentMember.id,
                      );
                    }).toList(),
                  )
                else
                  const Text(
                    "No skills added yet",
                    style: TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> _showAddSkillDialog(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Skill"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter skill name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String label;
  final String memberId;

  const SkillChip({super.key, required this.label, required this.memberId});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          color: Color(0xFF5DADE2),
        ),
      ),
      backgroundColor: const Color(0x335DADE2), // light blue
      shape: StadiumBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      deleteIcon: const Icon(Icons.close, size: 18, color: Color(0xFF5DADE2)),
      onDeleted: () {
        context.read<MemberBloc>().add(RemoveSkillEvent(memberId, label));
      },
    );
  }
}


