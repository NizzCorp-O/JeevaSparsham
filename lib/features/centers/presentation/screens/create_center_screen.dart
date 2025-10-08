import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/core/app_snackbar.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/create_center_form.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/image_pick_container.dart';

class CreateCenterScreen extends StatelessWidget {
  const CreateCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return BlocListener<CenterBloc, CenterState>(
      listenWhen: (previous, current) =>
          current is ImagePickFailure ||
          current is PlaceSuggestionsError ||
          current is CreateCenterError ||
          current is LocationError ||
          current is MarkerMoveError ||
          current is AddressError ||
          current is CreateCenterSuccess,
      listener: (BuildContext context, state) {
        if (state is ImagePickFailure) {
          AppSnackbar.show(context, message: state.message);
        } else if (state is PlaceSuggestionsError) {
          AppSnackbar.show(context, message: state.message);
        } else if (state is CreateCenterSuccess) {
          AppSnackbar.show(context, message: state.message);
          context.read<CenterBloc>().add(GetAllCentersEvent());
          Navigator.pop(context);
        } else if (state is CreateCenterError) {
          AppSnackbar.show(context, message: state.message);
        } else if (state is LocationError) {
          AppSnackbar.show(context, message: state.message);
        } else if (state is AddressError) {
          AppSnackbar.show(context, message: state.message);
        } else if (state is MarkerMoveError) {
          AppSnackbar.show(context, message: state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Create Center',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontSize: 20),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Divider(color: AppColors.borderPrimary, thickness: 1),
          ),
        ),
    
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Text(
                  'Center Image',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(height: 10),
              ImagePickContainer(),
              SizedBox(height: 50),
              CreateCenterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
