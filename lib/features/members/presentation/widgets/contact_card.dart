import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_pratice/features/members/application/bloc/members_bloc.dart';
import 'package:hello_pratice/features/members/application/bloc/members_event.dart';
import 'package:hello_pratice/features/members/domain/entities/member.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final Member member;
  const ContactCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(screenHeight * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Information",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * 0.045,
                fontStyle: FontStyle.normal,
                color: const Color(0xFF2C3E50),
                fontFamily: "Nunito",
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            // Phone Row
            if (member.phone.isNotEmpty)
              buildRow(
                context,
                svgPath: "assets/icons/call.svg",
                text: member.phone,
                buttonText: "Call",
                buttonColor: Colors.green,
                buttonIconPath: "assets/images/call_btn.png",
                onpressed: () async {
                  final uri = Uri(scheme: "tel", path: member.phone);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
              ),

            SizedBox(height: screenHeight * 0.012),

            // Mail Row
            if (member.email.isNotEmpty)
              buildRow(
                context,
                svgPath: "assets/icons/mail.svg",
                text: member.email,
                buttonText: "Send",
                buttonColor: Colors.blue,
                buttonIconPath: "assets/images/msg_btn.png",
                onpressed: () {
                  context.read<MemberBloc>().add(
                    EmailMember(member.email, member.name),
                  );
                },
              ),

            SizedBox(height: screenHeight * 0.012),

            // Location Row
            if (member.location.isNotEmpty)
              buildRow(
                context,
                svgPath: "assets/icons/location.svg",
                text: "St. Mary's Hospital, Ward",
                buttonText: "Map",
                buttonColor: Colors.white,
                buttonIconPath: "assets/icons/location_btn.svg",
                onpressed: () async {
                  final query = Uri.encodeComponent(member.address);
                  final googleMapsUrl = Uri.parse(
                    "https://www.google.com/maps/search/?api=1&query=$query",
                  );

                  if (await canLaunchUrl(googleMapsUrl)) {
                    await launchUrl(googleMapsUrl);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  /// Reusable Row Widget
  Widget buildRow(
    BuildContext context, {
    required String svgPath,
    required String text,
    required String buttonText,
    required Color buttonColor,
    required String buttonIconPath,
    required VoidCallback onpressed,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        // Left circular icon
        Container(
          width: screenWidth * 0.1,
          height: screenWidth * 0.1,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: SvgPicture.asset(
              svgPath,
              width: screenWidth * 0.05,
              height: screenWidth * 0.05,
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.03),

        // Text
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              height: 1.5,
              letterSpacing: 0,
              color: Color(0xFF566573),
            ),
          ),
        ),

        // Action Button
        ElevatedButton.icon(
          onPressed: onpressed,
          icon: buttonIconPath.endsWith(".svg")
              ? SvgPicture.asset(
                  buttonIconPath,
                  width: screenWidth * 0.04,
                  height: screenWidth * 0.04,
                )
              : Image.asset(
                  buttonIconPath,
                  width: screenWidth * 0.04,
                  height: screenWidth * 0.04,
                ),
          label: Text(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            minimumSize: Size(screenWidth * 0.25, screenWidth * 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:palliative_sample/features/members/domain/entities/member.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ContactCard extends StatelessWidget {
//   final Member member;
//   const ContactCard({super.key, required this.member});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(screenHeight * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Contact Information",
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: screenWidth * 0.045,
//                 fontStyle: FontStyle.normal,
//                 color: const Color(0xFF2C3E50),
//                 fontFamily: "Nunito",
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.015),

//             // Phone Row
//             if (member.phone.isNotEmpty)
//               buildRow(
//                 context,
//                 svgPath: "assets/call.svg",
//                 text: member.phone,
//                 buttonText: "Call",
//                 buttonColor: Colors.green,
//                 buttonIconPath: "assets/call_btn.png",
//                 onpressed: () async {
//                   final uri = Uri(scheme: "tel", path: member.phone);
//                   if (await canLaunchUrl(uri)) {
//                     await launchUrl(uri);
//                   }
//                 },
//               ),

//             SizedBox(height: screenHeight * 0.012),

//             // Mail Row
//             if (member.email.isNotEmpty)
//               buildRow(
//                 context,
//                 svgPath: "assets/mail.svg",
//                 text: member.email,
//                 buttonText: "Send",
//                 buttonColor: Colors.blue,
//                 buttonIconPath: "assets/msg_btn.png",
//                 onpressed: () async {
//                   final uri = Uri(
//                     scheme: "mailto",
//                     path: member.email,
//                     query: Uri.encodeFull(
//                       "subject=Hello Dr.&body=Hi ${member.name},",
//                     ),
//                   );

//                   if (await canLaunchUrl(uri)) {
//                     await launchUrl(uri, mode: LaunchMode.externalApplication);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Could not launch email")),
//                     );
//                   }
//                 },
//               ),

//             SizedBox(height: screenHeight * 0.012),

//             // Location Row
//             if (member.location.isNotEmpty)
//               buildRow(
//                 context,
//                 svgPath: "assets/location.svg",
//                 text: "St. Mary's Hospital, Ward",
//                 buttonText: "Map",
//                 buttonColor: Colors.white,
//                 buttonIconPath: "assets/location_btn.svg",
//                 onpressed: () async {
//                   final query = Uri.encodeComponent(member.address);
//                   final googleMapsUrl = Uri.parse(
//                     "https://www.google.com/maps/search/?api=1&query=$query",
//                   );

//                   if (await canLaunchUrl(googleMapsUrl)) {
//                     await launchUrl(googleMapsUrl);
//                   }
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Reusable Row Widget
//   Widget buildRow(
//     BuildContext context, {
//     required String svgPath,
//     required String text,
//     required String buttonText,
//     required Color buttonColor,
//     required String buttonIconPath,
//     required VoidCallback onpressed,
//   }) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Row(
//       children: [
//         // Left circular icon
//         Container(
//           width: screenWidth * 0.1,
//           height: screenWidth * 0.1,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(screenWidth * 0.02),
//             child: SvgPicture.asset(
//               svgPath,
//               width: screenWidth * 0.05,
//               height: screenWidth * 0.05,
//             ),
//           ),
//         ),
//         SizedBox(width: screenWidth * 0.03),

//         // Text
//         Expanded(
//           child: Text(
//             text,
//             style: TextStyle(
//               fontSize: screenWidth * 0.035,
//               fontFamily: "Inter",
//               fontWeight: FontWeight.w400,
//               fontStyle: FontStyle.normal,
//               height: 1.5,
//               letterSpacing: 0,
//               color: Color(0xFF566573),
//             ),
//           ),
//         ),

//         // Action Button
//         ElevatedButton.icon(
//           onPressed: onpressed,
//           icon: buttonIconPath.endsWith(".svg")
//               ? SvgPicture.asset(
//                   buttonIconPath,
//                   width: screenWidth * 0.04,
//                   height: screenWidth * 0.04,
//                 )
//               : Image.asset(
//                   buttonIconPath,
//                   width: screenWidth * 0.04,
//                   height: screenWidth * 0.04,
//                 ),
//           label: Text(buttonText),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: buttonColor,
//             minimumSize: Size(screenWidth * 0.25, screenWidth * 0.12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             textStyle: TextStyle(
//               fontSize: screenWidth * 0.035,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

