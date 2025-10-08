import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';

// ignore: must_be_immutable
class CenterLocationField extends StatelessWidget {
  final TextEditingController locationController;
  Timer? debounce;
  CenterLocationField({
    super.key,
    required this.locationController,
    required this.debounce,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location', style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: 10),
        TextFormField(
          controller: locationController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Location is required';
            } else if (value.trim().length < 3) {
              return 'Enter a valid location';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isEmpty) {
              // ignore: use_build_context_synchronously
              context.read<CenterBloc>().add(ClearPlaceSuggestionsEvent());
            } else {
              // ignore: use_build_context_synchronously
              if (debounce?.isActive ?? false) debounce!.cancel();

              debounce = Timer(const Duration(milliseconds: 500), () {
                context.read<CenterBloc>().add(
                  SearchPlaceSuggestionsEvent(value),
                );
              });
            }
          },
          decoration: InputDecoration(
            hintText: 'Select location',
            prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
