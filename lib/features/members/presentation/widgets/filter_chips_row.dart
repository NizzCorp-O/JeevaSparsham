import 'package:flutter/material.dart';

class FilterChipsRow extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const FilterChipsRow({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.05,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: screenWidth * 0.02),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;
          return FilterChip(
            label: Text(filter,style: TextStyle(fontSize: screenWidth * 0.035,color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,),),
            selected: isSelected,
            onSelected: (_) => onFilterSelected(filter),
            selectedColor: Colors.green,
            checkmarkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.02), // responsive rounding
            ),
            // labelStyle: TextStyle(
            //   color: isSelected ? Colors.white : Colors.black,
            //   fontWeight: FontWeight.w500,
            // ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class FilterChipsRow extends StatelessWidget {
//   const FilterChipsRow({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final filters = ["All", "Admin", "Doctors", "Nurses", "Volunteers"];
//     return SizedBox(
//       height: 40,
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         scrollDirection: Axis.horizontal,
//         itemCount: filters.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 8),
//         itemBuilder: (context, index) {
//           final isSelected = index == 0;
//           return FilterChip(
//             label: Text(filters[index]),
//             selected: isSelected,
//             onSelected: (_) {},
//             selectedColor: Colors.green,
//             checkmarkColor: Colors.white,
//             labelStyle: TextStyle(
//               color: isSelected ? Colors.white : Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
