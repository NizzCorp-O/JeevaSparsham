import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';


class MapSearchBar extends StatelessWidget {
  const MapSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(hintText: "Search location.."),
            onChanged: (query) {
              if (query.isNotEmpty) {
                context.read<CenterBloc>().add(SearchLocationEvent(query));
              }
            },
          ),
        ),
      ],
    );
  }
}
