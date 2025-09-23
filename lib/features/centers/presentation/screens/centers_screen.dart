import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/core/app_snackbar.dart';
import 'package:hello_pratice/core/widgets/custom_app_bar.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/presentation/screens/create_center_screen.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/centers_search_field.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/palliative_list_builder.dart';

class CentersScreen extends StatelessWidget {
  const CentersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CenterBloc, CenterState>(
      listenWhen: (previous, current) => current is CentersError,
      listener: (BuildContext context, CenterState state) {
        if (state is CentersError) {
          AppSnackbar.show(context, message: state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'Palliative Care Centers'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CentersSearchField(),
              SizedBox(height: 30),
              Expanded(child: PalliativeListBuilder()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateCenterScreen()),
            );
          },
          backgroundColor: AppColors.quaternary,
          child: Icon(Icons.add, color: AppColors.backgroundPrimary, size: 28),
        ),
      ),
    );
  }
}
