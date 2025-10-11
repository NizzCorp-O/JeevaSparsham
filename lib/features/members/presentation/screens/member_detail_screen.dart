import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/members/application/bloc/members_bloc.dart';
import 'package:hello_pratice/features/members/application/bloc/members_event.dart';
import 'package:hello_pratice/features/members/application/bloc/members_state.dart';

import '../widgets/member_header.dart';
import '../widgets/contact_card.dart';
import '../widgets/assigned_patients_card.dart';
import '../widgets/specialization_card.dart';
import '../widgets/this_month_stats.dart';
import '../widgets/internal_notes_card.dart';

class MemberDetailScreen extends StatelessWidget {
  final String memberId;
  const MemberDetailScreen({super.key, required this.memberId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    

    return BlocProvider.value(
      // ✅ fire LoadMemberDetail ONCE when creating provider
      value: context.read<MemberBloc>()..add(LoadMemberDetail(memberId)),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: screenWidth * 0.05,
            ),
            onPressed: () => Navigator.maybePop(context),
          ),
          title: Text(
            'Member Details',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: screenWidth * 0.045,
              height: 1.0,
              letterSpacing: 0,
              fontFamily: 'Nunito',
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(color: Colors.grey.shade300, height: 1),
          ),
        ),

        body: BlocBuilder<MemberBloc, MemberState>(
          builder: (context, state) {
            if (state is MemberLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MemberError) {
              return Center(child: Text(state.message));
            } else if (state is MemberLoaded && state.selectedMember != null) {
              final member = state.selectedMember!;
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;

              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Column(
                    children: [
                      MemberHeader(member: member),
                      const SizedBox(height: 16),
                      ContactCard(member: member),
                      const SizedBox(height: 12),
                      AssignedPatientsCard(member: member),
                      const SizedBox(height: 12),
                      SpecializationSection(member: member), // ✅ skills update automatically
                      const SizedBox(height: 12),
                      StatsCard(member: member),
                      const SizedBox(height: 12),
                      InternalNotesCard(member: member),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text("No member data found"));
            }
          },
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:palliative_sample/features/members/application/bloc/members_bloc.dart';
// import 'package:palliative_sample/features/members/application/bloc/members_event.dart';
// import 'package:palliative_sample/features/members/application/bloc/members_state.dart';

// import '../widgets/member_header.dart';
// import '../widgets/contact_card.dart';
// import '../widgets/assigned_patients_card.dart';
// import '../widgets/specialization_card.dart';
// import '../widgets/this_month_stats.dart';
// import '../widgets/internal_notes_card.dart';

// class MemberDetailScreen extends StatelessWidget {
//   final String memberId;
//   const MemberDetailScreen({super.key, required this.memberId});

//   @override
//   Widget build(BuildContext context) {
//     context.read<MemberBloc>().add(LoadMemberDetail(memberId));
//     // final cardRadius = BorderRadius.circular(12.0);
//     final screenWidth = MediaQuery.of(context).size.width;
    

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black87,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: screenWidth * 0.05,
//           ),
//           onPressed: () => Navigator.maybePop(context),
//         ),
//         title: Text(
//           'Member Details',
//           style: TextStyle(
//             fontWeight: FontWeight.w400,
//             fontStyle: FontStyle.normal,
//             fontSize: screenWidth * 0.045,
//             height: 1.0,
//             letterSpacing: 0,
//             fontFamily: 'Nunito',
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(1),
//           child: Container(color: Colors.grey.shade300, height: 1),
//         ),
//       ),

//       body: BlocBuilder<MemberBloc, MemberState>(
//         builder: (context, state) {
//           if (state is MemberLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is MemberError) {
//             return Center(child: Text(state.message));
//           } else if (state is MemberLoaded && state.member != null) {
//             final member = state.member!;
//             final screenWidth = MediaQuery.of(context).size.width;
//             final screenHeight = MediaQuery.of(context).size.height;
//           return SafeArea(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.04,
//                 vertical: screenHeight * 0.01,
//               ),
//               child: Column(
//                 children: [
//                   MemberHeader(member: member),
//                   const SizedBox(height: 16),
//                   ContactCard(member: member),
//                   const SizedBox(height: 12),
//                   AssignedPatientsCard(member: member),
//                   const SizedBox(height: 12),
//                   SpecializationSection(member: member),
//                   const SizedBox(height: 12),
//                   StatsCard(member: member),
//                   const SizedBox(height: 12),
//                   InternalNotesCard(member: member),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           );
//           } else {
//             return const Center(child: Text("No member data found"));
//           }
//         },
        
//       ),
//     );
//   }
// }
