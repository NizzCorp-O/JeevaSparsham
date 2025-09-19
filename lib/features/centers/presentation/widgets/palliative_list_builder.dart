import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/presentation/screens/center_detail_screen.dart';

class PalliativeListBuilder extends StatelessWidget {
  const PalliativeListBuilder({super.key});

  static const List<String> centerIcons = [
    'assets/icons/palliative_center_1.svg',
    'assets/icons/palliative_center_2.svg',
    'assets/icons/palliative_center_3.svg',
    'assets/icons/palliative_center_4.svg',
    'assets/icons/palliative_center_5.svg',
    'assets/icons/palliative_center_6.svg',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<CenterBloc, CenterState>(
      buildWhen: (previous, current) =>
          current is CentersLoading ||
          current is CentersLoaded ||
          current is SearchCentersLoading ||
          current is SearchCentersLoaded,
      builder: (context, state) {
        if (state is CentersLoading || state is SearchCentersLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CentersLoaded) {
          if (state.centers.isEmpty) {
            return Center(
              child: Text(
                maxLines: 2,
                'No palliative centers available at the moment.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final center = state.centers[index];
                return Container(
                  height: screenHeight * 0.130,
                  padding: EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                      color: AppColors.borderSecondary,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      context.read<CenterBloc>().add(
                        GetCenterDetailsEvent(center.centerId),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CenterDetailScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          centerIcons[index],
                          width: 48,
                          height: 48,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                center.name,
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(fontSize: 16),
                              ),
                              Text(
                                center.location,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.secondary),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          size: 30,
                          Icons.chevron_right_rounded,
                          color: Color.fromRGBO(170, 183, 184, 1),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: state.centers.length,
            );
          }
        } else if (state is SearchCentersLoaded) {
          if (state.centers.isEmpty) {
            return Center(
              child: Text(
                maxLines: 2,
                'No palliative centers available at the moment.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final center = state.centers[index];
                return Container(
                  height: screenHeight * 0.130,
                  padding: EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                      color: AppColors.borderSecondary,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      context.read<CenterBloc>().add(
                        GetCenterDetailsEvent(center.centerId),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CenterDetailScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          centerIcons[index],
                          width: 48,
                          height: 48,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                center.name,
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(fontSize: 16),
                              ),
                              Text(
                                center.location,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.secondary),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          size: 30,
                          Icons.chevron_right_rounded,
                          color: Color.fromRGBO(170, 183, 184, 1),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: state.centers.length,
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
