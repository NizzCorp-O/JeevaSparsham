import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_snackbar.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/domain/entities/palliative_center.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_address_row.dart';

import 'package:hello_pratice/features/centers/presentation/widgets/center_call_button.dart';

import 'package:hello_pratice/core/widgets/custom_app_bar.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_stats_summary.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/recent_patient_list_builder.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/recent_patients_header.dart';

class CenterDetailScreen extends StatelessWidget {
  const CenterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Care Center'),
      body: BlocConsumer<CenterBloc, CenterState>(
        builder: (BuildContext context, state) {
          if (state is CenterDetailLoaded) {
            final PalliativeCenter center = state.center;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/center_image.png',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            center.name,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineLarge?.copyWith(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        CenterAddressRow(center.location),
                        SizedBox(height: 20),
                        CenterCallButton(center.phone),
                        SizedBox(height: 50),
                        CenterStatsSummary(),
                        SizedBox(height: 30),
                        RecentPatientsHeader(),
                        SizedBox(height: 20),
                        RecentPatientListBuilder(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CenterDetailLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return SizedBox();
        },
        listener: (BuildContext context, state) {
          if (state is CenterDetailsError) {
            AppSnackbar.show(context, message: state.message);
          } else if (state is PhoneCallFailure) {
            AppSnackbar.show(context, message: state.message);
          }
        },
      ),
    );
  }
}
