import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/bloc/members_bloc.dart';
import '../../application/bloc/members_event.dart';
import '../../application/bloc/members_state.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<MemberBloc, MemberState>(
      builder: (context, state) {
        
             final bloc = context.read<MemberBloc>();
        bloc.searchController ??= TextEditingController(text: '');
        if (state is MemberLoaded &&
            bloc.searchController!.text != state.searchQuery) {
          bloc.searchController!.text = state.searchQuery;
          bloc.searchController!.selection = TextSelection.fromPosition(
            TextPosition(offset: bloc.searchController!.text.length),
          );
        }
        return TextField(
          onChanged: (value) => bloc.add(SearchMembers(value)),
         controller: bloc.searchController,
         style: TextStyle(fontSize: width * 0.04),
          decoration: InputDecoration(
            hintText: "Search members...",
            hintStyle: TextStyle(
              fontFamily: "Nunito",
              fontSize: width * 0.04,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFADAEBC),
            ),
            prefixIcon:  Icon(Icons.search, size: width * 0.05, color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: height * 0.015,horizontal: width * 0.03),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 0.02),
              borderSide: const BorderSide(
                color: Color(0xFFE5E7EB),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 0.02),
              borderSide: const BorderSide(
                color: Color(0xFFE5E7EB),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 0.02),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.2,
              ),
            ),
          ),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';

// class SearchBarWidget extends StatelessWidget {
//   const SearchBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: "Search members...",
//         hintStyle: const TextStyle(
//           fontFamily: "Nunito",
//           fontSize: 16,
//           fontWeight: FontWeight.w400,
//           color: Color(0xFFADAEBC), // greyish placeholder text
//         ),
//         prefixIcon: const Icon(Icons.search, size: 20, color: Colors.black),
//         filled: true,
//         fillColor: Colors.white, // background
//         contentPadding: const EdgeInsets.symmetric(vertical: 14),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(
//             color: Color(0xFFE5E7EB), // border color
//             width: 1,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(
//             color: Color(0xFFE5E7EB),
//             width: 1,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(
//             color: Colors.black,
//             width: 1.2,
//           ),
//         ),
//       ),
//     );
//   }
// }

