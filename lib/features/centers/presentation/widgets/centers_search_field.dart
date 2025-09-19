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
        fillColor: AppColors.backgroundSecondary,
        prefixIcon: Icon(
          Icons.search,
          color: Color.fromRGBO(170, 183, 184, 1),
          size: 25,
        ),
        hintText: 'Search centers...',
        hintStyle: Theme.of(context).textTheme.bodySmall,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.borderSecondary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Color.fromRGBO(229, 231, 235, 1),
            width: 1,
          ),
        ),
      ),
    );
  }
}
