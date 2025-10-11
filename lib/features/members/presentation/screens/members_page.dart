import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_pratice/features/create_member/presentation/pages/create_member_page.dart';
import 'package:hello_pratice/features/members/presentation/screens/member_detail_screen.dart';
import '../widgets/member_card.dart';
import '../widgets/filter_chips_row.dart';
import '../widgets/search_bar.dart';
import '../../application/bloc/members_bloc.dart';
import '../../application/bloc/members_event.dart';
import '../../application/bloc/members_state.dart';
import '../../infrastructure/firebase_member_repository.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = MemberFirebaseRepository(
      firestore: FirebaseFirestore.instance,
    );
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => MemberBloc(repository: repository)..add(LoadMembers()),
      child: BlocListener<MemberBloc, MemberState>(
        listener: (context, state) {
          if (state is MemberError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<MemberBloc, MemberState>(
          builder: (context, state) {
            // String selectedRole = 'All';
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: const Icon(Icons.arrow_back, color: Colors.black),
                title: Text(
                  "Members",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: SearchBarWidget(),
                  ),
                  FilterChipsRow(
                    filters: ["All", "Admin", "Doctor", "Nurse", "Volunteer"],
                    selectedFilter: state is MemberLoaded
                        ? state.selectedRole
                        : 'All',
                    onFilterSelected: (role) {
                      // selectedRole = role;
                      context.read<MemberBloc>().add(FilterMembers(role));
                    },
                  ),
                  Expanded(child: _buildMemberList(state, screenWidth)),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateMemberScreen(),
                    ),
                  );
                },
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: screenWidth * 0.07,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMemberList(MemberState state, double screenWidth) {
    if (state is MemberLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MemberLoaded) {
      final members = state.members;
      if (members.isEmpty) return const Center(child: Text("No members found"));
      return ListView.builder(
        padding: EdgeInsets.all(screenWidth * 0.03),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return MemberCard(
            name: member.name,
            phone: member.phone,
            role: member.role,
            roleColor: getRoleColor(member.role),
            avatarUrl: member.avatarUrl,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemberDetailScreen(memberId: member.id),
                ),
              );
            },
          );
        },
      );
    } else if (state is MemberError) {
      return Center(child: Text(state.message));
    } else {
      return const SizedBox.shrink();
    }
  }

  Color getRoleColor(String role) {
    switch (role) {
      case "Doctor":
        return const Color(0xFF4CAF50);
      case "Nurse":
        return const Color(0xFF2196F3);
      case "Admin":
        return const Color(0xFFFF9800);
      case "Volunteer":
        return const Color(0xFF03A9F4);
      default:
        return Colors.grey;
    }
  }
}

// import 'package:flutter/material.dart';
// import '../widgets/filter_chips_row.dart';
// import '../widgets/member_card.dart';
// import '../widgets/search_bar.dart';

// class MembersPage extends StatelessWidget {
//   const MembersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: const Icon(Icons.arrow_back, color: Colors.black),
//         title: const Text(
//           "Members",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(12.0),
//             child: SearchBarWidget(),
//           ),
//           const FilterChipsRow(),

//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(12),
//               children: const [
//                 MemberCard(
//                   name: "Dr. Sarah Wilson",
//                   phone: "+1 (555) 123-4567",
//                   role: "Doctor",
//                   roleColor: Color(0xFF4CAF50),
//                   avatarUrl: "https://randomuser.me/api/portraits/women/44.jpg",
//                 ),
//                 MemberCard(
//                   name: "Emily Johnson",
//                   phone: "+1 (555) 987-6543",
//                   role: "Nurse",
//                   roleColor: Color(0xFF2196F3),
//                   avatarUrl: "https://randomuser.me/api/portraits/women/55.jpg",
//                 ),
//                 MemberCard(
//                   name: "Michael Chen",
//                   phone: "+1 (555) 456-7890",
//                   role: "Admin",
//                   roleColor: Color(0xFFFF9800),
//                   avatarUrl: "https://randomuser.me/api/portraits/men/46.jpg",
//                 ),
//                 MemberCard(
//                   name: "Lisa Rodriguez",
//                   phone: "+1 (555) 321-0987",
//                   role: "Volunteer",
//                   roleColor: Color(0xFF03A9F4),
//                   avatarUrl: "https://randomuser.me/api/portraits/women/77.jpg",
//                 ),
//                 MemberCard(
//                   name: "Dr. James Anderson",
//                   phone: "+1 (555) 654-3210",
//                   role: "Doctor",
//                   roleColor: Color(0xFF4CAF50),
//                   avatarUrl: "https://randomuser.me/api/portraits/men/32.jpg",
//                 ),
//                 MemberCard(
//                   name: "Maria Garcia",
//                   phone: "+1 (555) 789-0123",
//                   role: "Nurse",
//                   roleColor: Color(0xFF2196F3),
//                   avatarUrl: "https://randomuser.me/api/portraits/women/68.jpg",
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: Colors.green,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
