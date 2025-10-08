import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';

class CentersSearchField extends StatelessWidget {
  const CentersSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (value.isEmpty) {
          context.read<CenterBloc>().add(GetAllCentersEvent());
        } else {
          context.read<CenterBloc>().add(SearchCenters(value));
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(249, 247, 244, 1),
        prefixIcon: Icon(
          Icons.search,
          color: Color.fromRGBO(170, 183, 184, 1),
          size: 25,
        ),
        hintText: 'Search centers...',
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Color.fromRGBO(173, 174, 188, 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.borderPrimary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.borderPrimary, width: 1),
        ),
      ),
    );
  }
}
