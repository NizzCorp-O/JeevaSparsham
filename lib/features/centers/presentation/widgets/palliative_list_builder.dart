import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/presentation/screens/center_detail_screen.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_tile.dart';

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
                'No palliative centers found.',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final center = state.centers[index];
                return CenterTile(
                  icon: centerIcons[index % 6],
                  name: center.name,
                  location: center.location,
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
                'No palliative centers found.',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final center = state.centers[index];
                return CenterTile(
                  icon: centerIcons[index % 6],
                  name: center.name,
                  location: center.location,
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
