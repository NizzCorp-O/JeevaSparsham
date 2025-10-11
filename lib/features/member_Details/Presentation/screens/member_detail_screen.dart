// import 'package:flutter/material.dart';
// import '../../../members/presentation/widgets/member_header.dart';
// import '../../../members/presentation/widgets/contact_card.dart';
// import '../../../members/presentation/widgets/assigned_patients_card.dart';
// import '../../../members/presentation/widgets/specialization_card.dart';
// import '../../../members/presentation/widgets/this_month_stats.dart';
// import '../../../members/presentation/widgets/internal_notes_card.dart';

// class MemberDetailScreen extends StatelessWidget {
//   const MemberDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final cardRadius = BorderRadius.circular(12.0);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

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
//         title:  Text(
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

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
//           child: Column(
//             children: const [
//               MemberHeader(),
//               SizedBox(height: 16),
//               ContactCard(),
//               SizedBox(height: 12),
//               AssignedPatientsCard(),
//               SizedBox(height: 12),
//               SpecializationSection(),
//               SizedBox(height: 12),
//               StatsCard(),
//               SizedBox(height: 12),
//               InternalNotesCard(),
//               SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
