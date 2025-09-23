import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_snackbar.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_address_row.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_call_button.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_stats_card.dart';
import 'package:hello_pratice/core/widgets/custom_app_bar.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/recent_patient_list_builder.dart';

class CenterDetailScreen extends StatelessWidget {
  const CenterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Care Center'),
      body: SingleChildScrollView(
        child: BlocConsumer<CenterBloc, CenterState>(
          buildWhen: (previous, current) =>
              current is CenterDetailLoading || current is CenterDetailLoaded,
          listenWhen: (previous, current) => current is CenterDetailsError,
          builder: (context, state) {
            if (state is CenterDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CenterDetailLoaded) {
              return Column(
                children: [
                  Image.asset(
                    'assets/images/center_image.png',
                    height: 192,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.center.name,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        CenterAddressRow(state.center.location),

                        SizedBox(height: 150),
                        CenterCallButton(state.center.phone),
                        SizedBox(height: 30),
                        Text(
                          'Summary Stats',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CenterStatsCard(
                              value: '247',
                              label: 'Total Patients',
                            ),
                            CenterStatsCard(
                              value: '34',
                              label: 'Active Patients',
                              valueColor: Color.fromRGBO(93, 173, 226, 1),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Patients',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineLarge?.copyWith(fontSize: 18),
                            ),
                            Text(
                              'View All',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontSize: 14,
                                    color: Color.fromRGBO(93, 173, 226, 1),
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        RecentPatientListBuilder(),
                      ],
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
          listener: (BuildContext context, CenterState state) {
            if (state is CenterDetailsError) {
              AppSnackbar.show(context, message: state.message);
            }
          },
        ),
      ),
    );
  }
}
