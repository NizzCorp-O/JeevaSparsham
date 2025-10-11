import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/members/domain/entities/member.dart';
import 'package:hello_pratice/features/members/application/bloc/members_bloc.dart';
import 'package:hello_pratice/features/members/application/bloc/members_event.dart';
import 'package:hello_pratice/features/members/application/bloc/members_state.dart';

class InternalNotesCard extends StatelessWidget {
  final Member member;

  const InternalNotesCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<MemberBloc, MemberState>(
      builder: (context, state) {
        // Always pick the latest member after updates
        Member currentMember = member;
        if (state is MemberLoaded &&
            state.selectedMember != null &&
            state.selectedMember!.id == member.id) {
          currentMember = state.selectedMember!;
        }

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.015,
              horizontal: screenWidth * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Internal Notes",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: screenWidth * 0.045,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        // ✅ Capture bloc safely before async
                        final bloc = context.read<MemberBloc>();

                        final controller =
                            TextEditingController(text: currentMember.notes);

                        final newNote = await showDialog<String>(
                          context: context,
                          builder: (dialogCtx) {
                            return AlertDialog(
                              title: const Text("Add / Edit Note"),
                              content: TextField(
                                controller: controller,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  hintText: "Enter note here...",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogCtx),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pop(dialogCtx, controller.text.trim()),
                                  child: const Text("Save"),
                                ),
                              ],
                            );
                          },
                        );

                        if (newNote != null && newNote.isNotEmpty) {
                          // ✅ Use captured bloc, not context after dialog
                          bloc.add(UpdateMemberNotes(currentMember.id, newNote));
                        }
                      },
                      child: Text(
                        "+ Add Note",
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: screenWidth * 0.037,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter",
                          color: const Color(0xFF5DADE2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(screenWidth * 0.035),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F7F4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    currentMember.notes.isNotEmpty
                        ? currentMember.notes
                        : "No notes available.",
                    style: TextStyle(
                      fontSize: screenWidth * 0.037,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:palliative_sample/features/members/domain/entities/member.dart';
// import 'package:palliative_sample/features/members/application/bloc/members_bloc.dart';
// import 'package:palliative_sample/features/members/application/bloc/members_event.dart';
// import 'package:palliative_sample/features/members/application/bloc/members_state.dart';

// class InternalNotesCard extends StatelessWidget {
//   final Member member;

//   const InternalNotesCard({super.key, required this.member});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return BlocBuilder<MemberBloc, MemberState>(
//       builder: (context, state) {
//         // Pick the latest member (after update)
//         Member currentMember = member;
//         if (state is MemberLoaded && state.selectedMember != null && state.selectedMember!.id == member.id) {
//           currentMember = state.selectedMember!;
//         }

//         return Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: screenHeight * 0.015,
//               horizontal: screenWidth * 0.04,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       "Internal Notes",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: screenWidth * 0.045,
//                         fontFamily: 'Nunito',
//                         fontStyle: FontStyle.normal,
//                       ),
//                     ),
//                     const Spacer(),
//                     TextButton(
//                       onPressed: () async {
//                         final controller = TextEditingController(text: currentMember.notes);

//                         final newNote = await showDialog<String>(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: const Text("Add / Edit Note"),
//                               content: TextField(
//                                 controller: controller,
//                                 maxLines: 4,
//                                 decoration: const InputDecoration(
//                                   hintText: "Enter note here...",
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   child: const Text("Cancel"),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () => Navigator.pop(context, controller.text.trim()),
//                                   child: const Text("Save"),
//                                 ),
//                               ],
//                             );
//                           },
//                         );

//                         if (newNote != null && newNote.isNotEmpty) {
//                           context.read<MemberBloc>().add(UpdateMemberNotes(currentMember.id, newNote));
//                         }
//                       },
//                       child: Text(
//                         "+ Add Note",
//                         style: TextStyle(
//                           fontStyle: FontStyle.normal,
//                           fontSize: screenWidth * 0.037,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: "Inter",
//                           color: const Color(0xFF5DADE2),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenHeight * 0.01),
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(screenWidth * 0.035),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF9F7F4),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     currentMember.notes.isNotEmpty ? currentMember.notes : "No notes available.",
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.037,
//                       height: 1.0,
//                       fontWeight: FontWeight.w400,
//                       fontStyle: FontStyle.normal,
//                       fontFamily: 'Inter',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:palliative_sample/features/members/domain/entities/member.dart';

// class InternalNotesCard extends StatelessWidget {
//   final Member member;
//   final VoidCallback? onAddNote;
//   const InternalNotesCard({super.key,required this.member,this.onAddNote});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: screenHeight * 0.015,
//           horizontal: screenWidth * 0.04,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "Internal Notes",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: screenWidth * 0.045,
//                     fontFamily: 'Nunito',
//                     fontStyle: FontStyle.normal,
//                   ),
//                 ),
//                 const Spacer(),
//                 TextButton(
//                   onPressed:onAddNote,
//                   child: Text(
//                     "+ Add Note",
//                     style: TextStyle(
//                       fontStyle: FontStyle.normal,
//                       fontSize: screenWidth * 0.037,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: "Inter",
//                       color: Color(0xFF5DADE2),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenHeight * 0.01),
//             Container(
//               width: double.infinity,

//               padding: EdgeInsets.all(screenWidth * 0.035),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF9F7F4),
//                 borderRadius: BorderRadius.circular(8),

//                 // border: Border.all(color: Color(0xFFE5E7EB),width: 1),
//               ),
//               child: Text(
//                 member.notes.isNotEmpty
//                     ? member.notes
//                     : "No notes available.",
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.037,
//                   height: 1.0,
//                   fontWeight: FontWeight.w400,
//                   fontStyle: FontStyle.normal,
//                   fontFamily: 'Inter',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
